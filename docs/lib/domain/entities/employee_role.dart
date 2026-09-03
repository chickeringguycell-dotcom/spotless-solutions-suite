/// Represents an employee role and configurable wage ladder tier.
class EmployeeRole {
  final String id;
  final String title;
  final double defaultHourlyWage;
  final double minHourlyWage;
  final double maxHourlyWage;
  final String description;

  const EmployeeRole({
    required this.id,
    required this.title,
    required this.defaultHourlyWage,
    required this.minHourlyWage,
    required this.maxHourlyWage,
    required this.description,
  });

  EmployeeRole copyWith({
    String? id,
    String? title,
    double? defaultHourlyWage,
    double? minHourlyWage,
    double? maxHourlyWage,
    String? description,
  }) {
    return EmployeeRole(
      id: id ?? this.id,
      title: title ?? this.title,
      defaultHourlyWage: defaultHourlyWage ?? this.defaultHourlyWage,
      minHourlyWage: minHourlyWage ?? this.minHourlyWage,
      maxHourlyWage: maxHourlyWage ?? this.maxHourlyWage,
      description: description ?? this.description,
    );
  }

  /// Default wage ladder as specified in requirements
  static List<EmployeeRole> get defaultWageLadder => const [
        EmployeeRole(
          id: 'trainee',
          title: 'Trainee Cleaner',
          defaultHourlyWage: 22.0,
          minHourlyWage: 22.0,
          maxHourlyWage: 22.0,
          description: 'Entry level cleaner under direct supervision',
        ),
        EmployeeRole(
          id: 'cleaner',
          title: 'Cleaner',
          defaultHourlyWage: 24.0,
          minHourlyWage: 23.0,
          maxHourlyWage: 25.0,
          description: 'Standard independent commercial office cleaner',
        ),
        EmployeeRole(
          id: 'senior_cleaner',
          title: 'Senior Cleaner',
          defaultHourlyWage: 26.0,
          minHourlyWage: 26.0,
          maxHourlyWage: 26.0,
          description: 'Experienced cleaner with specialized floor & sanitation skills',
        ),
        EmployeeRole(
          id: 'lead_cleaner',
          title: 'Lead Cleaner',
          defaultHourlyWage: 28.0,
          minHourlyWage: 27.0,
          maxHourlyWage: 29.0,
          description: 'Team leader responsible for job execution & quality checks',
        ),
        EmployeeRole(
          id: 'supervisor',
          title: 'Supervisor',
          defaultHourlyWage: 31.50,
          minHourlyWage: 30.0,
          maxHourlyWage: 33.0,
          description: 'Site supervisor managing multi-floor & complex facility accounts',
        ),
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'defaultHourlyWage': defaultHourlyWage,
      'minHourlyWage': minHourlyWage,
      'maxHourlyWage': maxHourlyWage,
      'description': description,
    };
  }

  factory EmployeeRole.fromJson(Map<String, dynamic> json) {
    return EmployeeRole(
      id: json['id'] as String,
      title: json['title'] as String,
      defaultHourlyWage: (json['defaultHourlyWage'] as num).toDouble(),
      minHourlyWage: (json['minHourlyWage'] as num).toDouble(),
      maxHourlyWage: (json['maxHourlyWage'] as num).toDouble(),
      description: (json['description'] as String?) ?? '',
    );
  }
}
