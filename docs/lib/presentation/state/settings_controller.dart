import 'package:flutter/foundation.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../domain/entities/employee_role.dart';
import '../../domain/entities/labor_adjustment.dart';
import '../../data/repositories/settings_repository.dart';

/// State controller managing global owner pricing settings and wage ladder.
class SettingsController extends ChangeNotifier {
  final SettingsRepository _repository;

  SettingsController(this._repository);

  PricingSettings get settings => _repository.getSettings();

  void updateProductionRate(double rate) {
    _repository.updateSettings(settings.copyWith(defaultProductionRate: rate));
    notifyListeners();
  }

  void updateBillingRate(double rate) {
    _repository.updateSettings(settings.copyWith(targetBillingRate: rate));
    notifyListeners();
  }

  void updateTargetGrossMargin(double margin) {
    _repository.updateSettings(settings.copyWith(targetGrossMargin: margin));
    notifyListeners();
  }

  void updateMinimumVisitCharge(double minimumCharge) {
    _repository.updateSettings(settings.copyWith(minimumVisitCharge: minimumCharge));
    notifyListeners();
  }

  void updatePayrollBurdenPercent(double burden) {
    _repository.updateSettings(settings.copyWith(payrollBurdenPercent: burden));
    notifyListeners();
  }

  void updateSuppliesPercent(double suppliesPct) {
    _repository.updateSettings(settings.copyWith(suppliesPercent: suppliesPct));
    notifyListeners();
  }

  void updateEquipmentPercent(double equipPct) {
    _repository.updateSettings(settings.copyWith(equipmentAllowancePercent: equipPct));
    notifyListeners();
  }

  void updateOverheadPercent(double overheadPct) {
    _repository.updateSettings(settings.copyWith(overheadPercent: overheadPct));
    notifyListeners();
  }

  void updateTravelCostPerVisit(double travelCost) {
    _repository.updateSettings(settings.copyWith(defaultTravelCostPerVisit: travelCost));
    notifyListeners();
  }

  void updateEmployeeWage(String roleId, double newWage) {
    final List<EmployeeRole> updatedList = settings.wageLadder.map((r) {
      if (r.id == roleId) {
        return r.copyWith(defaultHourlyWage: newWage);
      }
      return r;
    }).toList();

    _repository.updateSettings(settings.copyWith(wageLadder: updatedList));
    notifyListeners();
  }

  void updateLaborAdjustments(LaborAdjustmentSettings adjustments) {
    _repository.updateSettings(settings.copyWith(laborAdjustments: adjustments));
    notifyListeners();
  }

  void updateCompanyInfo({
    required String name,
    required String phone,
    required String email,
    required String address,
  }) {
    _repository.updateSettings(settings.copyWith(
      companyName: name,
      companyPhone: phone,
      companyEmail: email,
      companyAddress: address,
    ));
    notifyListeners();
  }

  void resetToDefaults() {
    _repository.resetToDefaults();
    notifyListeners();
  }
}
