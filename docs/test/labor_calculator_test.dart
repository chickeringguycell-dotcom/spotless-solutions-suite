import 'package:test/test.dart';
import '../lib/domain/entities/site_data.dart';
import '../lib/domain/entities/pricing_settings.dart';
import '../lib/domain/services/labor_calculator.dart';

void main() {
  group('LaborCalculator Multi-Stage Tests', () {
    final settings = PricingSettings.defaultSettings();

    test('1,000 sq ft small office with 1 toilet, 1 sink, 1 breakroom', () {
      const site = SiteData(
        totalSquareFeet: 1000,
        toiletsCount: 1,
        sinksCount: 1,
        standardBreakroomsCount: 1,
        trafficLevel: TrafficLevel.low,  // 1.00x
        trashLevel: TrashLevel.light,    // 1.00x
        siteCondition: SiteCondition.normal, // 1.00x
        entrancesCount: 0,
      );

      final breakdown = LaborCalculator.calculateLaborHours(site: site, settings: settings);
      // Base = (1000/3000)*60 = 20 min
      // Restroom = 5 (toilet) + 2 (sink) = 7 min
      // Breakroom = 10 min
      // Total = 37 min -> 37/60 = 0.6167 hr
      expect(breakdown.baseCleaningMinutes, equals(20.0));
      expect(breakdown.totalRestroomMinutes, equals(7.0));
      expect(breakdown.totalBreakroomMinutes, equals(10.0));
      expect(breakdown.finalTotalMinutes, equals(37.0));
      expect(breakdown.totalEstimatedHoursPerVisit, closeTo(37.0 / 60.0, 0.001));
    });

    test('5,000 sq ft normal office with multiple fixtures and normal multipliers', () {
      const site = SiteData(
        totalSquareFeet: 5000,
        toiletsCount: 3,
        urinalsCount: 1,
        sinksCount: 4,
        standardBreakroomsCount: 1,
        conferenceRoomsCount: 2,
        entrancesCount: 1,
        trafficLevel: TrafficLevel.normal, // 1.05x
        trashLevel: TrashLevel.normal,     // 1.05x
        siteCondition: SiteCondition.normal, // 1.00x
      );

      final breakdown = LaborCalculator.calculateLaborHours(site: site, settings: settings);
      // Base: (5000/3000)*60 = 100 min
      // Restroom: (3*5) + (1*3) + (4*2) = 15 + 3 + 8 = 26 min
      // Breakroom: 10 min
      // Conference: 2*3 = 6 min
      // Entrance: 1*5 = 5 min
      // Subtotal = 100 + 26 + 10 + 6 + 5 = 147 min
      // Multipliers: 1.05 * 1.05 = 1.1025
      // Final = 147 * 1.1025 = 162.0675 min (2.701 hrs)
      expect(breakdown.baseCleaningMinutes, equals(100.0));
      expect(breakdown.totalRestroomMinutes, equals(26.0));
      expect(breakdown.unadjustedSubtotalMinutes, equals(147.0));
      expect(breakdown.finalTotalMinutes, closeTo(162.0675, 0.001));
    });

    test('Multiple restroom facility with showers', () {
      const site = SiteData(
        totalSquareFeet: 4000,
        toiletsCount: 4,
        urinalsCount: 2,
        sinksCount: 6,
        showersCount: 2,
        trafficLevel: TrafficLevel.low,
        trashLevel: TrashLevel.light,
        siteCondition: SiteCondition.normal,
        entrancesCount: 0,
      );

      final breakdown = LaborCalculator.calculateLaborHours(site: site, settings: settings);
      // Restrooms: (4*5) + (2*3) + (6*2) + (2*8) = 20 + 6 + 12 + 16 = 54 min
      expect(breakdown.totalRestroomMinutes, equals(54.0));
    });
  });
}
