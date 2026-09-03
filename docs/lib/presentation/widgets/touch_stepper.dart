import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Large touch-friendly counter widget designed for commercial site walkthroughs.
/// Allows rapid counting of restrooms, fixtures, workstations, conference rooms without typing.
class TouchStepper extends StatelessWidget {
  final String label;
  final String? subtitle;
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;
  final IconData? icon;

  const TouchStepper({
    super.key,
    required this.label,
    this.subtitle,
    required this.value,
    this.minValue = 0,
    this.maxValue = 999,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Decrement Button (Minimum 44x44 pt touch target)
          _buildActionButton(
            icon: Icons.remove,
            onPressed: value > minValue ? () => onChanged(value - 1) : null,
          ),
          Container(
            constraints: const SizeConstraints(minWidth: 44),
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),
          // Increment Button (Minimum 44x44 pt touch target)
          _buildActionButton(
            icon: Icons.add,
            onPressed: value < maxValue ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required VoidCallback? onPressed}) {
    return Material(
      color: onPressed != null ? AppColors.surfaceElevated : AppColors.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: onPressed != null ? AppColors.border : AppColors.border.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: onPressed != null ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
