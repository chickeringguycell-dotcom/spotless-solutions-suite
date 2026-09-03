import 'package:test/test.dart';
import '../lib/domain/entities/pricing_settings.dart';
import '../lib/domain/services/cost_engine.dart';

void main() {
  group('CostEngine Tests', () {
    // Default settings: burden 18%, supplies 5%, equipment 3%, overhead 12%, travel $0
    final settings = PricingSettings.defaultSettings();

    test('calculates direct labor, burden, supplies, equipment, and overhead accurately', () {
      const double laborHours = 4.0;
      const double hourlyWage = 25.0; // Cleaner $25/hr

      final breakdown = CostEngine.calculateCost(
        estimatedLaborHours: laborHours,
        employeeHourlyWage: hourlyWage,
        settings: settings,
      );

      // 1. Direct Labor: 4.0 hrs * $25.00 = $100.00
      expect(breakdown.directLaborCost, equals(100.0));

      // 2. Payroll Burden: $100.00 * 18% = $18.00
      expect(breakdown.payrollBurdenCost, equals(18.0));

      // 3. Supplies Cost: $100.00 * 5% = $5.00
      expect(breakdown.suppliesCost, equals(5.0));

      // 4. Equipment Allowance: $100.00 * 3% = $3.00
      expect(breakdown.equipmentAllowanceCost, equals(3.0));

      // 5. Travel: $0.00
      expect(breakdown.travelCost, equals(0.0));

      // 6. Overhead Allocation: $100.00 * 12% = $12.00
      expect(breakdown.overheadAllocationCost, equals(12.0));

      // 7. True Job Cost = 100 + 18 + 5 + 3 + 0 + 12 = $138.00
      expect(breakdown.trueJobCostPerVisit, equals(138.0));
    });

    test('supports custom flat supplies and travel allowances', () {
      const double laborHours = 2.0;
      const double hourlyWage = 24.0; // Direct labor = $48.00

      final breakdown = CostEngine.calculateCost(
        estimatedLaborHours: laborHours,
        employeeHourlyWage: hourlyWage,
        settings: settings,
        customSuppliesCost: 15.0, // Manual supplies allowance
        customTravelCost: 20.0,   // Manual trip fee
      );

      // Direct labor = $48.00
      // Burden = 48 * 0.18 = $8.64
      // Supplies = $15.00
      // Equipment = 48 * 0.03 = $1.44
      // Travel = $20.00
      // Overhead = 48 * 0.12 = $5.76
      // Total = 48 + 8.64 + 15 + 1.44 + 20 + 5.76 = $98.84
      expect(breakdown.directLaborCost, equals(48.0));
      expect(breakdown.suppliesCost, equals(15.0));
      expect(breakdown.travelCost, equals(20.0));
      expect(breakdown.trueJobCostPerVisit, closeTo(98.84, 0.001));
    });
  });
}
