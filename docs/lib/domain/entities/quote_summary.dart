import '../services/labor_calculator.dart';
import '../services/cost_engine.dart';
import '../services/pricing_engine.dart';
import 'special_service.dart';

/// Complete rollup of all computed metrics, labor, costs, margins, and special services.
class QuoteSummary {
  final LaborCalculationBreakdown laborBreakdown;
  final CostCalculationBreakdown costBreakdown;
  final PricingCalculationResult pricingResult;
  final List<SpecialService> specialServices;
  final List<String> safetyWarnings;

  const QuoteSummary({
    required this.laborBreakdown,
    required this.costBreakdown,
    required this.pricingResult,
    required this.specialServices,
    this.safetyWarnings = const [],
  });

  /// Total of one-time special service add-ons
  double get oneTimeSpecialServicesTotal {
    return specialServices
        .where((s) => !s.isRecurringMonthly)
        .fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Total of monthly recurring special service add-ons
  double get recurringSpecialServicesMonthlyTotal {
    return specialServices
        .where((s) => s.isRecurringMonthly)
        .fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Total Monthly Recurring Invoice (Base cleaning + monthly special services)
  double get totalMonthlyInvoice {
    return pricingResult.monthlyContractPrice + recurringSpecialServicesMonthlyTotal;
  }

  /// First Month Total Investment (First month recurring + all one-time deep/special services)
  double get firstMonthTotalInvestment {
    return totalMonthlyInvoice + oneTimeSpecialServicesTotal;
  }

  /// Total Annual Contract Value (including monthly recurring special services)
  double get totalAnnualContractValue {
    return (totalMonthlyInvoice * 12.0) + oneTimeSpecialServicesTotal;
  }

  Map<String, dynamic> toJson() {
    return {
      'laborBreakdown': laborBreakdown.toJson(),
      'costBreakdown': costBreakdown.toJson(),
      'pricingResult': pricingResult.toJson(),
      'specialServices': specialServices.map((s) => s.toJson()).toList(),
      'safetyWarnings': safetyWarnings,
      'oneTimeSpecialServicesTotal': oneTimeSpecialServicesTotal,
      'recurringSpecialServicesMonthlyTotal': recurringSpecialServicesMonthlyTotal,
      'totalMonthlyInvoice': totalMonthlyInvoice,
      'firstMonthTotalInvestment': firstMonthTotalInvestment,
      'totalAnnualContractValue': totalAnnualContractValue,
    };
  }
}
