import 'package:test/test.dart';
import '../lib/domain/entities/pricing_settings.dart';
import '../lib/domain/entities/service_frequency.dart';
import '../lib/domain/services/pricing_engine.dart';

void main() {
  group('PricingEngine Three-Reference & Profitability Tests', () {
    final settings = PricingSettings.defaultSettings();

    test('recommends Reference A when billing rate produces highest price', () {
      const double laborHours = 3.0;
      const double trueCost = 100.0;
      const double directLabor = 72.0;
      final frequency = ServiceFrequency.fiveTimesWeekly;

      final result = PricingEngine.calculatePrice(
        estimatedLaborHours: laborHours,
        trueJobCostPerVisit: trueCost,
        directLaborCostPerVisit: directLabor,
        frequency: frequency,
        settings: settings,
      );

      // Ref A: 3.0 * $60 = $180.00
      // Ref B: $100 / 0.60 = $166.67
      // Ref C: $125.00
      expect(result.referencePriceA, equals(180.0));
      expect(result.recommendedPricePerVisit, equals(180.0));
      expect(result.profitabilityStatus, equals(ProfitabilityStatus.green));
    });

    test('recommends Reference B when margin formula produces highest price', () {
      const double laborHours = 2.0;
      const double trueCost = 150.0;
      const double directLabor = 48.0;
      final frequency = ServiceFrequency.threeTimesWeekly;

      final result = PricingEngine.calculatePrice(
        estimatedLaborHours: laborHours,
        trueJobCostPerVisit: trueCost,
        directLaborCostPerVisit: directLabor,
        frequency: frequency,
        settings: settings,
      );

      // Ref A: 2 * 60 = 120. Ref B: 150 / 0.6 = 250. Ref C: 125.
      expect(result.referencePriceB, equals(250.0));
      expect(result.recommendedPricePerVisit, equals(250.0));
      expect(result.grossMarginPercentage, equals(0.40));
      expect(result.profitabilityStatus, equals(ProfitabilityStatus.green));
    });

    test('enforces Reference C ($125 Minimum Floor)', () {
      const double laborHours = 0.6;
      const double trueCost = 25.0;
      const double directLabor = 15.0;
      final frequency = ServiceFrequency.onceWeekly;

      final result = PricingEngine.calculatePrice(
        estimatedLaborHours: laborHours,
        trueJobCostPerVisit: trueCost,
        directLaborCostPerVisit: directLabor,
        frequency: frequency,
        settings: settings,
      );

      expect(result.referencePriceA, equals(36.0));
      expect(result.referencePriceC, equals(125.0));
      expect(result.recommendedPricePerVisit, equals(125.0));
    });

    test('flags CRITICAL status on unprofitable owner override price', () {
      const double laborHours = 3.0;
      const double trueCost = 100.0;
      const double directLabor = 72.0;
      final frequency = ServiceFrequency.fiveTimesWeekly;

      final result = PricingEngine.calculatePrice(
        estimatedLaborHours: laborHours,
        trueJobCostPerVisit: trueCost,
        directLaborCostPerVisit: directLabor,
        frequency: frequency,
        settings: settings,
        ownerOverridePricePerVisit: 90.0, // Deficit!
      );

      expect(result.finalPricePerVisit, equals(90.0));
      expect(result.profitabilityStatus, equals(ProfitabilityStatus.critical));
      expect(result.overrideWarning, isNotNull);
    });
  });
}
