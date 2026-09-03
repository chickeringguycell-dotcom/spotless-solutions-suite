import '../entities/site_data.dart';
import '../entities/service_frequency.dart';
import '../entities/employee_role.dart';
import '../entities/pricing_settings.dart';
import 'pricing_engine.dart';

/// Automated Quote Safety Guard.
/// Runs comprehensive safety checks prior to quote finalization to alert the owner of
/// risk factors, missing data, or negative margins without destroying entered data.
class QuoteSafetyValidator {
  static List<String> runSafetyChecks({
    required SiteData site,
    required ServiceFrequency frequency,
    required EmployeeRole role,
    required PricingSettings settings,
    required double estimatedLaborHours,
    required double trueJobCostPerVisit,
    required PricingCalculationResult pricingResult,
    double? customHourlyWage,
    double? customProductionRate,
  }) {
    final List<String> warnings = [];

    // 1. Missing or Zero Square Footage
    if (site.totalSquareFeet <= 0) {
      warnings.add('CRITICAL: Total cleanable square footage is missing or zero.');
    }

    // 2. Zero Labor Hours
    if (estimatedLaborHours <= 0 && site.totalSquareFeet > 0) {
      warnings.add('CRITICAL: Estimated labor hours calculated to zero.');
    }

    // 3. Wage Below Minimum Ladder Floor
    final double actualWage = customHourlyWage ?? role.defaultHourlyWage;
    if (actualWage < 22.0) {
      warnings.add('WARNING: Hourly wage (\$${actualWage.toStringAsFixed(2)}/hr) is below the minimum company wage ladder floor (\$22.00/hr).');
    }

    // 4. Missing or Zero Frequency
    if (frequency.visitsPerWeek <= 0) {
      warnings.add('WARNING: Cleaning frequency is zero visits per week.');
    }

    // 5. Extremely Unusual Production Rate
    final double prodRate = customProductionRate ?? settings.defaultProductionRate;
    if (prodRate < 1500) {
      warnings.add('NOTICE: Production rate (${prodRate.toStringAsFixed(0)} sqft/hr) is unusually slow (< 1,500 sqft/hr).');
    } else if (prodRate > 5000) {
      warnings.add('WARNING: Production rate (${prodRate.toStringAsFixed(0)} sqft/hr) exceeds safe commercial speed (> 5,000 sqft/hr). Risk of underbidding labor!');
    }

    // 6. Price Below True Operating Cost (Deficit)
    if (pricingResult.finalPricePerVisit <= trueJobCostPerVisit && site.totalSquareFeet > 0) {
      warnings.add('CRITICAL: Final price per visit (\$${pricingResult.finalPricePerVisit.toStringAsFixed(2)}) is at or below true operating cost (\$${trueJobCostPerVisit.toStringAsFixed(2)}). Job is operating at a financial loss!');
    }

    // 7. Price Below Configured Minimum Visit Charge
    if (pricingResult.finalPricePerVisit < settings.minimumVisitCharge) {
      warnings.add('NOTICE: Final price per visit (\$${pricingResult.finalPricePerVisit.toStringAsFixed(2)}) is below the standard minimum visit charge (\$${settings.minimumVisitCharge.toStringAsFixed(2)}).');
    }

    // 8. Low Margin Alert
    if (pricingResult.grossMarginPercentage < settings.yellowMarginThreshold && pricingResult.finalPricePerVisit > trueJobCostPerVisit) {
      warnings.add('CAUTION: Gross margin (${(pricingResult.grossMarginPercentage * 100).toStringAsFixed(1)}%) is below the healthy threshold (${(settings.greenMarginThreshold * 100).toStringAsFixed(0)}%).');
    }

    // 9. Active Owner Override
    if (pricingResult.isOwnerOverridden) {
      warnings.add('INFO: Manual owner override price active (\$${pricingResult.finalPricePerVisit.toStringAsFixed(2)}/visit). Automated recommendation overridden.');
    }

    return warnings;
  }
}
