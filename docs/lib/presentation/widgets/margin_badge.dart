import 'package:flutter/material.dart';
import '../../domain/services/pricing_engine.dart';
import '../../core/utils/currency_formatter.dart';

/// Green / Yellow / Red profitability status pill badge.
class MarginBadge extends StatelessWidget {
  final ProfitabilityStatus status;
  final double marginPercentage;
  final bool showPercentage;

  const MarginBadge({
    super.key,
    required this.status,
    required this.marginPercentage,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.color.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: status.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            showPercentage
                ? '${status.label} (${CurrencyFormatter.formatPercent(marginPercentage)})'
                : status.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }
}
