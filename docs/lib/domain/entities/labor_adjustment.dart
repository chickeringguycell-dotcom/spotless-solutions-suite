import 'site_data.dart';

/// Configurable labor adjustment settings and multipliers.
/// Note: All numerical values are configurable starting assumptions.
class LaborAdjustmentSettings {
  // Restrooms & Fixture Minutes (Per Unit)
  final double minutesPerRestroomBase; // Base setup/entry per restroom (default 0 or 5m)
  final double minutesPerToilet;       // Default 5.0 min
  final double minutesPerUrinal;       // Default 3.0 min
  final double minutesPerSink;         // Default 2.0 min
  final double minutesPerShower;       // Default 8.0 min

  // Kitchens & Breakrooms
  final double minutesPerStandardBreakroom; // Default 10.0 min
  final double minutesPerLargeKitchen;      // Default 20.0 min

  // Conference Rooms & Common Areas
  final double minutesPerConferenceRoom;    // Default 3.0 min (trash, tables, chairs, touchpoints)
  final double minutesPerEntrance;          // Default 5.0 min

  // Vertical Transport
  final double minutesPerStaircase;         // Default 8.0 min per staircase
  final double minutesPerElevator;          // Default 4.0 min per elevator

  // Security Access Times (Minutes)
  final double securitySimpleMinutes;       // 0 min
  final double securityNormalMinutes;       // 5 min
  final double securityComplexMinutes;      // 10 min

  // Traffic Multipliers
  final double trafficLowMultiplier;        // 1.00
  final double trafficNormalMultiplier;     // 1.05
  final double trafficHighMultiplier;       // 1.15
  final double trafficVeryHighMultiplier;   // 1.25

  // Trash Multipliers
  final double trashLightMultiplier;        // 1.00
  final double trashNormalMultiplier;       // 1.05
  final double trashHeavyMultiplier;        // 1.12
  final double trashVeryHeavyMultiplier;    // 1.20

  // Site Condition Multipliers
  final double conditionExcellentMultiplier;         // 0.95
  final double conditionNormalMultiplier;            // 1.00
  final double conditionNeedsImprovementMultiplier;  // 1.10
  final double conditionHeavySoilMultiplier;         // 1.25

  // Special Sanitation Multiplier
  final double specialSanitationMultiplier; // 1.15

  const LaborAdjustmentSettings({
    this.minutesPerRestroomBase = 0.0,
    this.minutesPerToilet = 5.0,
    this.minutesPerUrinal = 3.0,
    this.minutesPerSink = 2.0,
    this.minutesPerShower = 8.0,
    this.minutesPerStandardBreakroom = 10.0,
    this.minutesPerLargeKitchen = 20.0,
    this.minutesPerConferenceRoom = 3.0,
    this.minutesPerEntrance = 5.0,
    this.minutesPerStaircase = 8.0,
    this.minutesPerElevator = 4.0,
    this.securitySimpleMinutes = 0.0,
    this.securityNormalMinutes = 5.0,
    this.securityComplexMinutes = 10.0,
    this.trafficLowMultiplier = 1.00,
    this.trafficNormalMultiplier = 1.05,
    this.trafficHighMultiplier = 1.15,
    this.trafficVeryHighMultiplier = 1.25,
    this.trashLightMultiplier = 1.00,
    this.trashNormalMultiplier = 1.05,
    this.trashHeavyMultiplier = 1.12,
    this.trashVeryHeavyMultiplier = 1.20,
    this.conditionExcellentMultiplier = 0.95,
    this.conditionNormalMultiplier = 1.00,
    this.conditionNeedsImprovementMultiplier = 1.10,
    this.conditionHeavySoilMultiplier = 1.25,
    this.specialSanitationMultiplier = 1.15,
  });

  double getTrafficMultiplier(TrafficLevel level) {
    switch (level) {
      case TrafficLevel.low:
        return trafficLowMultiplier;
      case TrafficLevel.normal:
        return trafficNormalMultiplier;
      case TrafficLevel.high:
        return trafficHighMultiplier;
      case TrafficLevel.veryHigh:
        return trafficVeryHighMultiplier;
    }
  }

  double getTrashMultiplier(TrashLevel level) {
    switch (level) {
      case TrashLevel.light:
        return trashLightMultiplier;
      case TrashLevel.normal:
        return trashNormalMultiplier;
      case TrashLevel.heavy:
        return trashHeavyMultiplier;
      case TrashLevel.veryHeavy:
        return trashVeryHeavyMultiplier;
    }
  }

  double getConditionMultiplier(SiteCondition condition) {
    switch (condition) {
      case SiteCondition.excellent:
        return conditionExcellentMultiplier;
      case SiteCondition.normal:
        return conditionNormalMultiplier;
      case SiteCondition.needsImprovement:
        return conditionNeedsImprovementMultiplier;
      case SiteCondition.heavySoil:
        return conditionHeavySoilMultiplier;
    }
  }

  double getSecurityMinutes(SecurityComplexity complexity, double customMinutes) {
    switch (complexity) {
      case SecurityComplexity.simple:
        return securitySimpleMinutes;
      case SecurityComplexity.normalKeyAlarm:
        return securityNormalMinutes;
      case SecurityComplexity.complexSecurity:
        return securityComplexMinutes;
      case SecurityComplexity.highSecurityCustom:
        return customMinutes;
    }
  }

  LaborAdjustmentSettings copyWith({
    double? minutesPerRestroomBase,
    double? minutesPerToilet,
    double? minutesPerUrinal,
    double? minutesPerSink,
    double? minutesPerShower,
    double? minutesPerStandardBreakroom,
    double? minutesPerLargeKitchen,
    double? minutesPerConferenceRoom,
    double? minutesPerEntrance,
    double? minutesPerStaircase,
    double? minutesPerElevator,
    double? securitySimpleMinutes,
    double? securityNormalMinutes,
    double? securityComplexMinutes,
    double? trafficLowMultiplier,
    double? trafficNormalMultiplier,
    double? trafficHighMultiplier,
    double? trafficVeryHighMultiplier,
    double? trashLightMultiplier,
    double? trashNormalMultiplier,
    double? trashHeavyMultiplier,
    double? trashVeryHeavyMultiplier,
    double? conditionExcellentMultiplier,
    double? conditionNormalMultiplier,
    double? conditionNeedsImprovementMultiplier,
    double? conditionHeavySoilMultiplier,
    double? specialSanitationMultiplier,
  }) {
    return LaborAdjustmentSettings(
      minutesPerRestroomBase: minutesPerRestroomBase ?? this.minutesPerRestroomBase,
      minutesPerToilet: minutesPerToilet ?? this.minutesPerToilet,
      minutesPerUrinal: minutesPerUrinal ?? this.minutesPerUrinal,
      minutesPerSink: minutesPerSink ?? this.minutesPerSink,
      minutesPerShower: minutesPerShower ?? this.minutesPerShower,
      minutesPerStandardBreakroom: minutesPerStandardBreakroom ?? this.minutesPerStandardBreakroom,
      minutesPerLargeKitchen: minutesPerLargeKitchen ?? this.minutesPerLargeKitchen,
      minutesPerConferenceRoom: minutesPerConferenceRoom ?? this.minutesPerConferenceRoom,
      minutesPerEntrance: minutesPerEntrance ?? this.minutesPerEntrance,
      minutesPerStaircase: minutesPerStaircase ?? this.minutesPerStaircase,
      minutesPerElevator: minutesPerElevator ?? this.minutesPerElevator,
      securitySimpleMinutes: securitySimpleMinutes ?? this.securitySimpleMinutes,
      securityNormalMinutes: securityNormalMinutes ?? this.securityNormalMinutes,
      securityComplexMinutes: securityComplexMinutes ?? this.securityComplexMinutes,
      trafficLowMultiplier: trafficLowMultiplier ?? this.trafficLowMultiplier,
      trafficNormalMultiplier: trafficNormalMultiplier ?? this.trafficNormalMultiplier,
      trafficHighMultiplier: trafficHighMultiplier ?? this.trafficHighMultiplier,
      trafficVeryHighMultiplier: trafficVeryHighMultiplier ?? this.trafficVeryHighMultiplier,
      trashLightMultiplier: trashLightMultiplier ?? this.trashLightMultiplier,
      trashNormalMultiplier: trashNormalMultiplier ?? this.trashNormalMultiplier,
      trashHeavyMultiplier: trashHeavyMultiplier ?? this.trashHeavyMultiplier,
      trashVeryHeavyMultiplier: trashVeryHeavyMultiplier ?? this.trashVeryHeavyMultiplier,
      conditionExcellentMultiplier: conditionExcellentMultiplier ?? this.conditionExcellentMultiplier,
      conditionNormalMultiplier: conditionNormalMultiplier ?? this.conditionNormalMultiplier,
      conditionNeedsImprovementMultiplier: conditionNeedsImprovementMultiplier ?? this.conditionNeedsImprovementMultiplier,
      conditionHeavySoilMultiplier: conditionHeavySoilMultiplier ?? this.conditionHeavySoilMultiplier,
      specialSanitationMultiplier: specialSanitationMultiplier ?? this.specialSanitationMultiplier,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minutesPerRestroomBase': minutesPerRestroomBase,
      'minutesPerToilet': minutesPerToilet,
      'minutesPerUrinal': minutesPerUrinal,
      'minutesPerSink': minutesPerSink,
      'minutesPerShower': minutesPerShower,
      'minutesPerStandardBreakroom': minutesPerStandardBreakroom,
      'minutesPerLargeKitchen': minutesPerLargeKitchen,
      'minutesPerConferenceRoom': minutesPerConferenceRoom,
      'minutesPerEntrance': minutesPerEntrance,
      'minutesPerStaircase': minutesPerStaircase,
      'minutesPerElevator': minutesPerElevator,
      'securitySimpleMinutes': securitySimpleMinutes,
      'securityNormalMinutes': securityNormalMinutes,
      'securityComplexMinutes': securityComplexMinutes,
      'trafficLowMultiplier': trafficLowMultiplier,
      'trafficNormalMultiplier': trafficNormalMultiplier,
      'trafficHighMultiplier': trafficHighMultiplier,
      'trafficVeryHighMultiplier': trafficVeryHighMultiplier,
      'trashLightMultiplier': trashLightMultiplier,
      'trashNormalMultiplier': trashNormalMultiplier,
      'trashHeavyMultiplier': trashHeavyMultiplier,
      'trashVeryHeavyMultiplier': trashVeryHeavyMultiplier,
      'conditionExcellentMultiplier': conditionExcellentMultiplier,
      'conditionNormalMultiplier': conditionNormalMultiplier,
      'conditionNeedsImprovementMultiplier': conditionNeedsImprovementMultiplier,
      'conditionHeavySoilMultiplier': conditionHeavySoilMultiplier,
      'specialSanitationMultiplier': specialSanitationMultiplier,
    };
  }

  factory LaborAdjustmentSettings.fromJson(Map<String, dynamic> json) {
    return LaborAdjustmentSettings(
      minutesPerRestroomBase: (json['minutesPerRestroomBase'] as num?)?.toDouble() ?? 0.0,
      minutesPerToilet: (json['minutesPerToilet'] as num?)?.toDouble() ?? 5.0,
      minutesPerUrinal: (json['minutesPerUrinal'] as num?)?.toDouble() ?? 3.0,
      minutesPerSink: (json['minutesPerSink'] as num?)?.toDouble() ?? 2.0,
      minutesPerShower: (json['minutesPerShower'] as num?)?.toDouble() ?? 8.0,
      minutesPerStandardBreakroom: (json['minutesPerStandardBreakroom'] as num?)?.toDouble() ?? 10.0,
      minutesPerLargeKitchen: (json['minutesPerLargeKitchen'] as num?)?.toDouble() ?? 20.0,
      minutesPerConferenceRoom: (json['minutesPerConferenceRoom'] as num?)?.toDouble() ?? 3.0,
      minutesPerEntrance: (json['minutesPerEntrance'] as num?)?.toDouble() ?? 5.0,
      minutesPerStaircase: (json['minutesPerStaircase'] as num?)?.toDouble() ?? 8.0,
      minutesPerElevator: (json['minutesPerElevator'] as num?)?.toDouble() ?? 4.0,
      securitySimpleMinutes: (json['securitySimpleMinutes'] as num?)?.toDouble() ?? 0.0,
      securityNormalMinutes: (json['securityNormalMinutes'] as num?)?.toDouble() ?? 5.0,
      securityComplexMinutes: (json['securityComplexMinutes'] as num?)?.toDouble() ?? 10.0,
      trafficLowMultiplier: (json['trafficLowMultiplier'] as num?)?.toDouble() ?? 1.00,
      trafficNormalMultiplier: (json['trafficNormalMultiplier'] as num?)?.toDouble() ?? 1.05,
      trafficHighMultiplier: (json['trafficHighMultiplier'] as num?)?.toDouble() ?? 1.15,
      trafficVeryHighMultiplier: (json['trafficVeryHighMultiplier'] as num?)?.toDouble() ?? 1.25,
      trashLightMultiplier: (json['trashLightMultiplier'] as num?)?.toDouble() ?? 1.00,
      trashNormalMultiplier: (json['trashNormalMultiplier'] as num?)?.toDouble() ?? 1.05,
      trashHeavyMultiplier: (json['trashHeavyMultiplier'] as num?)?.toDouble() ?? 1.12,
      trashVeryHeavyMultiplier: (json['trashVeryHeavyMultiplier'] as num?)?.toDouble() ?? 1.20,
      conditionExcellentMultiplier: (json['conditionExcellentMultiplier'] as num?)?.toDouble() ?? 0.95,
      conditionNormalMultiplier: (json['conditionNormalMultiplier'] as num?)?.toDouble() ?? 1.00,
      conditionNeedsImprovementMultiplier: (json['conditionNeedsImprovementMultiplier'] as num?)?.toDouble() ?? 1.10,
      conditionHeavySoilMultiplier: (json['conditionHeavySoilMultiplier'] as num?)?.toDouble() ?? 1.25,
      specialSanitationMultiplier: (json['specialSanitationMultiplier'] as num?)?.toDouble() ?? 1.15,
    );
  }
}
