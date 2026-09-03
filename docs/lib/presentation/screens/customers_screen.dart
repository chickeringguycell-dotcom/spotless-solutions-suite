import 'package:flutter/material.dart';
import '../../data/repositories/customer_repository.dart';
import '../../domain/entities/customer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/id_generator.dart';
import '../state/estimate_wizard_controller.dart';
import '../state/quotes_controller.dart';
import 'wizard/estimate_wizard_host_screen.dart';

/// Customer Directory & Active Account Management Screen.
class CustomersScreen extends StatefulWidget {
  final CustomerRepository customerRepository;
  final EstimateWizardController wizardController;
  final QuotesController quotesController;

  const CustomersScreen({
    super.key,
    required this.customerRepository,
    required this.wizardController,
    required this.quotesController,
  });

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  void _showAddCustomerDialog() {
    final companyCtrl = TextEditingController();
    final contactCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Commercial Account', style: TextStyle(fontWeight: FontWeight.w800)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: companyCtrl, decoration: const InputDecoration(labelText: 'Company Name *')),
              const SizedBox(height: 8),
              TextField(controller: contactCtrl, decoration: const InputDecoration(labelText: 'Contact Person *')),
              const SizedBox(height: 8),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number')),
              const SizedBox(height: 8),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email Address')),
              const SizedBox(height: 8),
              TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Service Address *')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (companyCtrl.text.trim().isNotEmpty) {
                final customer = Customer(
                  id: IdGenerator.generateId('cust'),
                  companyName: companyCtrl.text.trim(),
                  contactName: contactCtrl.text.trim(),
                  phone: phoneCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                  serviceAddress: addressCtrl.text.trim(),
                  billingAddress: addressCtrl.text.trim(),
                  isActiveAccount: false,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                widget.customerRepository.saveCustomer(customer);
                setState(() {});
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Customer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Customer> allCustomers = widget.customerRepository.getAllCustomers();
    final String query = _searchCtrl.text.toLowerCase().trim();
    final filtered = query.isEmpty
        ? allCustomers
        : allCustomers
            .where((c) =>
                c.companyName.toLowerCase().contains(query) ||
                c.contactName.toLowerCase().contains(query) ||
                c.serviceAddress.toLowerCase().contains(query))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Commercial Accounts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1),
            onPressed: _showAddCustomerDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(
                hintText: 'Search companies or contacts...',
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No customer records found.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, idx) {
                      final cust = filtered[idx];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cust.companyName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  if (cust.isActiveAccount)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD1FAE5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'ACTIVE CLIENT',
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.success),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text('Contact: ${cust.contactName} • ${cust.phone}',
                                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                              Text('Address: ${cust.serviceAddress}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.note_add_outlined, size: 16),
                                    label: const Text('Start Walkthrough Estimate', style: TextStyle(fontSize: 12)),
                                    onPressed: () {
                                      widget.wizardController.startNewEstimate();
                                      widget.wizardController.updateCustomerData(
                                        company: cust.companyName,
                                        contact: cust.contactName,
                                        phoneNum: cust.phone,
                                        emailAddr: cust.email,
                                        servAddress: cust.serviceAddress,
                                        billAddress: cust.billingAddress,
                                        notes: cust.notes,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EstimateWizardHostScreen(
                                            controller: widget.wizardController,
                                            quotesController: widget.quotesController,
                                            customerRepository: widget.customerRepository,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
