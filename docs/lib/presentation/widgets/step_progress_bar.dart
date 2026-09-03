import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Progress indicator showing progress across the 6 wizard walkthrough steps.
class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;
  final ValueChanged<int>? onStepTapped;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
    this.stepTitles = const [
      'Customer',
      'Walkthrough',
      'Frequency',
      'Special',
      'Cost',
      'Summary',
    ],
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              final bool isCompleted = index < currentStep;
              final bool isCurrent = index == currentStep;

              return Expanded(
                child: GestureDetector(
                  onTap: (isCompleted && onStepTapped != null) ? () => onStepTapped!(index) : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 4,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.accent
                          : (isCurrent ? AppColors.accentLight : Colors.white.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${currentStep + 1} of $totalSteps: ${stepTitles[currentStep]}',
                style: const TextStyle(
                  color: AppColors.accentLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                '${((currentStep + 1) / totalSteps * 100).round()}%',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
