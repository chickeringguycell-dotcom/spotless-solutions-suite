import 'package:flutter/material.dart';
import '../../widgets/summary_card.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';

/// Step 5: Labor Hours and True Operating Cost Review (Owner Mode Calculation Stages).
class Step5LaborCostReviewScreen extends StatelessWidget {
  final EstimateWizardController controller;

  const Step5LaborCostReviewScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final summary = controller.currentSummary;
    final labor = summary.laborBreakdown;
    final cost = summary.costBreakdown;
    final site = controller.siteData;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('1. Multi-Stage Labor Formula Breakdown (Owner Mode)'),
          const Text(
            'Exact minutes calculated across each operational stage before and after multipliers.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),

          SummaryCard(
            title: 'TOTAL ESTIMATED LABOR TIME',
            value: '${CurrencyFormatter.formatDecimal(labor.finalTotalMinutes)} min (${CurrencyFormatter.formatHours(labor.totalEstimatedHoursPerVisit)})',
            subtitle: 'Recommended onsite crew duration per visit',
            icon: Icons.timer_outlined,
            valueColor: AppColors.primary,
            backgroundColor: const Color(0xFFF0F7FF),
          ),
          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _buildMinuteRow('Stage 1: Base General Cleaning (${CurrencyFormatter.formatSqFt(site.totalSquareFeet)})', labor.baseCleaningMinutes),
                  const Divider(height: 12),
                  _buildMinuteRow('Stage 2: Restrooms & Fixtures (${site.toiletsCount}T, ${site.urinalsCount}U, ${site.sinksCount}S, ${site.showersCount}Sh)', labor.totalRestroomMinutes),
                  _buildMinuteRow('Stage 3: Breakrooms (${site.standardBreakroomsCount} Std, ${site.largeKitchensCount} Full)', labor.totalBreakroomMinutes),
                  _buildMinuteRow('Stage 4: Conference Rooms (${site.conferenceRoomsCount} @ +3m)', labor.conferenceRoomMinutes),
                  _buildMinuteRow('Stage 5: Entrances, Stairs & Elevators', labor.entranceMinutes + labor.stairMinutes + labor.elevatorMinutes),
                  if (labor.securityMinutes > 0)
                    _buildMinuteRow('Stage 6: Security & Alarm Lockup Procedures', labor.securityMinutes),
                  if (labor.mobilizationMinutes > 0)
                    _buildMinuteRow('Stage 7: Route Travel & Setup/Staging', labor.mobilizationMinutes),
                  const Divider(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal Minutes (Before Multipliers):', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                      Text('${CurrencyFormatter.formatDecimal(labor.unadjustedSubtotalMinutes)} min',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Traffic Multiplier (${site.trafficLevel.shortLabel}):', style: const TextStyle(fontSize: 12)),
                            Text('${labor.trafficMultiplier.toStringAsFixed(2)}x', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Trash Multiplier (${site.trashLevel.shortLabel}):', style: const TextStyle(fontSize: 12)),
                            Text('${labor.trashMultiplier.toStringAsFixed(2)}x', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Condition Multiplier (${site.siteCondition.shortLabel}):', style: const TextStyle(fontSize: 12)),
                            Text('${labor.conditionMultiplier.toStringAsFixed(2)}x', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const Divider(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Composite Complexity Multiplier:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                            Text('${labor.compositeMultiplier.toStringAsFixed(3)}x',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.primary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('2. True Job Cost Engine & Burdened Employee Wage'),
          const Text(
            'Detailed payroll burden breakdown and loaded employee hourly cost.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),

          // Burdened Hourly Wage Callout
          Card(
            color: const Color(0xFFF8FAFC),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Icon(Icons.badge_outlined, color: AppColors.primary, size: 26),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('TRUE HOURLY EMPLOYEE COST',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
                        const SizedBox(height: 2),
                        Text(
                          '${CurrencyFormatter.formatCurrency(cost.trueHourlyEmployeeCost)} / hr',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary),
                        ),
                        Text(
                          'Base Wage: ${CurrencyFormatter.formatCurrency(cost.baseHourlyWage)}/hr + Burden: ${CurrencyFormatter.formatPercent(cost.totalPayrollBurdenPercent)}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _buildCostRow('Direct Cleaner Wages (${CurrencyFormatter.formatHours(cost.estimatedLaborHours)} @ ${CurrencyFormatter.formatCurrency(cost.baseHourlyWage)}/hr)', cost.directLaborCost),
                  _buildCostRow('  • Employer Taxes (FICA/FUTA/SUTA)', cost.employerPayrollTaxesCost),
                  _buildCostRow('  • Workers\' Compensation Insurance', cost.workersCompCost),
                  _buildCostRow('  • Paid Leave & Holiday Allowances', cost.paidLeaveCost + cost.vacationCost),
                  _buildCostRow('  • Safety & Onboarding Training', cost.trainingCost),
                  const Divider(height: 8),
                  _buildCostRow('Cleaning Supplies & Consumables (5%)', cost.suppliesCost),
                  _buildCostRow('Equipment Amortization (3%)', cost.equipmentAllowanceCost),
                  if (cost.travelAndMobilizationCost > 0)
                    _buildCostRow('Travel, Mileage & Tolls/Parking', cost.travelAndMobilizationCost),
                  _buildCostRow('General Overhead Allocation (12%)', cost.overheadAllocationCost),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total True Operating Cost Per Visit:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      Text(CurrencyFormatter.formatCurrency(cost.trueJobCostPerVisit),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.previousStep(),
                  child: const Text('Back to Special Services'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.nextStep(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Pricing Engine'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMinuteRow(String label, double minutes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
          Text('${CurrencyFormatter.formatDecimal(minutes)} min',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
          Text(CurrencyFormatter.formatCurrency(amount),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
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
