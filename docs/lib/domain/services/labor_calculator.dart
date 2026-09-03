import '../entities/site_data.dart';
import '../entities/pricing_settings.dart';
import '../entities/labor_adjustment.dart';

/// Detailed breakdown of calculated labor minutes and hours across every calculation stage.
class LaborCalculationBreakdown {
  // Stage 1: Base General Cleaning Minutes
  final double baseCleaningMinutes;

  // Stage 2: Fixed Additive Minutes
  final double restroomBaseMinutes;
  final double toiletMinutes;
  final double urinalMinutes;
  final double sinkMinutes;
  final double showerMinutes;
  final double totalRestroomMinutes;

  final double standardBreakroomMinutes;
  final double largeKitchenMinutes;
  final double totalBreakroomMinutes;

  final double conferenceRoomMinutes;
  final double entranceMinutes;
  final double stairMinutes;
  final double elevatorMinutes;
  final double securityMinutes;
  final double mobilizationMinutes;

  // Stage 3: Subtotal Minutes before Multipliers
  final double unadjustedSubtotalMinutes;

  // Stage 4: Applied Complexity Multipliers
  final double trafficMultiplier;
  final double trashMultiplier;
  final double conditionMultiplier;
  final double sanitationMultiplier;
  final double compositeMultiplier;

  // Stage 5: Final Calculated Labor Minutes & Hours
  final double finalTotalMinutes;
  final double totalEstimatedHoursPerVisit;

  const LaborCalculationBreakdown({
    required this.baseCleaningMinutes,
    required this.restroomBaseMinutes,
    required this.toiletMinutes,
    required this.urinalMinutes,
    required this.sinkMinutes,
    required this.showerMinutes,
    required this.totalRestroomMinutes,
    required this.standardBreakroomMinutes,
    required this.largeKitchenMinutes,
    required this.totalBreakroomMinutes,
    required this.conferenceRoomMinutes,
    required this.entranceMinutes,
    required this.stairMinutes,
    required this.elevatorMinutes,
    required this.securityMinutes,
    required this.mobilizationMinutes,
    required this.unadjustedSubtotalMinutes,
    required this.trafficMultiplier,
    required this.trashMultiplier,
    required this.conditionMultiplier,
    required this.sanitationMultiplier,
    required this.compositeMultiplier,
    required this.finalTotalMinutes,
    required this.totalEstimatedHoursPerVisit,
  });

  double get baseHours => baseCleaningMinutes / 60.0;
  double get restroomHours => totalRestroomMinutes / 60.0;
  double get fixtureHours => (toiletMinutes + urinalMinutes + sinkMinutes + showerMinutes) / 60.0;
  double get kitchenHours => totalBreakroomMinutes / 60.0;
  double get conferenceHours => conferenceRoomMinutes / 60.0;
  double get entranceHours => entranceMinutes / 60.0;
  double get verticalTransportHours => (stairMinutes + elevatorMinutes) / 60.0;
  double get securityComplexityHours => securityMinutes / 60.0;
  double get trashHours => 0.0; // Tracked via multiplier
  double get trafficMultiplierAdjustment => 0.0;
  double get occupancyMultiplierAdjustment => 0.0;
  double get sanitationMultiplierAdjustment => 0.0;

  Map<String, dynamic> toJson() {
    return {
      'baseCleaningMinutes': baseCleaningMinutes,
      'restroomBaseMinutes': restroomBaseMinutes,
      'toiletMinutes': toiletMinutes,
      'urinalMinutes': urinalMinutes,
      'sinkMinutes': sinkMinutes,
      'showerMinutes': showerMinutes,
      'totalRestroomMinutes': totalRestroomMinutes,
      'standardBreakroomMinutes': standardBreakroomMinutes,
      'largeKitchenMinutes': largeKitchenMinutes,
      'totalBreakroomMinutes': totalBreakroomMinutes,
      'conferenceRoomMinutes': conferenceRoomMinutes,
      'entranceMinutes': entranceMinutes,
      'stairMinutes': stairMinutes,
      'elevatorMinutes': elevatorMinutes,
      'securityMinutes': securityMinutes,
      'mobilizationMinutes': mobilizationMinutes,
      'unadjustedSubtotalMinutes': unadjustedSubtotalMinutes,
      'trafficMultiplier': trafficMultiplier,
      'trashMultiplier': trashMultiplier,
      'conditionMultiplier': conditionMultiplier,
      'sanitationMultiplier': sanitationMultiplier,
      'compositeMultiplier': compositeMultiplier,
      'finalTotalMinutes': finalTotalMinutes,
      'totalEstimatedHoursPerVisit': totalEstimatedHoursPerVisit,
    };
  }
}

/// Commercial Production Rate & Labor Estimation Engine.
/// Translates building specifications, room counters, fixture counts,
/// security constraints, and operational complexity into exact labor hours.
class LaborCalculator {
  /// Calculates multi-stage labor breakdown and total hours per visit.
  static LaborCalculationBreakdown calculateLaborHours({
    required SiteData site,
    required PricingSettings settings,
    double? customProductionRate,
  }) {
    // 1. Production rate validation & division-by-zero protection
    final double productionRate = (customProductionRate != null && customProductionRate > 0)
        ? customProductionRate
        : (settings.defaultProductionRate > 0 ? settings.defaultProductionRate : 3000.0);

    if (site.totalSquareFeet <= 0) {
      return const LaborCalculationBreakdown(
        baseCleaningMinutes: 0,
        restroomBaseMinutes: 0,
        toiletMinutes: 0,
        urinalMinutes: 0,
        sinkMinutes: 0,
        showerMinutes: 0,
        totalRestroomMinutes: 0,
        standardBreakroomMinutes: 0,
        largeKitchenMinutes: 0,
        totalBreakroomMinutes: 0,
        conferenceRoomMinutes: 0,
        entranceMinutes: 0,
        stairMinutes: 0,
        elevatorMinutes: 0,
        securityMinutes: 0,
        mobilizationMinutes: 0,
        unadjustedSubtotalMinutes: 0,
        trafficMultiplier: 1.0,
        trashMultiplier: 1.0,
        conditionMultiplier: 1.0,
        sanitationMultiplier: 1.0,
        compositeMultiplier: 1.0,
        finalTotalMinutes: 0,
        totalEstimatedHoursPerVisit: 0,
      );
    }

    final LaborAdjustmentSettings adj = settings.laborAdjustments;

    // STAGE 1: Base General Cleaning Minutes
    // base_cleaning_minutes = (total_square_feet / production_rate) * 60
    final double baseCleaningMinutes = (site.totalSquareFeet / productionRate) * 60.0;

    // STAGE 2: Restroom & Fixture Additive Minutes
    final double restroomBaseMinutes = site.bathroomsCount * adj.minutesPerRestroomBase;
    final double toiletMinutes = site.toiletsCount * adj.minutesPerToilet; // +5 min
    final double urinalMinutes = site.urinalsCount * adj.minutesPerUrinal; // +3 min
    final double sinkMinutes = site.sinksCount * adj.minutesPerSink;       // +2 min
    final double showerMinutes = site.showersCount * adj.minutesPerShower; // +8 min
    final double totalRestroomMinutes = restroomBaseMinutes + toiletMinutes + urinalMinutes + sinkMinutes + showerMinutes;

    // STAGE 3: Kitchens & Breakrooms
    final double standardBreakroomMinutes = site.standardBreakroomsCount * adj.minutesPerStandardBreakroom; // +10 min
    final double largeKitchenMinutes = site.largeKitchensCount * adj.minutesPerLargeKitchen;               // +20 min
    final double totalBreakroomMinutes = standardBreakroomMinutes + largeKitchenMinutes;

    // STAGE 4: Common Areas, Vertical Transport & Security
    final double conferenceRoomMinutes = site.conferenceRoomsCount * adj.minutesPerConferenceRoom; // +3 min
    final double entranceMinutes = site.entrancesCount * adj.minutesPerEntrance;                   // +5 min
    final double stairMinutes = site.stairsCount * adj.minutesPerStaircase;                        // +8 min
    final double elevatorMinutes = site.elevatorsCount * adj.minutesPerElevator;                   // +4 min
    final double securityMinutes = adj.getSecurityMinutes(site.securityComplexity, site.customSecurityMinutes);
    final double mobilizationMinutes = site.mobilization.totalMobilizationMinutes;

    // STAGE 5: Unadjusted Subtotal Minutes
    final double unadjustedSubtotalMinutes = baseCleaningMinutes +
        totalRestroomMinutes +
        totalBreakroomMinutes +
        conferenceRoomMinutes +
        entranceMinutes +
        stairMinutes +
        elevatorMinutes +
        securityMinutes +
        mobilizationMinutes;

    // STAGE 6: Apply Complexity Multipliers
    final double trafficMultiplier = adj.getTrafficMultiplier(site.trafficLevel);      // Low 1.00, Norm 1.05, High 1.15, VHigh 1.25
    final double trashMultiplier = adj.getTrashMultiplier(site.trashLevel);            // Light 1.00, Norm 1.05, Heavy 1.12, VHeavy 1.20
    final double conditionMultiplier = adj.getConditionMultiplier(site.siteCondition); // Excl 0.95, Norm 1.00, NeedsImpr 1.10, HeavySoil 1.25
    final double sanitationMultiplier = site.requiresSpecialSanitation ? adj.specialSanitationMultiplier : 1.0; // 1.15

    final double compositeMultiplier = trafficMultiplier * trashMultiplier * conditionMultiplier * sanitationMultiplier;

    // STAGE 7: Final Estimated Minutes & Decimal Labor Hours
    double finalTotalMinutes = unadjustedSubtotalMinutes * compositeMultiplier;
    double estimatedHours = finalTotalMinutes / 60.0;

    // Sanity floor: at least 0.5 labor hours (30 min) for any nonzero commercial site
    if (estimatedHours < 0.5 && site.totalSquareFeet > 0) {
      estimatedHours = 0.5;
      finalTotalMinutes = 30.0;
    }

    return LaborCalculationBreakdown(
      baseCleaningMinutes: baseCleaningMinutes,
      restroomBaseMinutes: restroomBaseMinutes,
      toiletMinutes: toiletMinutes,
      urinalMinutes: urinalMinutes,
      sinkMinutes: sinkMinutes,
      showerMinutes: showerMinutes,
      totalRestroomMinutes: totalRestroomMinutes,
      standardBreakroomMinutes: standardBreakroomMinutes,
      largeKitchenMinutes: largeKitchenMinutes,
      totalBreakroomMinutes: totalBreakroomMinutes,
      conferenceRoomMinutes: conferenceRoomMinutes,
      entranceMinutes: entranceMinutes,
      stairMinutes: stairMinutes,
      elevatorMinutes: elevatorMinutes,
      securityMinutes: securityMinutes,
      mobilizationMinutes: mobilizationMinutes,
      unadjustedSubtotalMinutes: unadjustedSubtotalMinutes,
      trafficMultiplier: trafficMultiplier,
      trashMultiplier: trashMultiplier,
      conditionMultiplier: conditionMultiplier,
      sanitationMultiplier: sanitationMultiplier,
      compositeMultiplier: compositeMultiplier,
      finalTotalMinutes: finalTotalMinutes,
      totalEstimatedHoursPerVisit: estimatedHours,
    );
  }
}
