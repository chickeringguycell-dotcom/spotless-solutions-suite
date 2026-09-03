import 'package:flutter/material.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/service_frequency.dart';
import '../../../domain/entities/employee_role.dart';

/// Step 3: Service Frequency, Cleaner Role Assignment & Production Rate Tuning.
class Step3FrequencyRoleScreen extends StatefulWidget {
  final EstimateWizardController controller;

  const Step3FrequencyRoleScreen({super.key, required this.controller});

  @override
  State<Step3FrequencyRoleScreen> createState() => _Step3FrequencyRoleScreenState();
}

class _Step3FrequencyRoleScreenState extends State<Step3FrequencyRoleScreen> {
  late double _customVisits;
  late TextEditingController _customVisitsController;
  late TextEditingController _productionRateController;
  late TextEditingController _customWageController;

  @override
  void initState() {
    super.initState();
    final ctrl = widget.controller;
    _customVisits = ctrl.frequency.visitsPerWeek;
    _customVisitsController = TextEditingController(text: _customVisits.toStringAsFixed(1));
    _productionRateController = TextEditingController(
      text: (ctrl.customProductionRate ?? ctrl.settings.defaultProductionRate).toStringAsFixed(0),
    );
    _customWageController = TextEditingController(
      text: (ctrl.customHourlyWage ?? ctrl.assignedRole.defaultHourlyWage).toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _customVisitsController.dispose();
    _productionRateController.dispose();
    _customWageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;
    final settings = ctrl.settings;
    final selectedFrequency = ctrl.frequency;
    final selectedRole = ctrl.assignedRole;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('1. Service Frequency'),
          const Text(
            'Select how often the office requires scheduled cleaning visits.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 12),

          // Preset Frequency Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ServiceFrequency.standardPresets.map((freq) {
              final bool isSelected = !selectedFrequency.isCustom &&
                  selectedFrequency.visitsPerWeek == freq.visitsPerWeek;

              return ChoiceChip(
                label: Text(freq.label),
                selected: isSelected,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                onSelected: (selected) {
                  if (selected) {
                    ctrl.updateFrequency(freq);
                  }
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          // Calculated Monthly Visits Callout
          Card(
            color: const Color(0xFFF0FDF4),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, color: AppColors.success, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estimated Monthly Visits (52 wks / 12 mos):',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        Text(
                          '${CurrencyFormatter.formatDecimal(selectedFrequency.visitsPerMonth)} visits / month',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('2. Assigned Employee Role & Wage Ladder'),
          const Text(
            'Choose the employee experience level recommended for this account.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 12),

          // Role selection cards
          ...settings.wageLadder.map((role) {
            final bool isSelected = selectedRole.id == role.id;

            return Card(
              color: isSelected ? const Color(0xFFF0F7FF) : AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? AppColors.accent : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  ctrl.updateAssignedRole(role);
                  _customWageController.text = role.defaultHourlyWage.toStringAsFixed(2);
                  ctrl.updateCustomWage(null);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: role.id,
                        groupValue: selectedRole.id,
                        activeColor: AppColors.accent,
                        onChanged: (_) {
                          ctrl.updateAssignedRole(role);
                          _customWageController.text = role.defaultHourlyWage.toStringAsFixed(2);
                          ctrl.updateCustomWage(null);
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              role.description,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${CurrencyFormatter.formatCurrency(role.defaultHourlyWage)}/hr',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 16),
          // Custom Wage Override for this quote
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Custom Hourly Wage for This Job', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _customWageController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        hintText: '24.00',
                      ),
                      onChanged: (val) {
                        final double? wage = double.tryParse(val.trim());
                        ctrl.updateCustomWage(wage);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Production Rate (Sq Ft/Hr)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _productionRateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        suffixText: 'sqft/hr',
                        hintText: '3000',
                      ),
                      onChanged: (val) {
                        final double? rate = double.tryParse(val.trim());
                        ctrl.updateCustomProductionRate(rate);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => ctrl.previousStep(),
                  child: const Text('Back to Walkthrough'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => ctrl.nextStep(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Special Services'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: -0.2,
      ),
    );
  }
}
