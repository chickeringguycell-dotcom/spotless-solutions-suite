import 'package:flutter/material.dart';
import '../../widgets/step_progress_bar.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../state/quotes_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/customer_repository.dart';
import 'step1_customer_screen.dart';
import 'step2_site_walkthrough.dart';
import 'step3_frequency_role.dart';
import 'step4_special_services.dart';
import 'step5_labor_cost_review.dart';
import 'step6_quote_summary.dart';

/// Wizard Host Container coordinating navigation across the 6 estimation steps.
class EstimateWizardHostScreen extends StatefulWidget {
  final EstimateWizardController controller;
  final QuotesController quotesController;
  final CustomerRepository customerRepository;

  const EstimateWizardHostScreen({
    super.key,
    required this.controller,
    required this.quotesController,
    required this.customerRepository,
  });

  @override
  State<EstimateWizardHostScreen> createState() => _EstimateWizardHostScreenState();
}

class _EstimateWizardHostScreenState extends State<EstimateWizardHostScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChange);
    super.dispose();
  }

  void _onControllerChange() {
    if (mounted) setState(() {});
  }

  Widget _buildCurrentStepWidget() {
    switch (widget.controller.currentStep) {
      case 0:
        return Step1CustomerScreen(
          controller: widget.controller,
          customerRepository: widget.customerRepository,
        );
      case 1:
        return Step2SiteWalkthroughScreen(controller: widget.controller);
      case 2:
        return Step3FrequencyRoleScreen(controller: widget.controller);
      case 3:
        return Step4SpecialServicesScreen(controller: widget.controller);
      case 4:
        return Step5LaborCostReviewScreen(controller: widget.controller);
      case 5:
        return Step6QuoteSummaryScreen(
          controller: widget.controller,
          quotesController: widget.quotesController,
          onQuoteSaved: () {
            Navigator.pop(context);
          },
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Commercial Estimate Wizard', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            Text(
              'Ref: ${ctrl.quoteNumber} | ${ctrl.companyName.isEmpty ? 'New Account' : ctrl.companyName}',
              style: const TextStyle(fontSize: 12, color: AppColors.accentLight),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Exit Estimate',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Exit Walkthrough?'),
                  content: const Text('Any unsaved walkthrough entries will be discarded.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Stay')),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            StepProgressBar(
              currentStep: ctrl.currentStep,
              onStepTapped: (step) => ctrl.setStep(step),
            ),
            Expanded(
              child: _buildCurrentStepWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
