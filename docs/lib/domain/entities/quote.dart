import 'customer.dart';
import 'site_data.dart';
import 'service_frequency.dart';
import 'employee_role.dart';
import 'special_service.dart';
import 'quote_summary.dart';

enum QuoteStatus {
  draft,
  sent,
  accepted,
  rejected,
  convertedToCustomer;

  String get displayName {
    switch (this) {
      case QuoteStatus.draft:
        return 'Draft';
      case QuoteStatus.sent:
        return 'Sent to Client';
      case QuoteStatus.accepted:
        return 'Accepted';
      case QuoteStatus.rejected:
        return 'Rejected';
      case QuoteStatus.convertedToCustomer:
        return 'Active Customer';
    }
  }
}

/// Represents a commercial cleaning quote proposal including estimate vs actual learning fields.
class Quote {
  final String id;
  final String quoteNumber;
  final Customer customer;
  final SiteData siteData;
  final ServiceFrequency frequency;
  final EmployeeRole assignedRole;
  final double customProductionRate;
  final double? customHourlyWage;
  final double? customBillingRate;
  final double? customTargetMargin;
  final double? ownerOverridePricePerVisit;
  final List<SpecialService> specialServices;
  final QuoteSummary summary;
  final QuoteStatus status;
  final String internalNotes;
  final String customerFacingNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? sentAt;
  final DateTime? acceptedAt;
  final DateTime expirationDate;

  // Estimate vs Actual Learning Data (Prepared for future performance calibration)
  final double estimatedMinutes;
  final double? actualMinutes;
  final double estimatedCost;
  final double? actualCost;
  final double estimatedMargin;
  final double? actualMargin;
  final String? actualCompletionNotes;
  final DateTime? actualCompletedDate;

  const Quote({
    required this.id,
    required this.quoteNumber,
    required this.customer,
    required this.siteData,
    required this.frequency,
    required this.assignedRole,
    this.customProductionRate = 3000.0,
    this.customHourlyWage,
    this.customBillingRate,
    this.customTargetMargin,
    this.ownerOverridePricePerVisit,
    this.specialServices = const [],
    required this.summary,
    this.status = QuoteStatus.draft,
    this.internalNotes = '',
    this.customerFacingNotes = '',
    required this.createdAt,
    required this.updatedAt,
    this.sentAt,
    this.acceptedAt,
    required this.expirationDate,
    required this.estimatedMinutes,
    this.actualMinutes,
    required this.estimatedCost,
    this.actualCost,
    required this.estimatedMargin,
    this.actualMargin,
    this.actualCompletionNotes,
    this.actualCompletedDate,
  });

  Quote copyWith({
    String? id,
    String? quoteNumber,
    Customer? customer,
    SiteData? siteData,
    ServiceFrequency? frequency,
    EmployeeRole? assignedRole,
    double? customProductionRate,
    double? customHourlyWage,
    double? customBillingRate,
    double? customTargetMargin,
    double? ownerOverridePricePerVisit,
    List<SpecialService>? specialServices,
    QuoteSummary? summary,
    QuoteStatus? status,
    String? internalNotes,
    String? customerFacingNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? sentAt,
    DateTime? acceptedAt,
    DateTime? expirationDate,
    double? estimatedMinutes,
    double? actualMinutes,
    double? estimatedCost,
    double? actualCost,
    double? estimatedMargin,
    double? actualMargin,
    String? actualCompletionNotes,
    DateTime? actualCompletedDate,
  }) {
    return Quote(
      id: id ?? this.id,
      quoteNumber: quoteNumber ?? this.quoteNumber,
      customer: customer ?? this.customer,
      siteData: siteData ?? this.siteData,
      frequency: frequency ?? this.frequency,
      assignedRole: assignedRole ?? this.assignedRole,
      customProductionRate: customProductionRate ?? this.customProductionRate,
      customHourlyWage: customHourlyWage ?? this.customHourlyWage,
      customBillingRate: customBillingRate ?? this.customBillingRate,
      customTargetMargin: customTargetMargin ?? this.customTargetMargin,
      ownerOverridePricePerVisit: ownerOverridePricePerVisit ?? this.ownerOverridePricePerVisit,
      specialServices: specialServices ?? this.specialServices,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      internalNotes: internalNotes ?? this.internalNotes,
      customerFacingNotes: customerFacingNotes ?? this.customerFacingNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      sentAt: sentAt ?? this.sentAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      expirationDate: expirationDate ?? this.expirationDate,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      actualCost: actualCost ?? this.actualCost,
      estimatedMargin: estimatedMargin ?? this.estimatedMargin,
      actualMargin: actualMargin ?? this.actualMargin,
      actualCompletionNotes: actualCompletionNotes ?? this.actualCompletionNotes,
      actualCompletedDate: actualCompletedDate ?? this.actualCompletedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteNumber': quoteNumber,
      'customer': customer.toJson(),
      'siteData': siteData.toJson(),
      'frequency': frequency.toJson(),
      'assignedRole': assignedRole.toJson(),
      'customProductionRate': customProductionRate,
      'customHourlyWage': customHourlyWage,
      'customBillingRate': customBillingRate,
      'customTargetMargin': customTargetMargin,
      'ownerOverridePricePerVisit': ownerOverridePricePerVisit,
      'specialServices': specialServices.map((s) => s.toJson()).toList(),
      'summary': summary.toJson(),
      'status': status.name,
      'internalNotes': internalNotes,
      'customerFacingNotes': customerFacingNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'expirationDate': expirationDate.toIso8601String(),
      'estimatedMinutes': estimatedMinutes,
      'actualMinutes': actualMinutes,
      'estimatedCost': estimatedCost,
      'actualCost': actualCost,
      'estimatedMargin': estimatedMargin,
      'actualMargin': actualMargin,
      'actualCompletionNotes': actualCompletionNotes,
      'actualCompletedDate': actualCompletedDate?.toIso8601String(),
    };
  }
}
