import 'package:flutter/foundation.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/site_data.dart';
import '../../domain/entities/service_frequency.dart';
import '../../domain/entities/employee_role.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../domain/entities/special_service.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/quote_summary.dart';
import '../../domain/services/quote_engine.dart';
import '../../core/utils/id_generator.dart';

/// State controller managing the live on-site walkthrough estimate creation wizard.
class EstimateWizardController extends ChangeNotifier {
  final PricingSettings _settings;

  // Wizard current step (0 to 5)
  int _currentStep = 0;

  // Active Draft state
  String _quoteId = '';
  String _quoteNumber = '';

  // 1. Customer Data
  String companyName = '';
  String contactName = '';
  String phone = '';
  String email = '';
  String serviceAddress = '';
  String billingAddress = '';
  String customerNotes = '';

  // 2. Site Data
  SiteData siteData = SiteData.initial();

  // 3. Frequency & Assigned Cleaner Role
  ServiceFrequency frequency = ServiceFrequency.fiveTimesWeekly;
  late EmployeeRole assignedRole;

  // 4. Special Services Line Items
  List<SpecialService> specialServices = [];

  // 5. Custom overrides
  double? customProductionRate;
  double? customHourlyWage;
  double? customBillingRate;
  double? customTargetMargin;
  double? ownerOverridePricePerVisit;

  // Internal & Customer Notes
  String internalNotes = '';
  String customerFacingNotes = '';

  EstimateWizardController(this._settings) {
    _initNewEstimate();
  }

  int get currentStep => _currentStep;
  String get quoteNumber => _quoteNumber;
  PricingSettings get settings => _settings;

  void _initNewEstimate() {
    _quoteId = IdGenerator.generateId('quote');
    _quoteNumber = IdGenerator.generateQuoteNumber();
    assignedRole = _settings.defaultRole;
    specialServices = [];
    siteData = SiteData.initial();
    frequency = ServiceFrequency.fiveTimesWeekly;
    _currentStep = 0;
  }

  void startNewEstimate() {
    _initNewEstimate();
    companyName = '';
    contactName = '';
    phone = '';
    email = '';
    serviceAddress = '';
    billingAddress = '';
    customerNotes = '';
    internalNotes = '';
    customerFacingNotes = '';
    ownerOverridePricePerVisit = null;
    customHourlyWage = null;
    customBillingRate = null;
    customTargetMargin = null;
    customProductionRate = null;
    notifyListeners();
  }

  void loadExistingQuote(Quote quote) {
    _quoteId = quote.id;
    _quoteNumber = quote.quoteNumber;
    companyName = quote.customer.companyName;
    contactName = quote.customer.contactName;
    phone = quote.customer.phone;
    email = quote.customer.email;
    serviceAddress = quote.customer.serviceAddress;
    billingAddress = quote.customer.billingAddress;
    customerNotes = quote.customer.notes;
    siteData = quote.siteData;
    frequency = quote.frequency;
    assignedRole = quote.assignedRole;
    specialServices = List.from(quote.specialServices);
    customProductionRate = quote.customProductionRate;
    customHourlyWage = quote.customHourlyWage;
    customBillingRate = quote.customBillingRate;
    customTargetMargin = quote.customTargetMargin;
    ownerOverridePricePerVisit = quote.ownerOverridePricePerVisit;
    internalNotes = quote.internalNotes;
    customerFacingNotes = quote.customerFacingNotes;
    _currentStep = 0;
    notifyListeners();
  }

  void setStep(int step) {
    if (step >= 0 && step <= 5) {
      _currentStep = step;
      notifyListeners();
    }
  }

  void nextStep() {
    if (_currentStep < 5) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  // Updates for Step 1
  void updateCustomerData({
    required String company,
    required String contact,
    required String phoneNum,
    required String emailAddr,
    required String servAddress,
    required String billAddress,
    required String notes,
  }) {
    companyName = company;
    contactName = contact;
    phone = phoneNum;
    email = emailAddr;
    serviceAddress = servAddress;
    billingAddress = billAddress.isEmpty ? servAddress : billAddress;
    customerNotes = notes;
    notifyListeners();
  }

  // Updates for Step 2
  void updateSiteData(SiteData newSiteData) {
    siteData = newSiteData;
    notifyListeners();
  }

  // Updates for Step 3
  void updateFrequency(ServiceFrequency newFrequency) {
    frequency = newFrequency;
    notifyListeners();
  }

  void updateAssignedRole(EmployeeRole role) {
    assignedRole = role;
    notifyListeners();
  }

  void updateCustomWage(double? wage) {
    customHourlyWage = wage;
    notifyListeners();
  }

  void updateCustomProductionRate(double? rate) {
    customProductionRate = rate;
    notifyListeners();
  }

  // Updates for Step 4
  void addSpecialService(SpecialService service) {
    specialServices.add(service);
    notifyListeners();
  }

  void removeSpecialService(String serviceId) {
    specialServices.removeWhere((s) => s.id == serviceId);
    notifyListeners();
  }

  void updateSpecialService(SpecialService service) {
    final int index = specialServices.indexWhere((s) => s.id == service.id);
    if (index >= 0) {
      specialServices[index] = service;
      notifyListeners();
    }
  }

  // Updates for Step 5 & 6 Pricing Overrides
  void setOwnerOverridePrice(double? price) {
    ownerOverridePricePerVisit = price;
    notifyListeners();
  }

  void setCustomBillingRate(double? rate) {
    customBillingRate = rate;
    notifyListeners();
  }

  void setCustomTargetMargin(double? margin) {
    customTargetMargin = margin;
    notifyListeners();
  }

  /// Calculates the live summary on the fly
  QuoteSummary get currentSummary {
    return QuoteEngine.calculateQuoteSummary(
      site: siteData,
      frequency: frequency,
      role: assignedRole,
      settings: _settings,
      customProductionRate: customProductionRate,
      customHourlyWage: customHourlyWage,
      customBillingRate: customBillingRate,
      customTargetMargin: customTargetMargin,
      ownerOverridePricePerVisit: ownerOverridePricePerVisit,
      specialServices: specialServices,
    );
  }

  /// Builds the complete Quote entity ready to be saved
  Quote buildQuote({QuoteStatus status = QuoteStatus.draft}) {
    final Customer customer = Customer(
      id: IdGenerator.generateId('cust'),
      companyName: companyName.trim().isEmpty ? 'Commercial Office Client' : companyName.trim(),
      contactName: contactName.trim().isEmpty ? 'Site Manager' : contactName.trim(),
      phone: phone.trim(),
      email: email.trim(),
      serviceAddress: serviceAddress.trim().isEmpty ? 'Client Service Location' : serviceAddress.trim(),
      billingAddress: billingAddress.trim().isEmpty ? serviceAddress.trim() : billingAddress.trim(),
      notes: customerNotes.trim(),
      isActiveAccount: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final QuoteSummary summary = currentSummary;

    return Quote(
      id: _quoteId.isEmpty ? IdGenerator.generateId('quote') : _quoteId,
      quoteNumber: _quoteNumber.isEmpty ? IdGenerator.generateQuoteNumber() : _quoteNumber,
      customer: customer,
      siteData: siteData,
      frequency: frequency,
      assignedRole: assignedRole,
      customProductionRate: customProductionRate ?? _settings.defaultProductionRate,
      customHourlyWage: customHourlyWage,
      customBillingRate: customBillingRate,
      customTargetMargin: customTargetMargin,
      ownerOverridePricePerVisit: ownerOverridePricePerVisit,
      specialServices: List.from(specialServices),
      summary: summary,
      status: status,
      internalNotes: internalNotes,
      customerFacingNotes: customerFacingNotes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      expirationDate: DateTime.now().add(const Duration(days: 30)),
      estimatedMinutes: summary.laborBreakdown.finalTotalMinutes,
      estimatedCost: summary.costBreakdown.trueJobCostPerVisit,
      estimatedMargin: summary.pricingResult.grossMarginPercentage,
    );
  }
}
