import 'package:flutter/material.dart';
import '../state/settings_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';

/// Settings & Owner Configuration Screen for all pricing formulas, wage ladders, and rates.
class SettingsScreen extends StatefulWidget {
  final SettingsController settingsController;

  const SettingsScreen({super.key, required this.settingsController});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.settingsController.addListener(_onSettingsChange);
  }

  @override
  void dispose() {
    widget.settingsController.removeListener(_onSettingsChange);
    super.dispose();
  }

  void _onSettingsChange() {
    if (mounted) setState(() {});
  }

  void _editEmployeeWageDialog(String roleId, String title, double currentWage) {
    final controller = TextEditingController(text: currentWage.toStringAsFixed(2));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit Wage: $title', style: const TextStyle(fontWeight: FontWeight.w800)),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(prefixText: '\$ ', labelText: 'Hourly Wage Rate (\$/hr)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final double? newWage = double.tryParse(controller.text);
              if (newWage != null && newWage > 0) {
                widget.settingsController.updateEmployeeWage(roleId, newWage);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Wage'),
          ),
        ],
      ),
    );
  }

  void _editNumberSettingDialog({
    required String title,
    required String label,
    required double currentValue,
    required ValueChanged<double> onSaved,
    String? prefix,
    String? suffix,
  }) {
    final controller = TextEditingController(text: currentValue.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: label,
            prefixText: prefix,
            suffixText: suffix,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final double? val = double.tryParse(controller.text);
              if (val != null) {
                onSaved(val);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Setting'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settingsController.settings;
    final adj = settings.laborAdjustments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Engine Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Reset to Factory Defaults',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Reset All Settings?'),
                  content: const Text('This will reset all production rates, wage ladders, multipliers, and pricing targets to defaults.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                      onPressed: () {
                        widget.settingsController.resetToDefaults();
                        Navigator.pop(ctx);
                      },
                      child: const Text('Reset to Defaults'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Transparency Notice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'All adjustment values are configurable starting assumptions. Update them to match your real Spotless Solutions operating performance.',
                    style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _buildHeader('1. Core Pricing & Production Rates'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Standard Office Production Rate', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Baseline cleanable area per labor hour (2,000–4,500 sqft)'),
                  trailing: Text('${CurrencyFormatter.formatNumber(settings.defaultProductionRate)} sqft/hr',
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Production Rate',
                    label: 'Square Feet Cleaned Per Labor Hour',
                    currentValue: settings.defaultProductionRate,
                    suffix: ' sqft/hr',
                    onSaved: (v) => widget.settingsController.updateProductionRate(v),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Target Billing Rate (Reference Method A)', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Internal target charged per labor hour'),
                  trailing: Text('${CurrencyFormatter.formatCurrency(settings.targetBillingRate)}/hr',
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Target Billing Rate',
                    label: 'Dollars per labor hour',
                    currentValue: settings.targetBillingRate,
                    prefix: '\$ ',
                    suffix: ' / hr',
                    onSaved: (v) => widget.settingsController.updateBillingRate(v),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Target Gross Margin (Reference Method B)', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Target gross profit margin percentage'),
                  trailing: Text(CurrencyFormatter.formatPercent(settings.targetGrossMargin),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.success)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Target Gross Margin',
                    label: 'Gross margin fraction (e.g. 0.40 for 40%)',
                    currentValue: settings.targetGrossMargin,
                    onSaved: (v) {
                      final double fraction = v > 1.0 ? v / 100.0 : v;
                      widget.settingsController.updateTargetGrossMargin(fraction);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Minimum Service Charge Floor (Reference Method C)', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Absolute minimum price per commercial visit'),
                  trailing: Text(CurrencyFormatter.formatCurrency(settings.minimumVisitCharge),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Minimum Service Charge',
                    label: 'Minimum charge per visit',
                    currentValue: settings.minimumVisitCharge,
                    prefix: '\$ ',
                    onSaved: (v) => widget.settingsController.updateMinimumVisitCharge(v),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          _buildHeader('2. Room & Fixture Additive Times (Minutes)'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Toilet Time', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerToilet.toStringAsFixed(0)} min / toilet', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Toilet Cleaning Time',
                    label: 'Minutes per toilet',
                    currentValue: adj.minutesPerToilet,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerToilet: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Urinal Time', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerUrinal.toStringAsFixed(0)} min / urinal', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Urinal Cleaning Time',
                    label: 'Minutes per urinal',
                    currentValue: adj.minutesPerUrinal,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerUrinal: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Sink Time', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerSink.toStringAsFixed(0)} min / sink', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Sink Cleaning Time',
                    label: 'Minutes per sink',
                    currentValue: adj.minutesPerSink,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerSink: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Shower Time', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerShower.toStringAsFixed(0)} min / shower', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Shower Cleaning Time',
                    label: 'Minutes per shower',
                    currentValue: adj.minutesPerShower,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerShower: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Standard Breakroom', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerStandardBreakroom.toStringAsFixed(0)} min', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Standard Breakroom',
                    label: 'Minutes per standard breakroom',
                    currentValue: adj.minutesPerStandardBreakroom,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerStandardBreakroom: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Large / Full Commercial Kitchen', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerLargeKitchen.toStringAsFixed(0)} min', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Large Kitchen',
                    label: 'Minutes per full kitchen',
                    currentValue: adj.minutesPerLargeKitchen,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerLargeKitchen: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Conference Room', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerConferenceRoom.toStringAsFixed(0)} min', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Conference Room',
                    label: 'Minutes per conference room',
                    currentValue: adj.minutesPerConferenceRoom,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerConferenceRoom: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Staircase Flight', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text('+${adj.minutesPerStaircase.toStringAsFixed(0)} min', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Stairs Flight Time',
                    label: 'Minutes per staircase',
                    currentValue: adj.minutesPerStaircase,
                    suffix: ' min',
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(minutesPerStaircase: v)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          _buildHeader('3. Traffic, Trash & Condition Multipliers'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Traffic Multipliers (Low / Normal / High / Very High)', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Current: ${adj.trafficLowMultiplier.toStringAsFixed(2)}x / ${adj.trafficNormalMultiplier.toStringAsFixed(2)}x / ${adj.trafficHighMultiplier.toStringAsFixed(2)}x / ${adj.trafficVeryHighMultiplier.toStringAsFixed(2)}x'),
                  trailing: const Icon(Icons.edit, size: 16),
                  onTap: () => _editNumberSettingDialog(
                    title: 'High Traffic Multiplier',
                    label: 'High Traffic Multiplier (e.g. 1.15 for +15%)',
                    currentValue: adj.trafficHighMultiplier,
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(trafficHighMultiplier: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Trash Multipliers (Light / Normal / Heavy / Very Heavy)', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Current: ${adj.trashLightMultiplier.toStringAsFixed(2)}x / ${adj.trashNormalMultiplier.toStringAsFixed(2)}x / ${adj.trashHeavyMultiplier.toStringAsFixed(2)}x / ${adj.trashVeryHeavyMultiplier.toStringAsFixed(2)}x'),
                  trailing: const Icon(Icons.edit, size: 16),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Heavy Trash Multiplier',
                    label: 'Heavy Trash Multiplier (e.g. 1.12 for +12%)',
                    currentValue: adj.trashHeavyMultiplier,
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(trashHeavyMultiplier: v)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Condition Multipliers (Excellent / Normal / Needs Impr / Heavy Soil)', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Current: ${adj.conditionExcellentMultiplier.toStringAsFixed(2)}x / ${adj.conditionNormalMultiplier.toStringAsFixed(2)}x / ${adj.conditionNeedsImprovementMultiplier.toStringAsFixed(2)}x / ${adj.conditionHeavySoilMultiplier.toStringAsFixed(2)}x'),
                  trailing: const Icon(Icons.edit, size: 16),
                  onTap: () => _editNumberSettingDialog(
                    title: 'Heavy Soil Multiplier',
                    label: 'Heavy Soil Multiplier (e.g. 1.25 for +25%)',
                    currentValue: adj.conditionHeavySoilMultiplier,
                    onSaved: (v) => widget.settingsController.updateLaborAdjustments(adj.copyWith(conditionHeavySoilMultiplier: v)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          _buildHeader('4. Employee Wage Ladder'),
          Card(
            child: Column(
              children: settings.wageLadder.map((role) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(role.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(role.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${CurrencyFormatter.formatCurrency(role.defaultHourlyWage)}/hr',
                              style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                          const SizedBox(width: 6),
                          const Icon(Icons.edit, size: 16, color: AppColors.textMuted),
                        ],
                      ),
                      onTap: () => _editEmployeeWageDialog(role.id, role.title, role.defaultHourlyWage),
                    ),
                    if (role != settings.wageLadder.last) const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 18),
          _buildHeader('5. Itemized Payroll Burden & Cost Allowances'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Employer Payroll Taxes (FICA/FUTA/SUTA)', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text(CurrencyFormatter.formatPercent(settings.employerPayrollTaxesPercent),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Workers\' Comp Insurance', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text(CurrencyFormatter.formatPercent(settings.workersCompPercent),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Paid Leave & Vacation Allowance', style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: Text(CurrencyFormatter.formatPercent(settings.paidLeaveAllowancePercent + settings.vacationAllowancePercent),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Total Combined Payroll Burden', style: TextStyle(fontWeight: FontWeight.w800)),
                  trailing: Text(CurrencyFormatter.formatPercent(settings.totalPayrollBurdenPercent),
                      style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary, fontSize: 16)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
