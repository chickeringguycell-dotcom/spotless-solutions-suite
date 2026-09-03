/// Represents the weekly frequency of cleaning visits and monthly visit calculations.
class ServiceFrequency {
  final double visitsPerWeek;
  final String label;
  final bool isCustom;

  const ServiceFrequency({
    required this.visitsPerWeek,
    required this.label,
    this.isCustom = false,
  });

  /// Formula required by Spotless Solutions:
  /// visits_per_month = visits_per_week * 52 / 12
  double get visitsPerMonth => (visitsPerWeek * 52.0) / 12.0;

  static const ServiceFrequency onceWeekly = ServiceFrequency(
    visitsPerWeek: 1.0,
    label: '1x Weekly',
  );

  static const ServiceFrequency twiceWeekly = ServiceFrequency(
    visitsPerWeek: 2.0,
    label: '2x Weekly',
  );

  static const ServiceFrequency threeTimesWeekly = ServiceFrequency(
    visitsPerWeek: 3.0,
    label: '3x Weekly',
  );

  static const ServiceFrequency fiveTimesWeekly = ServiceFrequency(
    visitsPerWeek: 5.0,
    label: '5x Weekly (M-F)',
  );

  static const ServiceFrequency sevenTimesWeekly = ServiceFrequency(
    visitsPerWeek: 7.0,
    label: '7x Weekly (Daily)',
  );

  static List<ServiceFrequency> get standardPresets => [
        onceWeekly,
        twiceWeekly,
        threeTimesWeekly,
        fiveTimesWeekly,
        sevenTimesWeekly,
      ];

  factory ServiceFrequency.custom(double visits) {
    return ServiceFrequency(
      visitsPerWeek: visits,
      label: '${visits.toStringAsFixed(visits.truncateToDouble() == visits ? 0 : 1)}x Weekly (Custom)',
      isCustom: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitsPerWeek': visitsPerWeek,
      'label': label,
      'isCustom': isCustom,
    };
  }

  factory ServiceFrequency.fromJson(Map<String, dynamic> json) {
    return ServiceFrequency(
      visitsPerWeek: (json['visitsPerWeek'] as num).toDouble(),
      label: json['label'] as String,
      isCustom: (json['isCustom'] as bool?) ?? false,
    );
  }
}
