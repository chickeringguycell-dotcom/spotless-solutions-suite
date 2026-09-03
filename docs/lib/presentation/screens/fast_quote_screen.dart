import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../domain/entities/cleaning_difficulty.dart';
import '../../domain/entities/quick_quote_input.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/customer.dart';
import '../../domain/services/quote_engine.dart';
import '../state/settings_controller.dart';
import '../state/quotes_controller.dart';
import '../state/estimate_wizard_controller.dart';
import '../widgets/touch_stepper.dart';
import '../widgets/margin_badge.dart';
import '../widgets/quote_safety_banner.dart';
import 'wizard/estimate_wizard_host_screen.dart';
import 'quote_detail_screen.dart';

/// Primary Fast 6-Input Quoting Screen for Spotless Solutions estimators.
/// Enables on-site representatives to produce a commercial estimate in seconds.
class FastQuoteScreen extends StatefulWidget {
  final SettingsController settingsController;
  final QuotesController quotesController;
  final EstimateWizardController? wizardController;

  const FastQuoteScreen({
    super.key,
    required this.settingsController,
    required this.quotesController,
    this.wizardController,
  });

  @override
  State<FastQuoteScreen> createState() => _FastQuoteScreenState();
}

class _FastQuoteScreenState extends State<FastQuoteScreen> {
  final _formKey = GlobalKey<FormState>();

  // 6 Primary Inputs State
  late TextEditingController _sqFtController;
  late TextEditingController _companyNameController;
  int _restrooms = 2;
  int _kitchens = 1;
  int _occupants = 25;
  int _cleaningsPerWeek = 5;
  CleaningDifficulty _difficulty = CleaningDifficulty.normal;

  bool _hasCalculated = true; // Auto-calculate on start

  @override
  void initState() {
    super.initState();
    _sqFtController = TextEditingController(text: '8500');
    _companyNameController = TextEditingController(text: 'Commercial Client');
    _restrooms = 4;
    _kitchens = 2;
    _occupants = 65;
    _cleaningsPerWeek = 3;
    _difficulty = CleaningDifficulty.normal;
  }

  @override
  void dispose() {
    _sqFtController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  double get _currentSqFt {
    return double.tryParse(_sqFtController.text.replaceAll(',', '').trim()) ?? 0.0;
  }

  QuickQuoteInput get _currentInput {
    return QuickQuoteInput(
      totalSquareFeet: _currentSqFt,
      restroomsCount: _restrooms,
      kitchensCount: _kitchens,
      occupantsCount: _occupants,
      cleaningsPerWeek: _cleaningsPerWeek,
      difficulty: _difficulty,
    );
  }

  /// Evaluates the complete underlying pricing engine automatically
  Quote _generateCurrentQuote() {
    final settings = widget.settingsController.settings;
    final input = _currentInput;
    final site = input.toSiteData();
    final freq = input.toServiceFrequency();
    final role = settings.defaultRole;

    final summary = QuoteEngine.calculateQuoteSummary(
      site: site,
      frequency: freq,
      role: role,
      settings: settings,
    );

    final customer = Customer(
      id: 'quick-cust',
      companyName: _companyNameController.text.trim().isEmpty
          ? 'Commercial Office Client'
          : _companyNameController.text.trim(),
      contactName: 'Site Facility Manager',
      phone: '',
      email: '',
      serviceAddress: 'Client Commercial Facility',
      billingAddress: 'Client Commercial Facility',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return Quote(
      id: 'quote-${DateTime.now().millisecondsSinceEpoch}',
      quoteNumber: 'SS-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      customer: customer,
      siteData: site,
      frequency: freq,
      assignedRole: role,
      summary: summary,
      status: QuoteStatus.draft,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      expirationDate: DateTime.now().add(const Duration(days: 30)),
      estimatedMinutes: summary.laborBreakdown.finalTotalMinutes,
      estimatedCost: summary.costBreakdown.trueJobCostPerVisit,
      estimatedMargin: summary.pricingResult.grossMarginPercentage,
    );
  }

  void _openAdvancedMode() {
    final quote = _generateCurrentQuote();
    final wizard = widget.wizardController ?? EstimateWizardController(widget.settingsController.settings);
    wizard.loadExistingQuote(quote);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EstimateWizardHostScreen(
          settingsController: widget.settingsController,
          quotesController: widget.quotesController,
          existingWizardController: wizard,
        ),
      ),
    );
  }

  void _openProposalView(Quote quote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => QuoteDetailScreen(
          quote: quote,
          quotesController: widget.quotesController,
        ),
      ),
    );
  }

  void _saveQuote() {
    final quote = _generateCurrentQuote();
    widget.quotesController.saveQuote(quote);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quote ${quote.quoteNumber} successfully saved to Saved Quotes!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quote = _generateCurrentQuote();
    final summary = quote.summary;
    final pricing = summary.pricingResult;
    final cost = summary.costBreakdown;
    final labor = summary.laborBreakdown;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotless Office Solutions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Advanced Adjustments',
            onPressed: _openAdvancedMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Name Quick Field
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(
                  labelText: 'Company / Account Name',
                  hintText: 'e.g. Apex Technology Partners',
                  prefixIcon: Icon(Icons.business),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 14),

              // Title / Tagline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SIX PRIMARY QUOTE INPUTS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                    icon: const Icon(Icons.tune, size: 16),
                    label: const Text('Advanced Mode', style: TextStyle(fontSize: 12)),
                    onPressed: _openAdvancedMode,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // INPUT 1: Total Office Square Footage
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1. Total Office Square Footage *',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _sqFtController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary),
                        decoration: const InputDecoration(
                          hintText: 'e.g. 8,500',
                          suffixText: 'sq ft',
                          prefixIcon: Icon(Icons.square_foot, color: AppColors.primary),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // INPUT 2 & 3: Restrooms and Kitchens
              Row(
                children: [
                  Expanded(
                    child: TouchStepper(
                      label: '2. Restrooms',
                      subtitle: 'Total restrooms',
                      value: _restrooms,
                      icon: Icons.wc,
                      onChanged: (v) => setState(() => _restrooms = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TouchStepper(
                      label: '3. Breakrooms',
                      subtitle: 'Kitchens / breakrooms',
                      value: _kitchens,
                      icon: Icons.coffee,
                      onChanged: (v) => setState(() => _kitchens = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // INPUT 4: Building Occupancy / Employees
              TouchStepper(
                label: '4. Employees / Occupants',
                subtitle: 'Normal daily building occupancy',
                value: _occupants,
                icon: Icons.people_outline,
                onChanged: (v) => setState(() => _occupants = v),
              ),
              const SizedBox(height: 8),

              // INPUT 5: Cleanings Per Week (1 to 7)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '5. Cleanings Per Week',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          Text(
                            '${CurrencyFormatter.formatDecimal(quote.frequency.visitsPerMonth)} visits / mo',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [1, 2, 3, 4, 5, 6, 7].map((numVisits) {
                          final bool isSelected = _cleaningsPerWeek == numVisits;
                          return InkWell(
                            onTap: () => setState(() => _cleaningsPerWeek = numVisits),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : AppColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.border,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Text(
                                '${numVisits}x',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // INPUT 6: Cleaning Difficulty / Condition (Light, Normal, Heavy)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '6. Cleaning Difficulty / Condition',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: CleaningDifficulty.values.map((diff) {
                          final bool isSelected = _difficulty == diff;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: InkWell(
                                onTap: () => setState(() => _difficulty = diff),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary : AppColors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.border,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      diff.iconLabel,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: isSelected ? Colors.white : AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // CALCULATE BUTTON
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  setState(() => _hasCalculated = true);
                },
                icon: const Icon(Icons.calculate_outlined),
                label: const Text('CALCULATE QUOTE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
              ),

              const SizedBox(height: 16),
              // Safety Warning Banner
              QuoteSafetyBanner(warnings: summary.safetyWarnings),

              const SizedBox(height: 12),
              // ==========================================
              // INSTANT RESULTS BOX
              // ==========================================
              Card(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.accent, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Profitability Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'RECOMMENDED PRICING',
                            style: TextStyle(color: AppColors.accentLight, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                          ),
                          MarginBadge(
                            status: pricing.profitabilityStatus,
                            marginPercentage: pricing.grossMarginPercentage,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Recommended Monthly Price (Hero)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            CurrencyFormatter.formatCurrency(pricing.monthlyContractPrice),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '/ month',
                            style: TextStyle(fontSize: 14, color: AppColors.accentLight, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Price Per Visit
                      Text(
                        '${CurrencyFormatter.formatCurrency(pricing.finalPricePerVisit)} per cleaning visit (${quote.frequency.label})',
                        style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const Divider(color: Colors.white24, height: 20),

                      // Metric Grid
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Labor / Visit', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  CurrencyFormatter.formatHours(labor.totalEstimatedHoursPerVisit),
                                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Monthly Labor', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  CurrencyFormatter.formatHours(pricing.monthlyLaborHours),
                                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Monthly Profit', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  CurrencyFormatter.formatCurrency(pricing.monthlyGrossProfit),
                                  style: const TextStyle(color: AppColors.accentLight, fontSize: 14, fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cost / Visit', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  CurrencyFormatter.formatCurrency(cost.trueJobCostPerVisit),
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Monthly Cost', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  CurrencyFormatter.formatCurrency(pricing.monthlyTrueCost),
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gross Margin', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  CurrencyFormatter.formatPercent(pricing.grossMarginPercentage),
                                  style: const TextStyle(color: AppColors.accentLight, fontSize: 14, fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _openProposalView(quote),
                      icon: const Icon(Icons.description_outlined),
                      label: const Text('Proposal View'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      onPressed: _saveQuote,
                      icon: const Icon(Icons.save),
                      label: const Text('Save Quote'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Center(
                child: TextButton.icon(
                  onPressed: _openAdvancedMode,
                  icon: const Icon(Icons.tune),
                  label: const Text('Open in Full Walkthrough Mode'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
