import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/margin_badge.dart';
import '../../widgets/quote_safety_banner.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../state/quotes_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/quote.dart';

/// Step 6: Pricing Engine Recommendation, Margin Analysis, and Quote Finalization.
class Step6QuoteSummaryScreen extends StatefulWidget {
  final EstimateWizardController controller;
  final QuotesController quotesController;
  final VoidCallback onQuoteSaved;

  const Step6QuoteSummaryScreen({
    super.key,
    required this.controller,
    required this.quotesController,
    required this.onQuoteSaved,
  });

  @override
  State<Step6QuoteSummaryScreen> createState() => _Step6QuoteSummaryScreenState();
}

class _Step6QuoteSummaryScreenState extends State<Step6QuoteSummaryScreen> {
  late TextEditingController _overrideController;
  late TextEditingController _internalNotesController;
  late TextEditingController _customerNotesController;
  bool _isCustomerFacingPreview = false;

  @override
  void initState() {
    super.initState();
    final ctrl = widget.controller;
    _overrideController = TextEditingController(
      text: ctrl.ownerOverridePricePerVisit != null
          ? ctrl.ownerOverridePricePerVisit!.toStringAsFixed(2)
          : '',
    );
    _internalNotesController = TextEditingController(text: ctrl.internalNotes);
    _customerNotesController = TextEditingController(text: ctrl.customerFacingNotes);
  }

  @override
  void dispose() {
    _overrideController.dispose();
    _internalNotesController.dispose();
    _customerNotesController.dispose();
    super.dispose();
  }

  void _saveQuote({bool markAsSent = false}) {
    widget.controller.internalNotes = _internalNotesController.text;
    widget.controller.customerFacingNotes = _customerNotesController.text;

    final Quote quote = widget.controller.buildQuote(
      status: markAsSent ? QuoteStatus.sent : QuoteStatus.draft,
    );

    widget.quotesController.saveQuote(quote);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          markAsSent
              ? 'Quote ${quote.quoteNumber} saved and marked as SENT!'
              : 'Quote ${quote.quoteNumber} saved as DRAFT!',
        ),
        backgroundColor: AppColors.success,
      ),
    );
    widget.onQuoteSaved();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;
    final summary = ctrl.currentSummary;
    final pricing = summary.pricingResult;
    final cost = summary.costBreakdown;
    final labor = summary.laborBreakdown;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Safety Check Banner
          QuoteSafetyBanner(warnings: summary.safetyWarnings),
          const SizedBox(height: 10),

          // Mode Toggle (Internal Estimator vs Customer Facing Preview)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Owner Audit View'),
                    selected: !_isCustomerFacingPreview,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: !_isCustomerFacingPreview ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    onSelected: (val) => setState(() => _isCustomerFacingPreview = !val),
                  ),
                ),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Customer Proposal View'),
                    selected: _isCustomerFacingPreview,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _isCustomerFacingPreview ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    onSelected: (val) => setState(() => _isCustomerFacingPreview = val),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (_isCustomerFacingPreview) ...[
            _buildCustomerFacingView(summary, ctrl)
          ] else ...[
            _buildInternalEstimatingView(summary, pricing, cost, labor, ctrl),
          ],

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _saveQuote(markAsSent: false),
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save Draft'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: () => _saveQuote(markAsSent: true),
                  icon: const Icon(Icons.send),
                  label: const Text('Save & Mark Sent'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton.icon(
              onPressed: () => ctrl.previousStep(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Cost Review'),
            ),
          ),
        ],
      ),
    );
  }

  /// Internal View with 3 Reference Prices, Financial Rollups & Profitability Audits
  Widget _buildInternalEstimatingView(
    dynamic summary,
    dynamic pricing,
    dynamic cost,
    dynamic labor,
    EstimateWizardController ctrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profitability Status Pill
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'PROFITABILITY AUDIT',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textSecondary),
            ),
            MarginBadge(
              status: pricing.profitabilityStatus,
              marginPercentage: pricing.grossMarginPercentage,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Recommended Price Card
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pricing.isOwnerOverridden ? 'OWNER OVERRIDE PRICE / VISIT' : 'RECOMMENDED PRICE / VISIT',
                      style: const TextStyle(
                        color: AppColors.accentLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        pricing.recommendedMethodName,
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  CurrencyFormatter.formatCurrency(pricing.finalPricePerVisit),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'True Cost: ${CurrencyFormatter.formatCurrency(cost.trueJobCostPerVisit)}',
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                    ),
                    Text(
                      'Profit: ${CurrencyFormatter.formatCurrency(pricing.grossProfitPerVisit)} / visit (${CurrencyFormatter.formatPercent(pricing.grossMarginPercentage)})',
                      style: const TextStyle(color: AppColors.accentLight, fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),
        _buildSectionHeader('Three Internal Reference Prices'),
        const SizedBox(height: 8),

        // Three Reference Prices Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildComparisonRow(
                  'Reference A: Target Billing Rate',
                  '${CurrencyFormatter.formatHours(labor.totalEstimatedHoursPerVisit)} @ \$${ctrl.settings.targetBillingRate.toStringAsFixed(0)}/hr',
                  CurrencyFormatter.formatCurrency(pricing.referencePriceA),
                  pricing.referencePriceA >= pricing.referencePriceB && pricing.referencePriceA >= pricing.referencePriceC,
                ),
                const Divider(height: 16),
                _buildComparisonRow(
                  'Reference B: Target Gross Margin',
                  '${CurrencyFormatter.formatCurrency(cost.trueJobCostPerVisit)} / (1 - ${(ctrl.settings.targetGrossMargin * 100).toStringAsFixed(0)}%)',
                  CurrencyFormatter.formatCurrency(pricing.referencePriceB),
                  pricing.referencePriceB > pricing.referencePriceA && pricing.referencePriceB >= pricing.referencePriceC,
                ),
                const Divider(height: 16),
                _buildComparisonRow(
                  'Reference C: Minimum Service Charge',
                  'Configured business floor per visit',
                  CurrencyFormatter.formatCurrency(pricing.referencePriceC),
                  pricing.referencePriceC > pricing.referencePriceA && pricing.referencePriceC > pricing.referencePriceB,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),
        _buildSectionHeader('Owner Override Price (Optional)'),
        const Text(
          'Inputting an override replaces the recommendation while recording the event and checking for safety.',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 6),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _overrideController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Override Price Per Visit (\$)',
                  hintText: 'e.g. 175.00',
                  prefixText: '\$ ',
                ),
                onChanged: (val) {
                  final double? price = double.tryParse(val.trim());
                  setState(() {
                    ctrl.setOwnerOverridePrice(price);
                  });
                },
              ),
            ),
            if (ctrl.ownerOverridePricePerVisit != null) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.clear, color: AppColors.textMuted),
                tooltip: 'Reset to Recommended',
                onPressed: () {
                  setState(() {
                    _overrideController.clear();
                    ctrl.setOwnerOverridePrice(null);
                  });
                },
              ),
            ],
          ],
        ),

        const SizedBox(height: 16),
        _buildSectionHeader('Recurring Monthly & Annual Financial Projections'),
        const SizedBox(height: 8),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildProjectionRow('Estimated Monthly Cleaning Visits', '${CurrencyFormatter.formatDecimal(pricing.averageMonthlyVisits)} visits / mo'),
                _buildProjectionRow('Estimated Monthly Labor Hours', CurrencyFormatter.formatHours(pricing.monthlyLaborHours)),
                _buildProjectionRow('Estimated Monthly Direct Cleaner Wages', CurrencyFormatter.formatCurrency(pricing.monthlyDirectWages)),
                _buildProjectionRow('Estimated Monthly True Company Cost', CurrencyFormatter.formatCurrency(pricing.monthlyTrueCost)),
                _buildProjectionRow('Estimated Monthly Gross Profit', CurrencyFormatter.formatCurrency(pricing.monthlyGrossProfit), isBold: true),
                const Divider(height: 16),
                _buildProjectionRow('Monthly Contract Revenue', CurrencyFormatter.formatCurrency(pricing.monthlyContractPrice), isBold: true, highlight: true),
                _buildProjectionRow('Annual Contract Revenue (12 Mos)', CurrencyFormatter.formatCurrency(pricing.annualRevenue)),
                _buildProjectionRow('Annual Estimated Gross Profit', CurrencyFormatter.formatCurrency(pricing.annualEstimatedGrossProfit), isBold: true),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
        TextField(
          controller: _internalNotesController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Internal Estimating Notes (Owner Only)',
            hintText: 'Staffing plan, access instructions, price concession reasons...',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _customerNotesController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Customer Facing Quote Scope / Special Notes',
            hintText: 'Service guarantees, customer specifics, included tasks...',
          ),
        ),
      ],
    );
  }

  /// Sanitized Customer Facing View (Hides cost, wages, and margins!)
  Widget _buildCustomerFacingView(dynamic summary, EstimateWizardController ctrl) {
    final quote = ctrl.buildQuote();
    final dateFormat = DateFormat('MMMM d, yyyy');

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.accent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ctrl.settings.companyName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primary),
                    ),
                    Text(
                      ctrl.settings.companyPhone,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    quote.quoteNumber,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Prepared For & Expiration Date
            Text(
              'PROPOSAL FOR: ${quote.customer.companyName.toUpperCase()}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary),
            ),
            const SizedBox(height: 4),
            Text('Contact: ${quote.customer.contactName} | Phone: ${quote.customer.phone}',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            Text('Service Location: ${quote.customer.serviceAddress}',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            Text('Quote Valid Through: ${dateFormat.format(quote.expirationDate)} (30 Days)',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),

            const SizedBox(height: 16),
            const Text('SCOPE OF RECURRING COMMERCIAL CLEANING',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
            const SizedBox(height: 6),
            Text(
              '• Service Frequency: ${quote.frequency.label} (${CurrencyFormatter.formatDecimal(quote.frequency.visitsPerMonth)} visits/month)\n'
              '• Total Cleanable Facility Area: ${CurrencyFormatter.formatSqFt(quote.siteData.totalSquareFeet)}\n'
              '• Workstations & Offices: ${quote.siteData.workstationsCount} | Restrooms: ${quote.siteData.bathroomsCount} (Toilets: ${quote.siteData.toiletsCount}, Urinals: ${quote.siteData.urinalsCount}, Sinks: ${quote.siteData.sinksCount}, Showers: ${quote.siteData.showersCount})\n'
              '• Kitchens & Breakrooms: ${quote.siteData.standardBreakroomsCount} Standard Breakrooms, ${quote.siteData.largeKitchensCount} Full Kitchens | Conference Rooms: ${quote.siteData.conferenceRoomsCount}\n'
              '• Comprehensive surface sanitization, trash collection, vacuuming, mopping & high-touch point disinfection.',
              style: const TextStyle(fontSize: 12, height: 1.5, color: AppColors.textPrimary),
            ),

            if (quote.specialServices.isNotEmpty) ...[
              const SizedBox(height: 14),
              const Text('ITEMIZED SPECIALTY SERVICES',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
              const SizedBox(height: 6),
              ...quote.specialServices.map((s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('• ${s.serviceName} (${s.isRecurringMonthly ? 'Monthly' : 'One-Time'})',
                            style: const TextStyle(fontSize: 12)),
                        Text(CurrencyFormatter.formatCurrency(s.totalPrice),
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  )),
            ],

            const Divider(height: 24),
            // Investment Pricing Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.success.withOpacity(0.4)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price Per Cleaning Visit:',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text(CurrencyFormatter.formatCurrency(quote.summary.pricingResult.finalPricePerVisit),
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Monthly Contract Investment:',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      Text(CurrencyFormatter.formatCurrency(quote.summary.totalMonthlyInvoice),
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppColors.success)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Annual Contract Value (12 Months):',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textSecondary)),
                      Text(CurrencyFormatter.formatCurrency(quote.summary.totalAnnualContractValue),
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text('TERMS & ACCEPTANCE',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
            const SizedBox(height: 6),
            const Text(
              '1. Invoices billed monthly on Net 30 terms.\n'
              '2. All cleaning equipment, EPA-registered disinfectants & commercial supplies provided by Spotless Solutions.\n'
              '3. 30-day cancellation clause for cause by either party with written notice.',
              style: TextStyle(fontSize: 11, height: 1.4, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Authorized Client Signature: _______________________', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        SizedBox(height: 8),
                        Text('Printed Name & Date: _________________________________', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String title, String subtitle, String price, bool isHigher) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                if (isHigher) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'RECOMMENDED',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                  ),
                ],
              ],
            ),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: isHigher ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectionRow(String label, String value, {bool isBold = false, bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: isBold ? FontWeight.w700 : FontWeight.w400)),
          Text(value,
              style: TextStyle(
                fontSize: 13,
                color: highlight ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
              )),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: -0.2,
      ),
    );
  }
}
