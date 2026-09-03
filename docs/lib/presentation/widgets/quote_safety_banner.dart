import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Non-destructive banner displaying all automated quote safety check warnings.
class QuoteSafetyBanner extends StatelessWidget {
  final List<String> warnings;

  const QuoteSafetyBanner({super.key, required this.warnings});

  @override
  Widget build(BuildContext context) {
    if (warnings.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.success.withOpacity(0.4)),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Quote Safety Check: Passed all risk and profitability audits.',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.success),
              ),
            ),
          ],
        ),
      );
    }

    final bool hasCritical = warnings.any((w) => w.startsWith('CRITICAL'));

    return Card(
      color: hasCritical ? const Color(0xFFFEF2F2) : const Color(0xFFFFFBEB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: hasCritical ? AppColors.error : AppColors.warning,
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  hasCritical ? Icons.warning_amber_rounded : Icons.info_outline,
                  color: hasCritical ? AppColors.error : AppColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  hasCritical ? 'QUOTE AUDIT ALERTS (${warnings.length})' : 'QUOTE SAFETY ADVISORY (${warnings.length})',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: hasCritical ? AppColors.error : AppColors.warning,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...warnings.map((warning) {
              final bool isCrit = warning.startsWith('CRITICAL');
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontWeight: FontWeight.w800, color: isCrit ? AppColors.error : AppColors.textPrimary)),
                    Expanded(
                      child: Text(
                        warning,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isCrit ? FontWeight.w700 : FontWeight.w500,
                          color: isCrit ? AppColors.error : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
