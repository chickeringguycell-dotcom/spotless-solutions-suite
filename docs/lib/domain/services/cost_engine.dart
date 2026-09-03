import '../entities/pricing_settings.dart';
import '../entities/site_data.dart';

/// Detailed breakdown of true job costs and employee hourly burdened cost.
class CostCalculationBreakdown {
  final double estimatedLaborHours;
  final double baseHourlyWage;
  final double totalPayrollBurdenPercent;
  final double trueHourlyEmployeeCost; // Base wage + payroll burden per hour

  // Cost categories (Per Visit)
  final double directLaborCost;
  final double employerPayrollTaxesCost;
  final double workersCompCost;
  final double paidLeaveCost;
  final double vacationCost;
  final double trainingCost;
  final double otherBurdenCost;
  final double totalPayrollBurdenCost;

  final double suppliesCost;
  final double equipmentAllowanceCost;
  final double travelAndMobilizationCost;
  final double overheadAllocationCost;
  final double trueJobCostPerVisit;

  const CostCalculationBreakdown({
    required this.estimatedLaborHours,
    required this.baseHourlyWage,
    required this.totalPayrollBurdenPercent,
    required this.trueHourlyEmployeeCost,
    required this.directLaborCost,
    required this.employerPayrollTaxesCost,
    required this.workersCompCost,
    required this.paidLeaveCost,
    required this.vacationCost,
    required this.trainingCost,
    required this.otherBurdenCost,
    required this.totalPayrollBurdenCost,
    required this.suppliesCost,
    required this.equipmentAllowanceCost,
    required this.travelAndMobilizationCost,
    required this.overheadAllocationCost,
    required this.trueJobCostPerVisit,
  });

  double get hourlyWage => baseHourlyWage;
  double get payrollBurdenCost => totalPayrollBurdenCost;
  double get travelCost => travelAndMobilizationCost;

  Map<String, dynamic> toJson() {
    return {
      'estimatedLaborHours': estimatedLaborHours,
      'baseHourlyWage': baseHourlyWage,
      'totalPayrollBurdenPercent': totalPayrollBurdenPercent,
      'trueHourlyEmployeeCost': trueHourlyEmployeeCost,
      'directLaborCost': directLaborCost,
      'employerPayrollTaxesCost': employerPayrollTaxesCost,
      'workersCompCost': workersCompCost,
      'paidLeaveCost': paidLeaveCost,
      'vacationCost': vacationCost,
      'trainingCost': trainingCost,
      'otherBurdenCost': otherBurdenCost,
      'totalPayrollBurdenCost': totalPayrollBurdenCost,
      'suppliesCost': suppliesCost,
      'equipmentAllowanceCost': equipmentAllowanceCost,
      'travelAndMobilizationCost': travelAndMobilizationCost,
      'overheadAllocationCost': overheadAllocationCost,
      'trueJobCostPerVisit': trueJobCostPerVisit,
    };
  }
}

/// Cost Engine for calculating true operating cost per commercial cleaning visit.
class CostEngine {
  /// Calculates all cost components, itemized payroll burdens, and true job cost.
  static CostCalculationBreakdown calculateCost({
    required double estimatedLaborHours,
    required double employeeHourlyWage,
    required PricingSettings settings,
    SiteData? site,
    double? customSuppliesCost,
    double? customEquipmentAllowance,
    double? customTravelCost,
    double? customOverheadCost,
  }) {
    // 1. Direct Labor Cost:
    // direct_labor_cost = estimated_labor_hours * employee_hourly_wage
    final double directLaborCost = estimatedLaborHours * employeeHourlyWage;

    // 2. Itemized Payroll Burden Breakdown:
    final double burdenPercent = settings.totalPayrollBurdenPercent;
    final double taxesCost = directLaborCost * settings.employerPayrollTaxesPercent;
    final double workersCompCost = directLaborCost * settings.workersCompPercent;
    final double paidLeaveCost = directLaborCost * settings.paidLeaveAllowancePercent;
    final double vacationCost = directLaborCost * settings.vacationAllowancePercent;
    final double trainingCost = directLaborCost * settings.trainingAllowancePercent;
    final double otherBurdenCost = directLaborCost * settings.otherBurdenPercent;

    final double totalPayrollBurdenCost = settings.useItemizedBurden
        ? (taxesCost + workersCompCost + paidLeaveCost + vacationCost + trainingCost + otherBurdenCost)
        : (directLaborCost * settings.manualCombinedBurdenPercent);

    // True Hourly Employee Cost = base_wage + hourly_burden
    final double trueHourlyEmployeeCost = employeeHourlyWage * (1.0 + burdenPercent);

    // 3. Supplies Cost (chemicals, trash liners, microfiber, mop heads, dispensers):
    final double suppliesCost = customSuppliesCost ??
        (settings.useFlatSupplies
            ? settings.defaultFlatSupplies
            : directLaborCost * settings.suppliesPercent);

    // 4. Equipment Allowance (backpack vacuums, auto-scrubbers, buffers amortization):
    final double equipmentAllowanceCost = customEquipmentAllowance ??
        (settings.useFlatEquipment
            ? settings.defaultFlatEquipment
            : directLaborCost * settings.equipmentAllowancePercent);

    // 5. Travel & Mobilization Cost (Mileage, Parking, Tolls, Base fee):
    double travelCost = customTravelCost ?? settings.defaultTravelCostPerVisit;
    if (site != null) {
      final double mileageCost = site.mobilization.mileage * settings.mileageRate;
      final double directFees = site.mobilization.totalDirectFees; // Parking + Tolls
      travelCost += mileageCost + directFees;
    }

    // 6. Overhead Allocation (office support, software, management, quality audit):
    final double overheadAllocationCost = customOverheadCost ??
        (settings.useFlatOverhead
            ? settings.defaultFlatOverhead
            : directLaborCost * settings.overheadPercent);

    // 7. True Job Cost per visit:
    // true_job_cost = direct_labor + payroll_burden + supplies + equipment + travel + overhead
    final double trueJobCostPerVisit = directLaborCost +
        totalPayrollBurdenCost +
        suppliesCost +
        equipmentAllowanceCost +
        travelCost +
        overheadAllocationCost;

    return CostCalculationBreakdown(
      estimatedLaborHours: estimatedLaborHours,
      baseHourlyWage: employeeHourlyWage,
      totalPayrollBurdenPercent: burdenPercent,
      trueHourlyEmployeeCost: trueHourlyEmployeeCost,
      directLaborCost: directLaborCost,
      employerPayrollTaxesCost: taxesCost,
      workersCompCost: workersCompCost,
      paidLeaveCost: paidLeaveCost,
      vacationCost: vacationCost,
      trainingCost: trainingCost,
      otherBurdenCost: otherBurdenCost,
      totalPayrollBurdenCost: totalPayrollBurdenCost,
      suppliesCost: suppliesCost,
      equipmentAllowanceCost: equipmentAllowanceCost,
      travelAndMobilizationCost: travelCost,
      overheadAllocationCost: overheadAllocationCost,
      trueJobCostPerVisit: trueJobCostPerVisit,
    );
  }
}
