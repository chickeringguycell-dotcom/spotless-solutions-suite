import 'package:flutter/material.dart';
import '../widgets/margin_badge.dart';
import '../state/quotes_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../domain/entities/quote.dart';

/// Comprehensive Quote Detail Screen supporting both internal audit and customer view.
class QuoteDetailScreen extends StatefulWidget {
  final Quote quote;
  final QuotesController quotesController;

  const QuoteDetailScreen({
    super.key,
    required this.quote,
    required this.quotesController,
  });

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  bool _isCustomerView = false;
  late Quote _quote;

  @override
  void initState() {
    super.initState();
    _quote = widget.quote;
  }

  void _updateStatus(Quote updated) {
    setState(() {
      _quote = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final summary = _quote.summary;
    final pricing = summary.pricingResult;
    final cost = summary.costBreakdown;
    final labor = summary.laborBreakdown;
    final site = _quote.siteData;

    return Scaffold(
      appBar: AppBar(
        title: Text(_quote.quoteNumber),
        actions: [
          IconButton(
            icon: Icon(_isCustomerView ? Icons.analytics_outlined : Icons.person_pin_outlined),
            tooltip: _isCustomerView ? 'Switch to Internal Audit' : 'Switch to Customer View',
            onPressed: () {
              setState(() {
                _isCustomerView = !_isCustomerView;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mode Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isCustomerView ? const Color(0xFFF0FDF4) : const Color(0xFFF0F7FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isCustomerView ? AppColors.success.withOpacity(0.4) : AppColors.info.withOpacity(0.4),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _isCustomerView ? Icons.check_circle : Icons.lock_outline,
                    size: 18,
                    color: _isCustomerView ? AppColors.success : AppColors.info,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isCustomerView ? 'Customer Proposal View (Costs Hidden)' : 'Internal Management Audit View',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _isCustomerView ? AppColors.success : AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (_isCustomerView) ...[
              _buildCustomerFacingCard(summary, site),
            ] else ...[
              _buildInternalAuditCard(summary, pricing, cost, labor, site),
            ],

            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildInternalAuditCard(
    dynamic summary,
    dynamic pricing,
    dynamic cost,
    dynamic labor,
    dynamic site,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_quote.customer.companyName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
                    MarginBadge(
                      status: pricing.profitabilityStatus,
                      marginPercentage: pricing.grossMarginPercentage,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Facility: ${_quote.customer.serviceAddress}',
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8))),
                const Divider(color: Colors.white24, height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('RECOMMENDED / VISIT', style: TextStyle(color: AppColors.accentLight, fontSize: 11, fontWeight: FontWeight.w700)),
                        Text(CurrencyFormatter.formatCurrency(pricing.finalPricePerVisit),
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('MONTHLY CONTRACT', style: TextStyle(color: AppColors.accentLight, fontSize: 11, fontWeight: FontWeight.w700)),
                        Text(CurrencyFormatter.formatCurrency(summary.totalMonthlyInvoice),
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.accentLight)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
        const Text('Internal Cost & Labor Engine Summary', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary)),
        const SizedBox(height: 8),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildRow('Total Area & Frequency', '${CurrencyFormatter.formatSqFt(site.totalSquareFeet)} • ${_quote.frequency.label}'),
                _buildRow('Labor Hours Per Visit', CurrencyFormatter.formatHours(labor.totalEstimatedHoursPerVisit)),
                _buildRow('Assigned Cleaner Role', '${_quote.assignedRole.title} (${CurrencyFormatter.formatCurrency(cost.hourlyWage)}/hr)'),
                _buildRow('Direct Labor Cost', CurrencyFormatter.formatCurrency(cost.directLaborCost)),
                _buildRow('Payroll Burden Cost', CurrencyFormatter.formatCurrency(cost.payrollBurdenCost)),
                _buildRow('Supplies & Equipment', CurrencyFormatter.formatCurrency(cost.suppliesCost + cost.equipmentAllowanceCost)),
                _buildRow('Overhead Allocation', CurrencyFormatter.formatCurrency(cost.overheadAllocationCost)),
                const Divider(),
                _buildRow('True Job Cost Per Visit', CurrencyFormatter.formatCurrency(cost.trueJobCostPerVisit), isBold: true),
                _buildRow('Gross Profit Per Visit', CurrencyFormatter.formatCurrency(pricing.grossProfitPerVisit), isBold: true),
                _buildRow('Gross Margin %', CurrencyFormatter.formatPercent(pricing.grossMarginPercentage), isBold: true),
              ],
            ),
          ),
        ),

        if (_quote.internalNotes.isNotEmpty) ...[
          const SizedBox(height: 12),
          Card(
            color: const Color(0xFFFEF3C7),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Internal Notes:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.warning)),
                  const SizedBox(height: 4),
                  Text(_quote.internalNotes, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCustomerFacingCard(dynamic summary, dynamic site) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_quote.customer.companyName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primary)),
            Text('Attention: ${_quote.customer.contactName}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            Text('Service Location: ${_quote.customer.serviceAddress}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const Divider(height: 24),

            const Text('COMMERCIAL CLEANING PROPOSAL', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.primary)),
            const SizedBox(height: 6),
            Text('• Cleaning Frequency: ${_quote.frequency.label} (${CurrencyFormatter.formatDecimal(_quote.frequency.visitsPerMonth)} visits/month)\n'
                '• Facility Cleanable Area: ${CurrencyFormatter.formatSqFt(site.totalSquareFeet)}\n'
                '• Offices/Desks: ${site.workstationsCount} | Restrooms: ${site.bathroomsCount}\n'
                '• Breakrooms: ${site.kitchensCount} | Conference Rooms: ${site.conferenceRoomsCount}',
                style: const TextStyle(fontSize: 13, height: 1.4)),

            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Price Per Visit:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(CurrencyFormatter.formatCurrency(summary.pricingResult.finalPricePerVisit),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Monthly Contract Investment:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                Text(CurrencyFormatter.formatCurrency(summary.totalMonthlyInvoice),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.success)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (_quote.status == QuoteStatus.draft)
          ElevatedButton.icon(
            onPressed: () {
              final updated = widget.quotesController.markAsSent(_quote.id);
              _updateStatus(updated);
            },
            icon: const Icon(Icons.send),
            label: const Text('Mark as Sent to Client'),
          ),
        if (_quote.status == QuoteStatus.sent || _quote.status == QuoteStatus.draft) ...[
          const SizedBox(height: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
            onPressed: () {
              final updated = widget.quotesController.markAsAccepted(_quote.id);
              _updateStatus(updated);
            },
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Mark Accepted by Client'),
          ),
        ],
        if (_quote.status == QuoteStatus.accepted) ...[
          const SizedBox(height: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              final updated = widget.quotesController.convertToActiveCustomer(_quote.id);
              _updateStatus(updated);
            },
            icon: const Icon(Icons.verified_user),
            label: const Text('Convert to Active Customer Account'),
          ),
        ],
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: isBold ? FontWeight.w700 : FontWeight.w400)),
          Text(value, style: TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: isBold ? FontWeight.w800 : FontWeight.w600)),
        ],
      ),
    );
  }
}
