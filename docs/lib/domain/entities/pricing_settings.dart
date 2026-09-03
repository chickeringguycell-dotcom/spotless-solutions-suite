import 'employee_role.dart';
import 'labor_adjustment.dart';

/// Master configurable pricing settings for the Spotless Solutions estimating engine.
/// All numerical values are configurable placeholders and editable by the studio owner.
class PricingSettings {
  // Production Rates (sq ft per labor hour)
  final double defaultProductionRate; // Default 3,000 sq ft/hr (range 2,000–4,500)

  // Target Billing & Margins
  final double targetBillingRate;     // Reference Method A: $60.00 / hr
  final double targetGrossMargin;     // Reference Method B: 0.40 (40%)
  final double minimumVisitCharge;    // Reference Method C: $125.00 / visit

  // Configurable Profitability Thresholds
  final double greenMarginThreshold;  // Default 0.35 (35%+)
  final double yellowMarginThreshold; // Default 0.25 (25% - 34.99%)

  // Itemized Payroll Burden Categories (Percentages of Direct Labor)
  final double employerPayrollTaxesPercent; // FICA 7.65% + FUTA/SUTA (default 0.085)
  final double workersCompPercent;          // Commercial janitorial WC code (default 0.045)
  final double paidLeaveAllowancePercent;   // Paid family/medical leave (default 0.020)
  final double vacationAllowancePercent;    // Paid time off / holiday (default 0.020)
  final double trainingAllowancePercent;    // Onboarding & safety training (default 0.010)
  final double otherBurdenPercent;          // Uniforms, PPE, bonding (default 0.000)
  final bool useItemizedBurden;
  final double manualCombinedBurdenPercent; // Fallback lump sum (0.18)

  // Supplies & Equipment Allowances
  final double suppliesPercent;        // Default 0.05 (5% of direct labor)
  final double defaultFlatSupplies;
  final bool useFlatSupplies;

  final double equipmentAllowancePercent; // Default 0.03 (3% of direct labor)
  final double defaultFlatEquipment;
  final bool useFlatEquipment;

  // Travel & Mobilization Assumptions
  final double defaultTravelCostPerVisit; // Base travel fee ($0 default)
  final double mileageRate;               // Rate per mile (default $0.67 IRS rate)
  final double mobilizationLaborHourlyWage; // Rate for travel time labor (default $20.00/hr)

  // General Overhead Allocation
  final double overheadPercent;       // Default 0.12 (12% of direct labor)
  final double defaultFlatOverhead;
  final bool useFlatOverhead;

  // Roles & Wage Ladder
  final List<EmployeeRole> wageLadder;
  final String defaultRoleId;

  // Labor Adjustments
  final LaborAdjustmentSettings laborAdjustments;

  // Owner Mode PIN & Security Protection
  final String ownerPin;
  final bool isOwnerModeLocked;

  // Company Information
  final String companyName;
  final String companyPhone;
  final String companyEmail;
  final String companyAddress;

  const PricingSettings({
    this.defaultProductionRate = 3000.0,
    this.targetBillingRate = 60.0,
    this.targetGrossMargin = 0.40,
    this.minimumVisitCharge = 125.0,
    this.greenMarginThreshold = 0.35,
    this.yellowMarginThreshold = 0.25,
    this.employerPayrollTaxesPercent = 0.085,
    this.workersCompPercent = 0.045,
    this.paidLeaveAllowancePercent = 0.020,
    this.vacationAllowancePercent = 0.020,
    this.trainingAllowancePercent = 0.010,
    this.otherBurdenPercent = 0.000,
    this.useItemizedBurden = true,
    this.manualCombinedBurdenPercent = 0.18,
    this.suppliesPercent = 0.05,
    this.defaultFlatSupplies = 0.0,
    this.useFlatSupplies = false,
    this.equipmentAllowancePercent = 0.03,
    this.defaultFlatEquipment = 0.0,
    this.useFlatEquipment = false,
    this.defaultTravelCostPerVisit = 0.0,
    this.mileageRate = 0.67,
    this.mobilizationLaborHourlyWage = 20.0,
    this.overheadPercent = 0.12,
    this.defaultFlatOverhead = 0.0,
    this.useFlatOverhead = false,
    this.wageLadder = const [],
    this.defaultRoleId = 'cleaner',
    this.laborAdjustments = const LaborAdjustmentSettings(),
    this.ownerPin = '1234',
    this.isOwnerModeLocked = false,
    this.companyName = 'Spotless Office Solutions',
    this.companyPhone = '(800) 555-SPOT',
    this.companyEmail = 'quotes@spotlessofficesolutions.example.com',
    this.companyAddress = '100 Enterprise Way, Suite 400, Metro City, ST 12345',
  });

  /// Total combined payroll burden percentage
  double get totalPayrollBurdenPercent {
    if (useItemizedBurden) {
      return employerPayrollTaxesPercent +
          workersCompPercent +
          paidLeaveAllowancePercent +
          vacationAllowancePercent +
          trainingAllowancePercent +
          otherBurdenPercent;
    }
    return manualCombinedBurdenPercent;
  }

  factory PricingSettings.defaultSettings() {
    return PricingSettings(
      defaultProductionRate: 3000.0,
      targetBillingRate: 60.0,
      targetGrossMargin: 0.40,
      minimumVisitCharge: 125.0,
      greenMarginThreshold: 0.35,
      yellowMarginThreshold: 0.25,
      employerPayrollTaxesPercent: 0.085,
      workersCompPercent: 0.045,
      paidLeaveAllowancePercent: 0.020,
      vacationAllowancePercent: 0.020,
      trainingAllowancePercent: 0.010,
      otherBurdenPercent: 0.000,
      suppliesPercent: 0.05,
      equipmentAllowancePercent: 0.03,
      overheadPercent: 0.12,
      wageLadder: EmployeeRole.defaultWageLadder,
      defaultRoleId: 'cleaner',
      laborAdjustments: const LaborAdjustmentSettings(),
    );
  }

  EmployeeRole get defaultRole {
    return wageLadder.firstWhere(
      (r) => r.id == defaultRoleId,
      orElse: () => wageLadder.isNotEmpty ? wageLadder[1] : EmployeeRole.defaultWageLadder[1],
    );
  }

  PricingSettings copyWith({
    double? defaultProductionRate,
    double? targetBillingRate,
    double? targetGrossMargin,
    double? minimumVisitCharge,
    double? greenMarginThreshold,
    double? yellowMarginThreshold,
    double? employerPayrollTaxesPercent,
    double? workersCompPercent,
    double? paidLeaveAllowancePercent,
    double? vacationAllowancePercent,
    double? trainingAllowancePercent,
    double? otherBurdenPercent,
    bool? useItemizedBurden,
    double? manualCombinedBurdenPercent,
    double? suppliesPercent,
    double? defaultFlatSupplies,
    bool? useFlatSupplies,
    double? equipmentAllowancePercent,
    double? defaultFlatEquipment,
    bool? useFlatEquipment,
    double? defaultTravelCostPerVisit,
    double? mileageRate,
    double? mobilizationLaborHourlyWage,
    double? overheadPercent,
    double? defaultFlatOverhead,
    bool? useFlatOverhead,
    List<EmployeeRole>? wageLadder,
    String? defaultRoleId,
    LaborAdjustmentSettings? laborAdjustments,
    String? ownerPin,
    bool? isOwnerModeLocked,
    String? companyName,
    String? companyPhone,
    String? companyEmail,
    String? companyAddress,
  }) {
    return PricingSettings(
      defaultProductionRate: defaultProductionRate ?? this.defaultProductionRate,
      targetBillingRate: targetBillingRate ?? this.targetBillingRate,
      targetGrossMargin: targetGrossMargin ?? this.targetGrossMargin,
      minimumVisitCharge: minimumVisitCharge ?? this.minimumVisitCharge,
      greenMarginThreshold: greenMarginThreshold ?? this.greenMarginThreshold,
      yellowMarginThreshold: yellowMarginThreshold ?? this.yellowMarginThreshold,
      employerPayrollTaxesPercent: employerPayrollTaxesPercent ?? this.employerPayrollTaxesPercent,
      workersCompPercent: workersCompPercent ?? this.workersCompPercent,
      paidLeaveAllowancePercent: paidLeaveAllowancePercent ?? this.paidLeaveAllowancePercent,
      vacationAllowancePercent: vacationAllowancePercent ?? this.vacationAllowancePercent,
      trainingAllowancePercent: trainingAllowancePercent ?? this.trainingAllowancePercent,
      otherBurdenPercent: otherBurdenPercent ?? this.otherBurdenPercent,
      useItemizedBurden: useItemizedBurden ?? this.useItemizedBurden,
      manualCombinedBurdenPercent: manualCombinedBurdenPercent ?? this.manualCombinedBurdenPercent,
      suppliesPercent: suppliesPercent ?? this.suppliesPercent,
      defaultFlatSupplies: defaultFlatSupplies ?? this.defaultFlatSupplies,
      useFlatSupplies: useFlatSupplies ?? this.useFlatSupplies,
      equipmentAllowancePercent: equipmentAllowancePercent ?? this.equipmentAllowancePercent,
      defaultFlatEquipment: defaultFlatEquipment ?? this.defaultFlatEquipment,
      useFlatEquipment: useFlatEquipment ?? this.useFlatEquipment,
      defaultTravelCostPerVisit: defaultTravelCostPerVisit ?? this.defaultTravelCostPerVisit,
      mileageRate: mileageRate ?? this.mileageRate,
      mobilizationLaborHourlyWage: mobilizationLaborHourlyWage ?? this.mobilizationLaborHourlyWage,
      overheadPercent: overheadPercent ?? this.overheadPercent,
      defaultFlatOverhead: defaultFlatOverhead ?? this.defaultFlatOverhead,
      useFlatOverhead: useFlatOverhead ?? this.useFlatOverhead,
      wageLadder: wageLadder ?? this.wageLadder,
      defaultRoleId: defaultRoleId ?? this.defaultRoleId,
      laborAdjustments: laborAdjustments ?? this.laborAdjustments,
      ownerPin: ownerPin ?? this.ownerPin,
      isOwnerModeLocked: isOwnerModeLocked ?? this.isOwnerModeLocked,
      companyName: companyName ?? this.companyName,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
      companyAddress: companyAddress ?? this.companyAddress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'defaultProductionRate': defaultProductionRate,
      'targetBillingRate': targetBillingRate,
      'targetGrossMargin': targetGrossMargin,
      'minimumVisitCharge': minimumVisitCharge,
      'greenMarginThreshold': greenMarginThreshold,
      'yellowMarginThreshold': yellowMarginThreshold,
      'employerPayrollTaxesPercent': employerPayrollTaxesPercent,
      'workersCompPercent': workersCompPercent,
      'paidLeaveAllowancePercent': paidLeaveAllowancePercent,
      'vacationAllowancePercent': vacationAllowancePercent,
      'trainingAllowancePercent': trainingAllowancePercent,
      'otherBurdenPercent': otherBurdenPercent,
      'useItemizedBurden': useItemizedBurden,
      'manualCombinedBurdenPercent': manualCombinedBurdenPercent,
      'suppliesPercent': suppliesPercent,
      'defaultFlatSupplies': defaultFlatSupplies,
      'useFlatSupplies': useFlatSupplies,
      'equipmentAllowancePercent': equipmentAllowancePercent,
      'defaultFlatEquipment': defaultFlatEquipment,
      'useFlatEquipment': useFlatEquipment,
      'defaultTravelCostPerVisit': defaultTravelCostPerVisit,
      'mileageRate': mileageRate,
      'mobilizationLaborHourlyWage': mobilizationLaborHourlyWage,
      'overheadPercent': overheadPercent,
      'defaultFlatOverhead': defaultFlatOverhead,
      'useFlatOverhead': useFlatOverhead,
      'wageLadder': wageLadder.map((r) => r.toJson()).toList(),
      'defaultRoleId': defaultRoleId,
      'laborAdjustments': laborAdjustments.toJson(),
      'ownerPin': ownerPin,
      'isOwnerModeLocked': isOwnerModeLocked,
      'companyName': companyName,
      'companyPhone': companyPhone,
      'companyEmail': companyEmail,
      'companyAddress': companyAddress,
    };
  }

  factory PricingSettings.fromJson(Map<String, dynamic> json) {
    return PricingSettings(
      defaultProductionRate: (json['defaultProductionRate'] as num?)?.toDouble() ?? 3000.0,
      targetBillingRate: (json['targetBillingRate'] as num?)?.toDouble() ?? 60.0,
      targetGrossMargin: (json['targetGrossMargin'] as num?)?.toDouble() ?? 0.40,
      minimumVisitCharge: (json['minimumVisitCharge'] as num?)?.toDouble() ?? 125.0,
      greenMarginThreshold: (json['greenMarginThreshold'] as num?)?.toDouble() ?? 0.35,
      yellowMarginThreshold: (json['yellowMarginThreshold'] as num?)?.toDouble() ?? 0.25,
      employerPayrollTaxesPercent: (json['employerPayrollTaxesPercent'] as num?)?.toDouble() ?? 0.085,
      workersCompPercent: (json['workersCompPercent'] as num?)?.toDouble() ?? 0.045,
      paidLeaveAllowancePercent: (json['paidLeaveAllowancePercent'] as num?)?.toDouble() ?? 0.020,
      vacationAllowancePercent: (json['vacationAllowancePercent'] as num?)?.toDouble() ?? 0.020,
      trainingAllowancePercent: (json['trainingAllowancePercent'] as num?)?.toDouble() ?? 0.010,
      otherBurdenPercent: (json['otherBurdenPercent'] as num?)?.toDouble() ?? 0.000,
      useItemizedBurden: (json['useItemizedBurden'] as bool?) ?? true,
      manualCombinedBurdenPercent: (json['manualCombinedBurdenPercent'] as num?)?.toDouble() ?? 0.18,
      suppliesPercent: (json['suppliesPercent'] as num?)?.toDouble() ?? 0.05,
      defaultFlatSupplies: (json['defaultFlatSupplies'] as num?)?.toDouble() ?? 0.0,
      useFlatSupplies: (json['useFlatSupplies'] as bool?) ?? false,
      equipmentAllowancePercent: (json['equipmentAllowancePercent'] as num?)?.toDouble() ?? 0.03,
      defaultFlatEquipment: (json['defaultFlatEquipment'] as num?)?.toDouble() ?? 0.0,
      useFlatEquipment: (json['useFlatEquipment'] as bool?) ?? false,
      defaultTravelCostPerVisit: (json['defaultTravelCostPerVisit'] as num?)?.toDouble() ?? 0.0,
      mileageRate: (json['mileageRate'] as num?)?.toDouble() ?? 0.67,
      mobilizationLaborHourlyWage: (json['mobilizationLaborHourlyWage'] as num?)?.toDouble() ?? 20.0,
      overheadPercent: (json['overheadPercent'] as num?)?.toDouble() ?? 0.12,
      defaultFlatOverhead: (json['defaultFlatOverhead'] as num?)?.toDouble() ?? 0.0,
      useFlatOverhead: (json['useFlatOverhead'] as bool?) ?? false,
      wageLadder: json['wageLadder'] != null
          ? (json['wageLadder'] as List).map((i) => EmployeeRole.fromJson(i)).toList()
          : EmployeeRole.defaultWageLadder,
      defaultRoleId: (json['defaultRoleId'] as String?) ?? 'cleaner',
      laborAdjustments: json['laborAdjustments'] != null
          ? LaborAdjustmentSettings.fromJson(json['laborAdjustments'])
          : const LaborAdjustmentSettings(),
      ownerPin: (json['ownerPin'] as String?) ?? '1234',
      isOwnerModeLocked: (json['isOwnerModeLocked'] as bool?) ?? false,
      companyName: (json['companyName'] as String?) ?? 'Spotless Solutions Commercial Cleaning',
      companyPhone: (json['companyPhone'] as String?) ?? '(800) 555-SPOT',
      companyEmail: (json['companyEmail'] as String?) ?? 'quotes@spotlesssolutions.example.com',
      companyAddress: (json['companyAddress'] as String?) ?? '100 Enterprise Way, Suite 400, Metro City, ST 12345',
    );
  }
}
