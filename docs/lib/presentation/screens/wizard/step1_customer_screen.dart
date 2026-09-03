import 'package:flutter/material.dart';
import '../../widgets/common_text_field.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../../core/validation/input_validators.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../../domain/entities/customer.dart';

/// Step 1: Customer Data Intake (or selection from existing accounts).
class Step1CustomerScreen extends StatefulWidget {
  final EstimateWizardController controller;
  final CustomerRepository customerRepository;

  const Step1CustomerScreen({
    super.key,
    required this.controller,
    required this.customerRepository,
  });

  @override
  State<Step1CustomerScreen> createState() => _Step1CustomerScreenState();
}

class _Step1CustomerScreenState extends State<Step1CustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _companyController;
  late TextEditingController _contactController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _serviceAddressController;
  late TextEditingController _billingAddressController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final ctrl = widget.controller;
    _companyController = TextEditingController(text: ctrl.companyName);
    _contactController = TextEditingController(text: ctrl.contactName);
    _phoneController = TextEditingController(text: ctrl.phone);
    _emailController = TextEditingController(text: ctrl.email);
    _serviceAddressController = TextEditingController(text: ctrl.serviceAddress);
    _billingAddressController = TextEditingController(text: ctrl.billingAddress);
    _notesController = TextEditingController(text: ctrl.customerNotes);
  }

  @override
  void dispose() {
    _companyController.dispose();
    _contactController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _serviceAddressController.dispose();
    _billingAddressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _syncToController() {
    widget.controller.updateCustomerData(
      company: _companyController.text,
      contact: _contactController.text,
      phoneNum: _phoneController.text,
      emailAddr: _emailController.text,
      servAddress: _serviceAddressController.text,
      billAddress: _billingAddressController.text,
      notes: _notesController.text,
    );
  }

  void _selectExistingCustomer(Customer customer) {
    setState(() {
      _companyController.text = customer.companyName;
      _contactController.text = customer.contactName;
      _phoneController.text = customer.phone;
      _emailController.text = customer.email;
      _serviceAddressController.text = customer.serviceAddress;
      _billingAddressController.text = customer.billingAddress;
      _notesController.text = customer.notes;
    });
    _syncToController();
  }

  @override
  Widget build(BuildContext context) {
    final List<Customer> existingCustomers = widget.customerRepository.getAllCustomers();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (existingCustomers.isNotEmpty) ...[
              Card(
                color: const Color(0xFFF0F7FF),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.quickreply, color: Color(0xFF0F2E4A)),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Select an existing customer to auto-fill details:',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                      PopupMenuButton<Customer>(
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Color(0xFF00B4D8)),
                        tooltip: 'Choose Existing Customer',
                        onSelected: _selectExistingCustomer,
                        itemBuilder: (context) => existingCustomers
                            .map((c) => PopupMenuItem(
                                  value: c,
                                  child: Text('${c.companyName} (${c.contactName})'),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            CommonTextField(
              label: 'Company Name *',
              hint: 'e.g. Acme Innovations Corp',
              controller: _companyController,
              prefixIcon: Icons.business,
              validator: (v) => InputValidators.validateRequired(v, 'Company name'),
              onChanged: (_) => _syncToController(),
            ),

            CommonTextField(
              label: 'Contact Person Name *',
              hint: 'e.g. Jane Doe (Facilities Director)',
              controller: _contactController,
              prefixIcon: Icons.person_outline,
              validator: (v) => InputValidators.validateRequired(v, 'Contact name'),
              onChanged: (_) => _syncToController(),
            ),

            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    label: 'Phone Number',
                    hint: '(555) 000-0000',
                    controller: _phoneController,
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: InputValidators.validatePhone,
                    onChanged: (_) => _syncToController(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CommonTextField(
                    label: 'Email Address',
                    hint: 'contact@company.com',
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: InputValidators.validateEmail,
                    onChanged: (_) => _syncToController(),
                  ),
                ),
              ],
            ),

            CommonTextField(
              label: 'Service Address *',
              hint: 'e.g. 500 Technology Way, Suite 200, Metro City',
              controller: _serviceAddressController,
              prefixIcon: Icons.location_on_outlined,
              validator: (v) => InputValidators.validateRequired(v, 'Service address'),
              onChanged: (_) => _syncToController(),
            ),

            CommonTextField(
              label: 'Billing Address (if different)',
              hint: 'Leave blank if same as service address',
              controller: _billingAddressController,
              prefixIcon: Icons.receipt_long_outlined,
              onChanged: (_) => _syncToController(),
            ),

            CommonTextField(
              label: 'Walkthrough Notes / Client Special Requests',
              hint: 'Special instructions, access constraints, alarm codes, sensitive zones...',
              controller: _notesController,
              prefixIcon: Icons.note_alt_outlined,
              maxLines: 3,
              onChanged: (_) => _syncToController(),
            ),

            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _syncToController();
                  widget.controller.nextStep();
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Proceed to Site Walkthrough'),
            ),
          ],
        ),
      ),
    );
  }
}
