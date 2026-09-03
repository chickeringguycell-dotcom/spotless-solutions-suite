enum SpecialPricingType {
  flatPrice,
  perSquareFoot,
  perHour,
  perUnit;

  String get displayName {
    switch (this) {
      case SpecialPricingType.flatPrice:
        return 'Flat Price (\$)';
      case SpecialPricingType.perSquareFoot:
        return 'Per Sq Ft (\$/sqft)';
      case SpecialPricingType.perHour:
        return 'Per Labor Hour (\$/hr)';
      case SpecialPricingType.perUnit:
        return 'Per Unit / Item (\$)';
    }
  }

  String get unitLabel {
    switch (this) {
      case SpecialPricingType.flatPrice:
        return 'Job';
      case SpecialPricingType.perSquareFoot:
        return 'sq ft';
      case SpecialPricingType.perHour:
        return 'hrs';
      case SpecialPricingType.perUnit:
        return 'units';
    }
  }
}

/// Represents a distinct add-on or periodic special commercial service line item.
class SpecialService {
  final String id;
  final String serviceName;
  final String description;
  final SpecialPricingType pricingType;
  final double unitRate;
  final double quantity;
  final bool isRecurringMonthly; // If true, adds to monthly recurring contract, else one-time charge

  const SpecialService({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.pricingType,
    required this.unitRate,
    this.quantity = 1.0,
    this.isRecurringMonthly = false,
  });

  /// Calculates line item total
  double get totalPrice {
    switch (pricingType) {
      case SpecialPricingType.flatPrice:
        return unitRate;
      case SpecialPricingType.perSquareFoot:
      case SpecialPricingType.perHour:
      case SpecialPricingType.perUnit:
        return unitRate * quantity;
    }
  }

  SpecialService copyWith({
    String? id,
    String? serviceName,
    String? description,
    SpecialPricingType? pricingType,
    double? unitRate,
    double? quantity,
    bool? isRecurringMonthly,
  }) {
    return SpecialService(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      pricingType: pricingType ?? this.pricingType,
      unitRate: unitRate ?? this.unitRate,
      quantity: quantity ?? this.quantity,
      isRecurringMonthly: isRecurringMonthly ?? this.isRecurringMonthly,
    );
  }

  /// Preset catalog of standard commercial specialty services
  static List<SpecialService> get standardCatalog => const [
        SpecialService(
          id: 'initial_deep_clean',
          serviceName: 'Initial Deep Clean',
          description: 'Comprehensive restorative clean before initiating recurring service',
          pricingType: SpecialPricingType.perSquareFoot,
          unitRate: 0.15,
          quantity: 5000,
        ),
        SpecialService(
          id: 'carpet_extraction',
          serviceName: 'Carpet Extraction / Shampoo',
          description: 'Deep hot-water steam extraction for high traffic & common area carpets',
          pricingType: SpecialPricingType.perSquareFoot,
          unitRate: 0.22,
          quantity: 3500,
        ),
        SpecialService(
          id: 'floor_stripping',
          serviceName: 'Floor Stripping',
          description: 'Complete removal of old wax and chemical scrub down to bare VCT/vinyl',
          pricingType: SpecialPricingType.perSquareFoot,
          unitRate: 0.45,
          quantity: 1500,
        ),
        SpecialService(
          id: 'floor_waxing',
          serviceName: 'Floor Waxing & Buffing',
          description: 'Application of 3-4 coats of commercial high-gloss protective finish',
          pricingType: SpecialPricingType.perSquareFoot,
          unitRate: 0.30,
          quantity: 1500,
        ),
        SpecialService(
          id: 'interior_windows',
          serviceName: 'Interior Window Cleaning',
          description: 'Streak-free cleaning of all interior glass, partitions, and doors',
          pricingType: SpecialPricingType.perUnit,
          unitRate: 6.0,
          quantity: 20,
        ),
        SpecialService(
          id: 'exterior_windows',
          serviceName: 'Exterior Window Cleaning (Ground Level)',
          description: 'Exterior pane washing up to 2 stories',
          pricingType: SpecialPricingType.perUnit,
          unitRate: 10.0,
          quantity: 20,
        ),
        SpecialService(
          id: 'pressure_washing',
          serviceName: 'Exterior Pressure Washing',
          description: 'High-pressure wash for walkways, building entryways, and dumpsters',
          pricingType: SpecialPricingType.perSquareFoot,
          unitRate: 0.25,
          quantity: 1000,
        ),
        SpecialService(
          id: 'post_construction',
          serviceName: 'Post-Construction Clean',
          description: 'Heavy drywall dust, paint overspray, sticker removal and fine detailing',
          pricingType: SpecialPricingType.perSquareFoot,
          unitRate: 0.50,
          quantity: 5000,
        ),
        SpecialService(
          id: 'high_dusting',
          serviceName: 'High Dusting (> 10 ft)',
          description: 'Dusting of exposed HVAC ducts, ceiling rafters, high ledges & lighting',
          pricingType: SpecialPricingType.perHour,
          unitRate: 75.0,
          quantity: 4.0,
        ),
        SpecialService(
          id: 'appliance_cleaning',
          serviceName: 'Breakroom Appliance Detail',
          description: 'Deep interior/exterior cleaning of refrigerators, microwaves & ovens',
          pricingType: SpecialPricingType.perUnit,
          unitRate: 45.0,
          quantity: 2.0,
        ),
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'description': description,
      'pricingType': pricingType.name,
      'unitRate': unitRate,
      'quantity': quantity,
      'isRecurringMonthly': isRecurringMonthly,
    };
  }

  factory SpecialService.fromJson(Map<String, dynamic> json) {
    return SpecialService(
      id: json['id'] as String,
      serviceName: json['serviceName'] as String,
      description: (json['description'] as String?) ?? '',
      pricingType: SpecialPricingType.values.firstWhere(
        (e) => e.name == json['pricingType'],
        orElse: () => SpecialPricingType.flatPrice,
      ),
      unitRate: (json['unitRate'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1.0,
      isRecurringMonthly: (json['isRecurringMonthly'] as bool?) ?? false,
    );
  }
}
