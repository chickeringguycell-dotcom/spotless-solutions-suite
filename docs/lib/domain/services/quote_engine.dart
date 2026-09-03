import '../entities/site_data.dart';
import '../entities/service_frequency.dart';
import '../entities/employee_role.dart';
import '../entities/pricing_settings.dart';
import '../entities/special_service.dart';
import '../entities/quote_summary.dart';
import 'labor_calculator.dart';
import 'cost_engine.dart';
import 'pricing_engine.dart';
import 'quote_safety_validator.dart';

/// Unified Quote Calculation Orchestrator.
class QuoteEngine {
  /// Generates a complete QuoteSummary rollup from the input parameters and settings.
  static QuoteSummary calculateQuoteSummary({
    required SiteData site,
    required ServiceFrequency frequency,
    required EmployeeRole role,
    required PricingSettings settings,
    double? customProductionRate,
    double? customHourlyWage,
    double? customBillingRate,
    double? customTargetMargin,
    double? customMinimumCharge,
    double? ownerOverridePricePerVisit,
    List<SpecialService> specialServices = const [],
    double? customSuppliesCost,
    double? customEquipmentAllowance,
    double? customTravelCost,
    double? customOverheadCost,
  }) {
    // 1. Calculate multi-stage labor breakdown and hours
    final LaborCalculationBreakdown laborBreakdown = LaborCalculator.calculateLaborHours(
      site: site,
      settings: settings,
      customProductionRate: customProductionRate,
    );

    // 2. Determine base hourly wage
    final double hourlyWage = customHourlyWage ?? role.defaultHourlyWage;

    // 3. Calculate true job cost & burdened employee rate
    final CostCalculationBreakdown costBreakdown = CostEngine.calculateCost(
      estimatedLaborHours: laborBreakdown.totalEstimatedHoursPerVisit,
      employeeHourlyWage: hourlyWage,
      settings: settings,
      site: site,
      customSuppliesCost: customSuppliesCost,
      customEquipmentAllowance: customEquipmentAllowance,
      customTravelCost: customTravelCost,
      customOverheadCost: customOverheadCost,
    );

    // 4. Calculate recommended price, reference prices, contract values, and margin status
    final PricingCalculationResult pricingResult = PricingEngine.calculatePrice(
      estimatedLaborHours: laborBreakdown.totalEstimatedHoursPerVisit,
      trueJobCostPerVisit: costBreakdown.trueJobCostPerVisit,
      directLaborCostPerVisit: costBreakdown.directLaborCost,
      frequency: frequency,
      settings: settings,
      customBillingRate: customBillingRate,
      customTargetMargin: customTargetMargin,
      customMinimumCharge: customMinimumCharge,
      ownerOverridePricePerVisit: ownerOverridePricePerVisit,
    );

    // 5. Run automated quote safety check
    final List<String> safetyWarnings = QuoteSafetyValidator.runSafetyChecks(
      site: site,
      frequency: frequency,
      role: role,
      settings: settings,
      estimatedLaborHours: laborBreakdown.totalEstimatedHoursPerVisit,
      trueJobCostPerVisit: costBreakdown.trueJobCostPerVisit,
      pricingResult: pricingResult,
      customHourlyWage: customHourlyWage,
      customProductionRate: customProductionRate,
    );

    return QuoteSummary(
      laborBreakdown: laborBreakdown,
      costBreakdown: costBreakdown,
      pricingResult: pricingResult,
      specialServices: specialServices,
      safetyWarnings: safetyWarnings,
    );
  }
}
