import 'package:flutter/material.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/id_generator.dart';
import '../../../domain/entities/special_service.dart';

/// Step 4: Special Services, Periodic Maintenance & Add-on Line Items.
class Step4SpecialServicesScreen extends StatelessWidget {
  final EstimateWizardController controller;

  const Step4SpecialServicesScreen({super.key, required this.controller});

  void _showAddServiceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddServiceBottomSheet(controller: controller),
    );
  }

  void _showCustomServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _CustomServiceDialog(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<SpecialService> currentServices = controller.specialServices;
    final double oneTimeTotal = controller.currentSummary.oneTimeSpecialServicesTotal;
    final double recurringTotal = controller.currentSummary.recurringSpecialServicesMonthlyTotal;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Special Services & Add-ons',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: AppColors.accent,
                ),
                onPressed: () => _showAddServiceDialog(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Service', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Add restorative or periodic services (carpet extraction, waxing, windows, deep cleans).',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          if (currentServices.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.cleaning_services_outlined, size: 48, color: AppColors.primary.withOpacity(0.3)),
                      const SizedBox(height: 12),
                      const Text(
                        'No Special Services Added',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Tap "Add Service" to select from our standard catalog or create a custom service.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () => _showAddServiceDialog(context),
                        icon: const Icon(Icons.playlist_add),
                        label: const Text('Browse Specialty Catalog'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else ...[
            ...currentServices.map((service) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.serviceName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: service.isRecurringMonthly
                                  ? const Color(0xFFE0F2FE)
                                  : const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              service.isRecurringMonthly ? 'Monthly Recurring' : 'One-Time Setup',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: service.isRecurringMonthly ? AppColors.primary : AppColors.warning,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                            onPressed: () => controller.removeSpecialService(service.id),
                          ),
                        ],
                      ),
                      Text(
                        service.description,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${CurrencyFormatter.formatCurrency(service.unitRate)} / ${service.pricingType.unitLabel} × ${CurrencyFormatter.formatNumber(service.quantity)} ${service.pricingType.unitLabel}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                          Text(
                            CurrencyFormatter.formatCurrency(service.totalPrice),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
            Card(
              color: const Color(0xFFF8FAFC),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('One-Time Services Total:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text(CurrencyFormatter.formatCurrency(oneTimeTotal),
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Monthly Recurring Services:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('${CurrencyFormatter.formatCurrency(recurringTotal)} / mo',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.primary)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.previousStep(),
                  child: const Text('Back to Frequency'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.nextStep(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Labor & Cost Review'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddServiceBottomSheet extends StatelessWidget {
  final EstimateWizardController controller;

  const _AddServiceBottomSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    final catalog = SpecialService.standardCatalog;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Special Service',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: catalog.length,
              itemBuilder: (ctx, index) {
                final item = catalog[index];
                return ListTile(
                  title: Text(item.serviceName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text(item.description, style: const TextStyle(fontSize: 12)),
                  trailing: Text(
                    '${CurrencyFormatter.formatCurrency(item.unitRate)} / ${item.pricingType.unitLabel}',
                    style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary),
                  ),
                  onTap: () {
                    final newService = item.copyWith(id: IdGenerator.generateId('spec'));
                    controller.addSpecialService(newService);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomServiceDialog extends StatefulWidget {
  final EstimateWizardController controller;

  const _CustomServiceDialog({required this.controller});

  @override
  State<_CustomServiceDialog> createState() => _CustomServiceDialogState();
}

class _CustomServiceDialogState extends State<_CustomServiceDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _rateController = TextEditingController(text: '100');
  final _qtyController = TextEditingController(text: '1');
  SpecialPricingType _type = SpecialPricingType.flatPrice;
  bool _isRecurring = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Custom Service', style: TextStyle(fontWeight: FontWeight.w800)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Service Name *', hintText: 'e.g. High Pressure Wash'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description', hintText: 'Details regarding scope'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<SpecialPricingType>(
              value: _type,
              decoration: const InputDecoration(labelText: 'Pricing Model'),
              items: SpecialPricingType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.displayName)))
                  .toList(),
              onChanged: (val) => setState(() => _type = val ?? SpecialPricingType.flatPrice),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _rateController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Unit Rate (\$)'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _qtyController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Quantity'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text('Monthly Recurring', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              value: _isRecurring,
              onChanged: (v) => setState(() => _isRecurring = v ?? false),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.trim().isNotEmpty) {
              final service = SpecialService(
                id: IdGenerator.generateId('spec'),
                serviceName: _nameController.text.trim(),
                description: _descController.text.trim(),
                pricingType: _type,
                unitRate: double.tryParse(_rateController.text) ?? 0,
                quantity: double.tryParse(_qtyController.text) ?? 1,
                isRecurringMonthly: _isRecurring,
              );
              widget.controller.addSpecialService(service);
              Navigator.pop(context);
            }
          },
          child: const Text('Add Service'),
        ),
      ],
    );
  }
}
