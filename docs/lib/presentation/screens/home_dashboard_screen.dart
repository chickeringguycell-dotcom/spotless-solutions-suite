import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../state/quotes_controller.dart';
import '../state/settings_controller.dart';
import '../state/estimate_wizard_controller.dart';
import 'fast_quote_screen.dart';
import 'wizard/estimate_wizard_host_screen.dart';
import 'saved_quotes_screen.dart';
import 'customers_screen.dart';
import 'settings_screen.dart';
import 'quote_detail_screen.dart';

/// Home Dashboard featuring the Fast 6-Input Estimator as the primary hero action.
class HomeDashboardScreen extends StatelessWidget {
  final QuotesController quotesController;
  final SettingsController settingsController;

  const HomeDashboardScreen({
    super.key,
    required this.quotesController,
    required this.settingsController,
  });

  void _openFastQuote(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FastQuoteScreen(
          settingsController: settingsController,
          quotesController: quotesController,
        ),
      ),
    );
  }

  void _openDetailedWalkthrough(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EstimateWizardHostScreen(
          settingsController: settingsController,
          quotesController: quotesController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: quotesController,
      builder: (context, _) {
        final allQuotes = quotesController.quotes;
        final acceptedQuotes = quotesController.acceptedQuotes;
        final totalPipelineValue = quotesController.totalPipelineValue;
        final recentQuotes = allQuotes.take(5).toList();

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.cleaning_services, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 10),
                const Text('Spotless Office Solutions', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                tooltip: 'Owner Settings',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => SettingsScreen(settingsController: settingsController),
                    ),
                  );
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async => quotesController.loadQuotes(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Hero Fast Quoting Card
                Card(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.accent, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '⚡ INSTANT QUOTE ESTIMATOR',
                              style: TextStyle(
                                color: AppColors.accentLight,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text('6 Inputs Only', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Commercial Office Quote',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Produce an accurate, profitable commercial cleaning proposal on-site in seconds.',
                          style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 46),
                          ),
                          onPressed: () => _openFastQuote(context),
                          icon: const Icon(Icons.flash_on, size: 20),
                          label: const Text('NEW QUICK QUOTE (6 INPUTS)', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                        ),
                        const SizedBox(height: 6),
                        Center(
                          child: TextButton.icon(
                            style: TextButton.styleFrom(foregroundColor: Colors.white70),
                            onPressed: () => _openDetailedWalkthrough(context),
                            icon: const Icon(Icons.tune, size: 16),
                            label: const Text('Open Detailed Walkthrough Wizard', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Pipeline Financial Metrics
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: 'PIPELINE VALUE',
                        value: CurrencyFormatter.formatCurrency(totalPipelineValue),
                        subtitle: '${allQuotes.length} active quotes',
                        icon: Icons.monetization_on_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'WON CONTRACTS',
                        value: '${acceptedQuotes.length}',
                        subtitle: 'Accepted commercial accounts',
                        icon: Icons.verified_outlined,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Quick Navigation Hub
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => SavedQuotesScreen(
                                quotesController: quotesController,
                                settingsController: settingsController,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Saved Quotes'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => CustomersScreen(
                                customerRepository: quotesController.quoteRepository.customerRepository,
                                quotesController: quotesController,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.people_outline),
                        label: const Text('Customers'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Recent Quotes Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Quotes',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => SavedQuotesScreen(
                              quotesController: quotesController,
                              settingsController: settingsController,
                            ),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                if (recentQuotes.isEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.note_alt_outlined, size: 40, color: AppColors.textMuted),
                            const SizedBox(height: 8),
                            const Text('No quotes created yet.', style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text('Tap "New Quick Quote" above to build your first estimate.',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  ...recentQuotes.map((quote) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(quote.customer.companyName, style: const TextStyle(fontWeight: FontWeight.w700)),
                          subtitle: Text(
                            '${CurrencyFormatter.formatSqFt(quote.siteData.totalSquareFeet)} • ${quote.frequency.label}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                CurrencyFormatter.formatCurrency(quote.summary.pricingResult.monthlyContractPrice),
                                style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary, fontSize: 14),
                              ),
                              Text('/ month', style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => QuoteDetailScreen(
                                  quote: quote,
                                  quotesController: quotesController,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
                Icon(icon, color: color, size: 18),
              ],
            ),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}
