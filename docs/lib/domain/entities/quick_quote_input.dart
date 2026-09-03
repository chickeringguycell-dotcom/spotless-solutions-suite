import 'cleaning_difficulty.dart';
import 'site_data.dart';
import 'service_frequency.dart';

/// Encapsulates the 6 primary inputs for the simplified fast quoting screen.
/// Automatically bridges into the complete underlying site and frequency model.
class QuickQuoteInput {
  // Input 1: Total cleanable square footage
  final double totalSquareFeet;

  // Input 2: Number of restrooms
  final int restroomsCount;

  // Input 3: Number of kitchens / breakrooms
  final int kitchensCount;

  // Input 4: Number of employees / building occupancy
  final int occupantsCount;

  // Input 5: Cleanings per week (1 to 7)
  final int cleaningsPerWeek;

  // Input 6: Cleaning difficulty / condition
  final CleaningDifficulty difficulty;

  const QuickQuoteInput({
    required this.totalSquareFeet,
    this.restroomsCount = 2,
    this.kitchensCount = 1,
    this.occupantsCount = 20,
    this.cleaningsPerWeek = 5,
    this.difficulty = CleaningDifficulty.normal,
  });

  /// Factory for standard default initial values
  factory QuickQuoteInput.initial() {
    return const QuickQuoteInput(
      totalSquareFeet: 5000,
      restroomsCount: 2,
      kitchensCount: 1,
      occupantsCount: 25,
      cleaningsPerWeek: 5,
      difficulty: CleaningDifficulty.normal,
    );
  }

  /// Automatically maps the 6 inputs into the complete SiteData structure.
  SiteData toSiteData() {
    // Determine typical fixture counts from restroom enclosures
    // Standard rule: ~1.5 toilets, 0.5 urinals, 1.5 sinks per restroom enclosure
    final int toilets = (restroomsCount * 1.5).ceil();
    final int urinals = (restroomsCount * 0.5).floor();
    final int sinks = (restroomsCount * 1.5).ceil();

    // Map occupancy & difficulty to traffic and condition
    TrafficLevel traffic;
    if (occupantsCount > 75) {
      traffic = TrafficLevel.veryHigh;
    } else if (occupantsCount > 40) {
      traffic = TrafficLevel.high;
    } else if (occupantsCount < 10) {
      traffic = TrafficLevel.low;
    } else {
      traffic = TrafficLevel.normal;
    }

    TrashLevel trash;
    SiteCondition condition;
    switch (difficulty) {
      case CleaningDifficulty.light:
        trash = TrashLevel.light;
        condition = SiteCondition.excellent;
        break;
      case CleaningDifficulty.normal:
        trash = TrashLevel.normal;
        condition = SiteCondition.normal;
        break;
      case CleaningDifficulty.heavy:
        trash = TrashLevel.heavy;
        condition = SiteCondition.heavySoil;
        break;
    }

    return SiteData(
      totalSquareFeet: totalSquareFeet,
      workstationsCount: occupantsCount,
      bathroomsCount: restroomsCount,
      toiletsCount: toilets,
      urinalsCount: urinals,
      sinksCount: sinks,
      showersCount: 0,
      standardBreakroomsCount: kitchensCount,
      largeKitchensCount: 0,
      conferenceRoomsCount: (totalSquareFeet / 2500).floor().clamp(1, 10),
      entrancesCount: 1,
      carpetSqFt: totalSquareFeet * 0.70,
      vinylLvtSqFt: totalSquareFeet * 0.30,
      estimatedOccupancy: occupantsCount,
      trafficLevel: traffic,
      trashLevel: trash,
      siteCondition: condition,
      stairsCount: 0,
      floorsCount: 1,
      elevatorsCount: 0,
      securityComplexity: SecurityComplexity.normalKeyAlarm,
      cleaningShift: CleaningShift.night,
    );
  }

  /// Maps the cleaningsPerWeek into the ServiceFrequency entity.
  ServiceFrequency toServiceFrequency() {
    switch (cleaningsPerWeek) {
      case 1:
        return ServiceFrequency.onceWeekly;
      case 2:
        return ServiceFrequency.twiceWeekly;
      case 3:
        return ServiceFrequency.threeTimesWeekly;
      case 4:
        return ServiceFrequency.fourTimesWeekly;
      case 5:
        return ServiceFrequency.fiveTimesWeekly;
      case 6:
        return ServiceFrequency.sixTimesWeekly;
      case 7:
        return ServiceFrequency.sevenTimesWeekly;
      default:
        return ServiceFrequency.fiveTimesWeekly;
    }
  }

  QuickQuoteInput copyWith({
    double? totalSquareFeet,
    int? restroomsCount,
    int? kitchensCount,
    int? occupantsCount,
    int? cleaningsPerWeek,
    CleaningDifficulty? difficulty,
  }) {
    return QuickQuoteInput(
      totalSquareFeet: totalSquareFeet ?? this.totalSquareFeet,
      restroomsCount: restroomsCount ?? this.restroomsCount,
      kitchensCount: kitchensCount ?? this.kitchensCount,
      occupantsCount: occupantsCount ?? this.occupantsCount,
      cleaningsPerWeek: cleaningsPerWeek ?? this.cleaningsPerWeek,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
