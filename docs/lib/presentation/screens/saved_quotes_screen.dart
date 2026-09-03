import 'package:flutter/material.dart';
import '../widgets/margin_badge.dart';
import '../state/quotes_controller.dart';
import '../state/settings_controller.dart';
import '../state/estimate_wizard_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../domain/entities/quote.dart';
import 'quote_detail_screen.dart';
import 'wizard/estimate_wizard_host_screen.dart';
import '../../data/repositories/customer_repository.dart';

/// Screen listing saved quotes with lifecycle actions and status filtering.
class SavedQuotesScreen extends StatefulWidget {
  final QuotesController quotesController;
  final SettingsController? settingsController;
  final EstimateWizardController? wizardController;
  final CustomerRepository? customerRepository;

  const SavedQuotesScreen({
    super.key,
    required this.quotesController,
    this.settingsController,
    this.wizardController,
    this.customerRepository,
  });

  @override
  State<SavedQuotesScreen> createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.quotesController.addListener(_onUpdate);
  }

  @override
  void dispose() {
    _searchController.dispose();
    widget.quotesController.removeListener(_onUpdate);
    super.dispose();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  Color _getStatusColor(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.draft:
        return AppColors.textSecondary;
      case QuoteStatus.sent:
        return AppColors.info;
      case QuoteStatus.accepted:
        return AppColors.success;
      case QuoteStatus.rejected:
        return AppColors.error;
      case QuoteStatus.convertedToCustomer:
        return AppColors.primary;
    }
  }

  void _showQuoteActionSheet(Quote quote) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  children: [
                    Text(
                      'Actions: ${quote.quoteNumber}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // View Details
              ListTile(
                leading: const Icon(Icons.visibility_outlined, color: AppColors.primary),
                title: const Text('View Full Proposal & Details', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuoteDetailScreen(
                        quote: quote,
                        quotesController: widget.quotesController,
                      ),
                    ),
                  );
                },
              ),

              // Edit / Resume Walkthrough
              ListTile(
                leading: const Icon(Icons.edit_note_outlined, color: AppColors.primary),
                title: const Text('Edit / Adjust Walkthrough', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  if (widget.settingsController != null) {
                    final wizard = widget.wizardController ?? EstimateWizardController(widget.settingsController!.settings);
                    wizard.loadExistingQuote(quote);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EstimateWizardHostScreen(
                          settingsController: widget.settingsController!,
                          quotesController: widget.quotesController,
                          existingWizardController: wizard,
                        ),
                      ),
                    );
                  }
                },
              ),

              // Duplicate Quote
              ListTile(
                leading: const Icon(Icons.copy_all_outlined, color: AppColors.accent),
                title: const Text('Duplicate into New Draft', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  final duplicate = widget.quotesController.duplicateQuote(quote.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Duplicated as new draft ${duplicate.quoteNumber}')),
                  );
                },
              ),

              // Mark as Sent
              if (quote.status == QuoteStatus.draft)
                ListTile(
                  leading: const Icon(Icons.send_outlined, color: AppColors.info),
                  title: const Text('Mark as Sent to Client', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.quotesController.markAsSent(quote.id);
                  },
                ),

              // Mark as Accepted
              if (quote.status == QuoteStatus.sent || quote.status == QuoteStatus.draft)
                ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: AppColors.success),
                  title: const Text('Mark as Accepted by Client', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.quotesController.markAsAccepted(quote.id);
                  },
                ),

              // Convert to Active Customer
              if (quote.status == QuoteStatus.accepted)
                ListTile(
                  leading: const Icon(Icons.verified_user_outlined, color: AppColors.success),
                  title: const Text('Convert to Active Customer Account', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.success)),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.quotesController.convertToActiveCustomer(quote.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account activated! Added to Active Customer Portfolio.')),
                    );
                  },
                ),

              // Mark as Rejected
              if (quote.status != QuoteStatus.rejected)
                ListTile(
                  leading: const Icon(Icons.cancel_outlined, color: AppColors.error),
                  title: const Text('Mark as Rejected', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.error)),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.quotesController.markAsRejected(quote.id);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quotesCtrl = widget.quotesController;
    final List<Quote> quotes = quotesCtrl.quotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Estimates & Proposals'),
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by client, contact, quote #...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              quotesCtrl.setSearchQuery('');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (v) => quotesCtrl.setSearchQuery(v),
                ),
                const SizedBox(height: 10),

                // Status Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All (${quotesCtrl.totalQuotesCount})', null, quotesCtrl.statusFilter == null),
                      const SizedBox(width: 6),
                      _buildFilterChip('Draft (${quotesCtrl.draftCount})', QuoteStatus.draft, quotesCtrl.statusFilter == QuoteStatus.draft),
                      const SizedBox(width: 6),
                      _buildFilterChip('Sent (${quotesCtrl.sentCount})', QuoteStatus.sent, quotesCtrl.statusFilter == QuoteStatus.sent),
                      const SizedBox(width: 6),
                      _buildFilterChip('Accepted (${quotesCtrl.acceptedCount})', QuoteStatus.accepted, quotesCtrl.statusFilter == QuoteStatus.accepted),
                      const SizedBox(width: 6),
                      _buildFilterChip('Rejected', QuoteStatus.rejected, quotesCtrl.statusFilter == QuoteStatus.rejected),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: quotes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 54, color: AppColors.primary.withOpacity(0.3)),
                        const SizedBox(height: 12),
                        const Text(
                          'No quotes match your filter',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 6),
                        const Text('Create a new walkthrough estimate to get started.',
                            style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: quotes.length,
                    itemBuilder: (ctx, index) {
                      final quote = quotes[index];
                      final statusColor = _getStatusColor(quote.status);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: InkWell(
                          onTap: () => _showQuoteActionSheet(quote),
                          borderRadius: BorderRadius.circular(14),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceElevated,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        quote.quoteNumber,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: statusColor.withOpacity(0.3)),
                                      ),
                                      child: Text(
                                        quote.status.displayName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 11,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  quote.customer.companyName,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${quote.customer.contactName} • ${quote.customer.serviceAddress}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${CurrencyFormatter.formatSqFt(quote.siteData.totalSquareFeet)} • ${quote.frequency.label}',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${CurrencyFormatter.formatCurrency(quote.summary.pricingResult.finalPricePerVisit)} / visit',
                                          style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${CurrencyFormatter.formatCurrency(quote.summary.totalMonthlyInvoice)}/mo',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        MarginBadge(
                                          status: quote.summary.pricingResult.profitabilityStatus,
                                          marginPercentage: quote.summary.pricingResult.grossMarginPercentage,
                                          showPercentage: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  Widget _buildFilterChip(String label, QuoteStatus? status, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: isSelected ? Colors.white : AppColors.textSecondary,
      ),
      onSelected: (_) => widget.quotesController.setStatusFilter(status),
    );
  }
}
