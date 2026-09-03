import 'package:flutter/material.dart';
import '../entities/pricing_settings.dart';
import '../entities/service_frequency.dart';
import '../../core/constants/app_colors.dart';

enum ProfitabilityStatus {
  green,    // Healthy margin (>= 35%)
  yellow,   // Low / acceptable margin (25% - 34.99%)
  red,      // Unprofitable or below minimum (< 25%)
  critical; // Selling price <= True job cost (Deficit)

  String get label {
    switch (this) {
      case ProfitabilityStatus.green:
        return 'Healthy Margin (Green)';
      case ProfitabilityStatus.yellow:
        return 'Low Margin Alert (Yellow)';
      case ProfitabilityStatus.red:
        return 'Unprofitable / Below Floor (Red)';
      case ProfitabilityStatus.critical:
        return 'CRITICAL DEFICIT (Price <= Cost)';
    }
  }

  Color get color {
    switch (this) {
      case ProfitabilityStatus.green:
        return AppColors.success;
      case ProfitabilityStatus.yellow:
        return AppColors.warning;
      case ProfitabilityStatus.red:
        return AppColors.error;
      case ProfitabilityStatus.critical:
        return const Color(0xFF991B1B); // Deep Dark Red
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ProfitabilityStatus.green:
        return AppColors.successBackground;
      case ProfitabilityStatus.yellow:
        return AppColors.warningBackground;
      case ProfitabilityStatus.red:
        return AppColors.errorBackground;
      case ProfitabilityStatus.critical:
        return const Color(0xFFFEE2E2);
    }
  }
}

/// Result of pricing engine calculations comparing the three internal reference prices.
class PricingCalculationResult {
  // Three Internal Reference Prices
  final double referencePriceA;           // Method A: estimated_labor_hours * billing_rate
  final double referencePriceB;           // Method B: true_job_cost / (1 - target_margin)
  final double referencePriceC;           // Method C: configured_minimum_visit_charge
  final String recommendedMethodName;     // 'Target Billing Rate', 'Target Gross Margin', 'Minimum Visit Charge'

  final double recommendedPricePerVisit;  // max(A, B, C)
  final double finalPricePerVisit;        // recommended OR owner override
  final bool isOwnerOverridden;
  final String? overrideWarning;

  // Profitability Metrics Per Visit
  final double trueJobCostPerVisit;
  final double grossProfitPerVisit;       // finalPrice - trueCost
  final double grossMarginPercentage;     // grossProfit / finalPrice

  // Frequency & Recurring Contract Rollups
  final double visitsPerWeek;
  final double averageMonthlyVisits;      // weekly_visits * 52 / 12
  final double monthlyContractPrice;      // finalPrice * averageMonthlyVisits
  final double annualContractValue;       // monthlyContractPrice * 12

  // Detailed Recurring Monthly & Annual Financial Projections
  final double monthlyLaborHours;         // labor_hours * visits_per_month
  final double monthlyDirectWages;        // direct_wages * visits_per_month
  final double monthlyTrueCost;           // true_cost * visits_per_month
  final double monthlyGrossProfit;        // gross_profit * visits_per_month
  final double annualRevenue;             // monthly_contract_price * 12
  final double annualEstimatedGrossProfit; // monthly_gross_profit * 12

  // Status
  final ProfitabilityStatus profitabilityStatus;

  const PricingCalculationResult({
    required this.referencePriceA,
    required this.referencePriceB,
    required this.referencePriceC,
    required this.recommendedMethodName,
    required this.recommendedPricePerVisit,
    required this.finalPricePerVisit,
    required this.isOwnerOverridden,
    this.overrideWarning,
    required this.trueJobCostPerVisit,
    required this.grossProfitPerVisit,
    required this.grossMarginPercentage,
    required this.visitsPerWeek,
    required this.averageMonthlyVisits,
    required this.monthlyContractPrice,
    required this.annualContractValue,
    required this.monthlyLaborHours,
    required this.monthlyDirectWages,
    required this.monthlyTrueCost,
    required this.monthlyGrossProfit,
    required this.annualRevenue,
    required this.annualEstimatedGrossProfit,
    required this.profitabilityStatus,
  });

  double get methodABillingRatePrice => referencePriceA;
  double get methodBGrossMarginPrice => referencePriceB;
  double get minimumVisitCharge => referencePriceC;
  double get visitsPerMonth => averageMonthlyVisits;

  Map<String, dynamic> toJson() {
    return {
      'referencePriceA': referencePriceA,
      'referencePriceB': referencePriceB,
      'referencePriceC': referencePriceC,
      'recommendedMethodName': recommendedMethodName,
      'recommendedPricePerVisit': recommendedPricePerVisit,
      'finalPricePerVisit': finalPricePerVisit,
      'isOwnerOverridden': isOwnerOverridden,
      'overrideWarning': overrideWarning,
      'trueJobCostPerVisit': trueJobCostPerVisit,
      'grossProfitPerVisit': grossProfitPerVisit,
      'grossMarginPercentage': grossMarginPercentage,
      'visitsPerWeek': visitsPerWeek,
      'averageMonthlyVisits': averageMonthlyVisits,
      'monthlyContractPrice': monthlyContractPrice,
      'annualContractValue': annualContractValue,
      'monthlyLaborHours': monthlyLaborHours,
      'monthlyDirectWages': monthlyDirectWages,
      'monthlyTrueCost': monthlyTrueCost,
      'monthlyGrossProfit': monthlyGrossProfit,
      'annualRevenue': annualRevenue,
      'annualEstimatedGrossProfit': annualEstimatedGrossProfit,
      'profitabilityStatus': profitabilityStatus.name,
    };
  }
}

/// Pricing Engine evaluating 3 reference prices and auditing profitability.
class PricingEngine {
  /// Calculates recommended pricing, contract prices, and evaluates profitability.
  static PricingCalculationResult calculatePrice({
    required double estimatedLaborHours,
    required double trueJobCostPerVisit,
    required double directLaborCostPerVisit,
    required ServiceFrequency frequency,
    required PricingSettings settings,
    double? customBillingRate,
    double? customTargetMargin,
    double? customMinimumCharge,
    double? ownerOverridePricePerVisit,
  }) {
    final double billingRate = customBillingRate ?? settings.targetBillingRate;
    final double targetMargin = customTargetMargin ?? settings.targetGrossMargin;
    final double minimumCharge = customMinimumCharge ?? settings.minimumVisitCharge;

    // REFERENCE PRICE A: TARGET BILLING RATE
    // reference_price_a = estimated_labor_hours * billing_rate
    final double priceA = estimatedLaborHours * billingRate;

    // REFERENCE PRICE B: TARGET GROSS MARGIN
    // reference_price_b = true_job_cost / (1 - target_gross_margin)
    // Division-by-zero protection: clamp denominator to at least 0.05
    final double safeDenominator = (1.0 - targetMargin) > 0.05 ? (1.0 - targetMargin) : 0.05;
    final double priceB = trueJobCostPerVisit > 0 ? (trueJobCostPerVisit / safeDenominator) : 0.0;

    // REFERENCE PRICE C: CONFIGURED MINIMUM VISIT CHARGE
    final double priceC = minimumCharge;

    // Determine highest recommended price: MAX(A, B, C)
    String recommendedMethodName = 'Target Billing Rate (\$${billingRate.toStringAsFixed(0)}/hr)';
    double recommendedPrice = priceA;

    if (priceB > recommendedPrice) {
      recommendedPrice = priceB;
      recommendedMethodName = 'Target Gross Margin (${(targetMargin * 100).toStringAsFixed(0)}%)';
    }

    if (priceC > recommendedPrice) {
      recommendedPrice = priceC;
      recommendedMethodName = 'Minimum Visit Charge (\$${priceC.toStringAsFixed(0)})';
    }

    // Owner Override evaluation
    final bool isOverridden = ownerOverridePricePerVisit != null && ownerOverridePricePerVisit > 0;
    final double finalPrice = isOverridden ? ownerOverridePricePerVisit : recommendedPrice;

    String? overrideWarning;
    if (isOverridden) {
      if (finalPrice <= trueJobCostPerVisit) {
        overrideWarning = 'WARNING: Override price (\$${finalPrice.toStringAsFixed(2)}) is at or below true operating cost (\$${trueJobCostPerVisit.toStringAsFixed(2)}). Job will operate at a loss!';
      } else if (finalPrice < priceC) {
        overrideWarning = 'NOTICE: Override price is below the standard minimum visit charge floor (\$${priceC.toStringAsFixed(2)}).';
      }
    }

    // Profitability metrics
    final double grossProfit = finalPrice - trueJobCostPerVisit;
    final double grossMarginPercent = finalPrice > 0 ? (grossProfit / finalPrice) : 0.0;

    // Contract frequency rollups
    // average_monthly_visits = weekly_visits * 52 / 12
    final double avgMonthlyVisits = frequency.visitsPerMonth;
    final double monthlyContractPrice = finalPrice * avgMonthlyVisits;
    final double annualContractValue = monthlyContractPrice * 12.0;

    // Detailed Monthly & Annual Financial Metrics
    final double monthlyLaborHours = estimatedLaborHours * avgMonthlyVisits;
    final double monthlyDirectWages = directLaborCostPerVisit * avgMonthlyVisits;
    final double monthlyTrueCost = trueJobCostPerVisit * avgMonthlyVisits;
    final double monthlyGrossProfit = grossProfit * avgMonthlyVisits;
    final double annualRevenue = annualContractValue;
    final double annualEstimatedGrossProfit = monthlyGrossProfit * 12.0;

    // Profitability Status (GREEN / YELLOW / RED / CRITICAL)
    ProfitabilityStatus status;
    if (finalPrice <= trueJobCostPerVisit) {
      status = ProfitabilityStatus.critical;
    } else if (grossMarginPercent < settings.yellowMarginThreshold || finalPrice < priceC) {
      status = ProfitabilityStatus.red; // < 25% or below minimum
    } else if (grossMarginPercent < settings.greenMarginThreshold) {
      status = ProfitabilityStatus.yellow; // 25% - 34.99%
    } else {
      status = ProfitabilityStatus.green; // >= 35%
    }

    return PricingCalculationResult(
      referencePriceA: priceA,
      referencePriceB: priceB,
      referencePriceC: priceC,
      recommendedMethodName: recommendedMethodName,
      recommendedPricePerVisit: recommendedPrice,
      finalPricePerVisit: finalPrice,
      isOwnerOverridden: isOverridden,
      overrideWarning: overrideWarning,
      trueJobCostPerVisit: trueJobCostPerVisit,
      grossProfitPerVisit: grossProfit,
      grossMarginPercentage: grossMarginPercent,
      visitsPerWeek: frequency.visitsPerWeek,
      averageMonthlyVisits: avgMonthlyVisits,
      monthlyContractPrice: monthlyContractPrice,
      annualContractValue: annualContractValue,
      monthlyLaborHours: monthlyLaborHours,
      monthlyDirectWages: monthlyDirectWages,
      monthlyTrueCost: monthlyTrueCost,
      monthlyGrossProfit: monthlyGrossProfit,
      annualRevenue: annualRevenue,
      annualEstimatedGrossProfit: annualEstimatedGrossProfit,
      profitabilityStatus: status,
    );
  }
}
