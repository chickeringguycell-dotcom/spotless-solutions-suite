enum TrafficLevel {
  low,
  normal,
  high,
  veryHigh;

  String get displayName {
    switch (this) {
      case TrafficLevel.low:
        return 'Low Traffic (1.00x - Lightly Occupied)';
      case TrafficLevel.normal:
        return 'Normal Traffic (1.05x - Typical Office)';
      case TrafficLevel.high:
        return 'High Traffic (1.15x - Heavy Staff/Visitors)';
      case TrafficLevel.veryHigh:
        return 'Very High Traffic (1.25x - Busy Public/High Density)';
    }
  }

  String get shortLabel {
    switch (this) {
      case TrafficLevel.low:
        return 'Low (1.00x)';
      case TrafficLevel.normal:
        return 'Normal (1.05x)';
      case TrafficLevel.high:
        return 'High (1.15x)';
      case TrafficLevel.veryHigh:
        return 'Very High (1.25x)';
    }
  }
}

enum TrashLevel {
  light,
  normal,
  heavy,
  veryHeavy;

  String get displayName {
    switch (this) {
      case TrashLevel.light:
        return 'Light Trash (1.00x - Minimal Waste)';
      case TrashLevel.normal:
        return 'Normal Trash (1.05x - Standard Desk Bins)';
      case TrashLevel.heavy:
        return 'Heavy Trash (1.12x - High Paper/Packaging)';
      case TrashLevel.veryHeavy:
        return 'Very Heavy Trash (1.20x - Kitchens/Continuous)';
    }
  }

  String get shortLabel {
    switch (this) {
      case TrashLevel.light:
        return 'Light (1.00x)';
      case TrashLevel.normal:
        return 'Normal (1.05x)';
      case TrashLevel.heavy:
        return 'Heavy (1.12x)';
      case TrashLevel.veryHeavy:
        return 'Very Heavy (1.20x)';
    }
  }
}

enum SiteCondition {
  excellent,
  normal,
  needsImprovement,
  heavySoil;

  String get displayName {
    switch (this) {
      case SiteCondition.excellent:
        return 'Excellent (0.95x - Already Well-Maintained)';
      case SiteCondition.normal:
        return 'Normal (1.00x - Standard Commercial Condition)';
      case SiteCondition.needsImprovement:
        return 'Needs Improvement (1.10x - Neglected Surfaces)';
      case SiteCondition.heavySoil:
        return 'Heavy Soil (1.25x - High Buildup/High Dust)';
    }
  }

  String get shortLabel {
    switch (this) {
      case SiteCondition.excellent:
        return 'Excellent (0.95x)';
      case SiteCondition.normal:
        return 'Normal (1.00x)';
      case SiteCondition.needsImprovement:
        return 'Needs Impr. (1.10x)';
      case SiteCondition.heavySoil:
        return 'Heavy Soil (1.25x)';
    }
  }
}

enum SecurityComplexity {
  simple,
  normalKeyAlarm,
  complexSecurity,
  highSecurityCustom;

  String get displayName {
    switch (this) {
      case SecurityComplexity.simple:
        return 'Simple Access (0 min - Open / Unlocked)';
      case SecurityComplexity.normalKeyAlarm:
        return 'Normal Key/Alarm (+5 min - Panel code / Lockbox)';
      case SecurityComplexity.complexSecurity:
        return 'Complex Security (+10 min - Keycard & Multiple Alarms)';
      case SecurityComplexity.highSecurityCustom:
        return 'High-Security Procedure (Custom Time)';
    }
  }
}

enum CleaningShift {
  night,
  day;

  String get displayName => this == CleaningShift.night ? 'Night Cleaning (After Hours)' : 'Day Porter (Active Office)';
}

/// Represents mobilization, travel, setup, and transit assumptions.
class MobilizationData {
  final double travelTimeMinutes;
  final double mileage;
  final double parkingFees;
  final double tollFees;
  final double setupUnloadMinutes;

  const MobilizationData({
    this.travelTimeMinutes = 0.0,
    this.mileage = 0.0,
    this.parkingFees = 0.0,
    this.tollFees = 0.0,
    this.setupUnloadMinutes = 0.0,
  });

  double get totalMobilizationMinutes => travelTimeMinutes + setupUnloadMinutes;
  double get totalDirectFees => parkingFees + tollFees;

  MobilizationData copyWith({
    double? travelTimeMinutes,
    double? mileage,
    double? parkingFees,
    double? tollFees,
    double? setupUnloadMinutes,
  }) {
    return MobilizationData(
      travelTimeMinutes: travelTimeMinutes ?? this.travelTimeMinutes,
      mileage: mileage ?? this.mileage,
      parkingFees: parkingFees ?? this.parkingFees,
      tollFees: tollFees ?? this.tollFees,
      setupUnloadMinutes: setupUnloadMinutes ?? this.setupUnloadMinutes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'travelTimeMinutes': travelTimeMinutes,
      'mileage': mileage,
      'parkingFees': parkingFees,
      'tollFees': tollFees,
      'setupUnloadMinutes': setupUnloadMinutes,
    };
  }

  factory MobilizationData.fromJson(Map<String, dynamic> json) {
    return MobilizationData(
      travelTimeMinutes: (json['travelTimeMinutes'] as num?)?.toDouble() ?? 0.0,
      mileage: (json['mileage'] as num?)?.toDouble() ?? 0.0,
      parkingFees: (json['parkingFees'] as num?)?.toDouble() ?? 0.0,
      tollFees: (json['tollFees'] as num?)?.toDouble() ?? 0.0,
      setupUnloadMinutes: (json['setupUnloadMinutes'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Represents the commercial building walkthrough and site specifications.
class SiteData {
  final double totalSquareFeet;
  final int workstationsCount;
  
  // Restrooms & Fixtures
  final int bathroomsCount;
  final int toiletsCount;
  final int urinalsCount;
  final int sinksCount;
  final int showersCount;

  // Kitchens & Breakrooms
  final int standardBreakroomsCount;
  final int largeKitchensCount;

  // Common Areas
  final int conferenceRoomsCount;
  final int entrancesCount;

  // Flooring breakdown (sq ft)
  final double carpetSqFt;
  final double vinylLvtSqFt;
  final double tileSqFt;
  final double concreteSqFt;
  final double hardwoodSqFt;
  final double otherFlooringSqFt;

  // Operational complexity & multipliers
  final int estimatedOccupancy;
  final TrafficLevel trafficLevel;
  final TrashLevel trashLevel;
  final SiteCondition siteCondition;
  final int stairsCount;
  final int floorsCount;
  final int elevatorsCount;

  // Security & Mobilization
  final SecurityComplexity securityComplexity;
  final double customSecurityMinutes;
  final String securityAccessDetails;
  final CleaningShift cleaningShift;
  final String parkingAccessNotes;
  final MobilizationData mobilization;

  // Special Sanitation flag
  final bool requiresSpecialSanitation;

  const SiteData({
    required this.totalSquareFeet,
    this.workstationsCount = 0,
    this.bathroomsCount = 0,
    this.toiletsCount = 0,
    this.urinalsCount = 0,
    this.sinksCount = 0,
    this.showersCount = 0,
    this.standardBreakroomsCount = 0,
    this.largeKitchensCount = 0,
    this.conferenceRoomsCount = 0,
    this.entrancesCount = 1,
    this.carpetSqFt = 0,
    this.vinylLvtSqFt = 0,
    this.tileSqFt = 0,
    this.concreteSqFt = 0,
    this.hardwoodSqFt = 0,
    this.otherFlooringSqFt = 0,
    this.estimatedOccupancy = 0,
    this.trafficLevel = TrafficLevel.normal,
    this.trashLevel = TrashLevel.normal,
    this.siteCondition = SiteCondition.normal,
    this.stairsCount = 0,
    this.floorsCount = 1,
    this.elevatorsCount = 0,
    this.securityComplexity = SecurityComplexity.normalKeyAlarm,
    this.customSecurityMinutes = 15.0,
    this.securityAccessDetails = '',
    this.cleaningShift = CleaningShift.night,
    this.parkingAccessNotes = '',
    this.mobilization = const MobilizationData(),
    this.requiresSpecialSanitation = false,
  });

  int get totalKitchensCount => standardBreakroomsCount + largeKitchensCount;
  int get kitchensCount => totalKitchensCount;
  int get toiletsUrinalsCount => toiletsCount + urinalsCount;

  /// Factory for a default standard office
  factory SiteData.initial() {
    return const SiteData(
      totalSquareFeet: 5000,
      workstationsCount: 20,
      bathroomsCount: 2,
      toiletsCount: 3,
      urinalsCount: 1,
      sinksCount: 4,
      showersCount: 0,
      standardBreakroomsCount: 1,
      largeKitchensCount: 0,
      conferenceRoomsCount: 2,
      entrancesCount: 1,
      carpetSqFt: 3500,
      vinylLvtSqFt: 1500,
      estimatedOccupancy: 25,
      trafficLevel: TrafficLevel.normal,
      trashLevel: TrashLevel.normal,
      siteCondition: SiteCondition.normal,
      stairsCount: 0,
      floorsCount: 1,
      elevatorsCount: 0,
      securityComplexity: SecurityComplexity.normalKeyAlarm,
      securityAccessDetails: 'Key fob and alarm code entry at main lobby',
      cleaningShift: CleaningShift.night,
      parkingAccessNotes: 'Rear parking lot open after 6 PM',
      mobilization: MobilizationData(travelTimeMinutes: 10.0, mileage: 5.0, setupUnloadMinutes: 5.0),
      requiresSpecialSanitation: false,
    );
  }

  SiteData copyWith({
    double? totalSquareFeet,
    int? workstationsCount,
    int? bathroomsCount,
    int? toiletsCount,
    int? urinalsCount,
    int? sinksCount,
    int? showersCount,
    int? standardBreakroomsCount,
    int? largeKitchensCount,
    int? conferenceRoomsCount,
    int? entrancesCount,
    double? carpetSqFt,
    double? vinylLvtSqFt,
    double? tileSqFt,
    double? concreteSqFt,
    double? hardwoodSqFt,
    double? otherFlooringSqFt,
    int? estimatedOccupancy,
    TrafficLevel? trafficLevel,
    TrashLevel? trashLevel,
    SiteCondition? siteCondition,
    int? stairsCount,
    int? floorsCount,
    int? elevatorsCount,
    SecurityComplexity? securityComplexity,
    double? customSecurityMinutes,
    String? securityAccessDetails,
    CleaningShift? cleaningShift,
    String? parkingAccessNotes,
    MobilizationData? mobilization,
    bool? requiresSpecialSanitation,
  }) {
    return SiteData(
      totalSquareFeet: totalSquareFeet ?? this.totalSquareFeet,
      workstationsCount: workstationsCount ?? this.workstationsCount,
      bathroomsCount: bathroomsCount ?? this.bathroomsCount,
      toiletsCount: toiletsCount ?? this.toiletsCount,
      urinalsCount: urinalsCount ?? this.urinalsCount,
      sinksCount: sinksCount ?? this.sinksCount,
      showersCount: showersCount ?? this.showersCount,
      standardBreakroomsCount: standardBreakroomsCount ?? this.standardBreakroomsCount,
      largeKitchensCount: largeKitchensCount ?? this.largeKitchensCount,
      conferenceRoomsCount: conferenceRoomsCount ?? this.conferenceRoomsCount,
      entrancesCount: entrancesCount ?? this.entrancesCount,
      carpetSqFt: carpetSqFt ?? this.carpetSqFt,
      vinylLvtSqFt: vinylLvtSqFt ?? this.vinylLvtSqFt,
      tileSqFt: tileSqFt ?? this.tileSqFt,
      concreteSqFt: concreteSqFt ?? this.concreteSqFt,
      hardwoodSqFt: hardwoodSqFt ?? this.hardwoodSqFt,
      otherFlooringSqFt: otherFlooringSqFt ?? this.otherFlooringSqFt,
      estimatedOccupancy: estimatedOccupancy ?? this.estimatedOccupancy,
      trafficLevel: trafficLevel ?? this.trafficLevel,
      trashLevel: trashLevel ?? this.trashLevel,
      siteCondition: siteCondition ?? this.siteCondition,
      stairsCount: stairsCount ?? this.stairsCount,
      floorsCount: floorsCount ?? this.floorsCount,
      elevatorsCount: elevatorsCount ?? this.elevatorsCount,
      securityComplexity: securityComplexity ?? this.securityComplexity,
      customSecurityMinutes: customSecurityMinutes ?? this.customSecurityMinutes,
      securityAccessDetails: securityAccessDetails ?? this.securityAccessDetails,
      cleaningShift: cleaningShift ?? this.cleaningShift,
      parkingAccessNotes: parkingAccessNotes ?? this.parkingAccessNotes,
      mobilization: mobilization ?? this.mobilization,
      requiresSpecialSanitation: requiresSpecialSanitation ?? this.requiresSpecialSanitation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSquareFeet': totalSquareFeet,
      'workstationsCount': workstationsCount,
      'bathroomsCount': bathroomsCount,
      'toiletsCount': toiletsCount,
      'urinalsCount': urinalsCount,
      'sinksCount': sinksCount,
      'showersCount': showersCount,
      'standardBreakroomsCount': standardBreakroomsCount,
      'largeKitchensCount': largeKitchensCount,
      'conferenceRoomsCount': conferenceRoomsCount,
      'entrancesCount': entrancesCount,
      'carpetSqFt': carpetSqFt,
      'vinylLvtSqFt': vinylLvtSqFt,
      'tileSqFt': tileSqFt,
      'concreteSqFt': concreteSqFt,
      'hardwoodSqFt': hardwoodSqFt,
      'otherFlooringSqFt': otherFlooringSqFt,
      'estimatedOccupancy': estimatedOccupancy,
      'trafficLevel': trafficLevel.name,
      'trashLevel': trashLevel.name,
      'siteCondition': siteCondition.name,
      'stairsCount': stairsCount,
      'floorsCount': floorsCount,
      'elevatorsCount': elevatorsCount,
      'securityComplexity': securityComplexity.name,
      'customSecurityMinutes': customSecurityMinutes,
      'securityAccessDetails': securityAccessDetails,
      'cleaningShift': cleaningShift.name,
      'parkingAccessNotes': parkingAccessNotes,
      'mobilization': mobilization.toJson(),
      'requiresSpecialSanitation': requiresSpecialSanitation,
    };
  }

  factory SiteData.fromJson(Map<String, dynamic> json) {
    return SiteData(
      totalSquareFeet: (json['totalSquareFeet'] as num).toDouble(),
      workstationsCount: (json['workstationsCount'] as num?)?.toInt() ?? 0,
      bathroomsCount: (json['bathroomsCount'] as num?)?.toInt() ?? 0,
      toiletsCount: (json['toiletsCount'] as num?)?.toInt() ?? 0,
      urinalsCount: (json['urinalsCount'] as num?)?.toInt() ?? 0,
      sinksCount: (json['sinksCount'] as num?)?.toInt() ?? 0,
      showersCount: (json['showersCount'] as num?)?.toInt() ?? 0,
      standardBreakroomsCount: (json['standardBreakroomsCount'] as num?)?.toInt() ?? 0,
      largeKitchensCount: (json['largeKitchensCount'] as num?)?.toInt() ?? 0,
      conferenceRoomsCount: (json['conferenceRoomsCount'] as num?)?.toInt() ?? 0,
      entrancesCount: (json['entrancesCount'] as num?)?.toInt() ?? 1,
      carpetSqFt: (json['carpetSqFt'] as num?)?.toDouble() ?? 0,
      vinylLvtSqFt: (json['vinylLvtSqFt'] as num?)?.toDouble() ?? 0,
      tileSqFt: (json['tileSqFt'] as num?)?.toDouble() ?? 0,
      concreteSqFt: (json['concreteSqFt'] as num?)?.toDouble() ?? 0,
      hardwoodSqFt: (json['hardwoodSqFt'] as num?)?.toDouble() ?? 0,
      otherFlooringSqFt: (json['otherFlooringSqFt'] as num?)?.toDouble() ?? 0,
      estimatedOccupancy: (json['estimatedOccupancy'] as num?)?.toInt() ?? 0,
      trafficLevel: TrafficLevel.values.firstWhere(
        (e) => e.name == json['trafficLevel'],
        orElse: () => TrafficLevel.normal,
      ),
      trashLevel: TrashLevel.values.firstWhere(
        (e) => e.name == json['trashLevel'],
        orElse: () => TrashLevel.normal,
      ),
      siteCondition: SiteCondition.values.firstWhere(
        (e) => e.name == json['siteCondition'],
        orElse: () => SiteCondition.normal,
      ),
      stairsCount: (json['stairsCount'] as num?)?.toInt() ?? 0,
      floorsCount: (json['floorsCount'] as num?)?.toInt() ?? 1,
      elevatorsCount: (json['elevatorsCount'] as num?)?.toInt() ?? 0,
      securityComplexity: SecurityComplexity.values.firstWhere(
        (e) => e.name == json['securityComplexity'],
        orElse: () => SecurityComplexity.normalKeyAlarm,
      ),
      customSecurityMinutes: (json['customSecurityMinutes'] as num?)?.toDouble() ?? 15.0,
      securityAccessDetails: (json['securityAccessDetails'] as String?) ?? '',
      cleaningShift: CleaningShift.values.firstWhere(
        (e) => e.name == json['cleaningShift'],
        orElse: () => CleaningShift.night,
      ),
      parkingAccessNotes: (json['parkingAccessNotes'] as String?) ?? '',
      mobilization: json['mobilization'] != null
          ? MobilizationData.fromJson(json['mobilization'])
          : const MobilizationData(),
      requiresSpecialSanitation: (json['requiresSpecialSanitation'] as bool?) ?? false,
    );
  }
}
