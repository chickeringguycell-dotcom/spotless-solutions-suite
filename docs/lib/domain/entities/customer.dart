/// Represents a commercial client with contact and address details.
class Customer {
  final String id;
  final String companyName;
  final String contactName;
  final String phone;
  final String email;
  final String serviceAddress;
  final String billingAddress;
  final String notes;
  final bool isActiveAccount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Customer({
    required this.id,
    required this.companyName,
    required this.contactName,
    required this.phone,
    required this.email,
    required this.serviceAddress,
    required this.billingAddress,
    this.notes = '',
    this.isActiveAccount = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Customer copyWith({
    String? id,
    String? companyName,
    String? contactName,
    String? phone,
    String? email,
    String? serviceAddress,
    String? billingAddress,
    String? notes,
    bool? isActiveAccount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      serviceAddress: serviceAddress ?? this.serviceAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      notes: notes ?? this.notes,
      isActiveAccount: isActiveAccount ?? this.isActiveAccount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'contactName': contactName,
      'phone': phone,
      'email': email,
      'serviceAddress': serviceAddress,
      'billingAddress': billingAddress,
      'notes': notes,
      'isActiveAccount': isActiveAccount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      companyName: json['companyName'] as String,
      contactName: json['contactName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      serviceAddress: json['serviceAddress'] as String,
      billingAddress: json['billingAddress'] as String,
      notes: (json['notes'] as String?) ?? '',
      isActiveAccount: (json['isActiveAccount'] as bool?) ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
