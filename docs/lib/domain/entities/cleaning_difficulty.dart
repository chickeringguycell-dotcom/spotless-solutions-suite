/// 3-Tier simplified cleaning difficulty scale for high-speed quoting.
enum CleaningDifficulty {
  light,
  normal,
  heavy;

  String get displayName {
    switch (this) {
      case CleaningDifficulty.light:
        return 'Light (0.95x - Minimal Soil / Low Density)';
      case CleaningDifficulty.normal:
        return 'Normal (1.00x - Typical Office Standard)';
      case CleaningDifficulty.heavy:
        return 'Heavy (1.20x - High Soil / High Waste)';
    }
  }

  String get shortLabel {
    switch (this) {
      case CleaningDifficulty.light:
        return 'Light';
      case CleaningDifficulty.normal:
        return 'Normal';
      case CleaningDifficulty.heavy:
        return 'Heavy';
    }
  }

  String get iconLabel {
    switch (this) {
      case CleaningDifficulty.light:
        return '🍃 Light';
      case CleaningDifficulty.normal:
        return '🏢 Normal';
      case CleaningDifficulty.heavy:
        return '⚡ Heavy';
    }
  }

  double get multiplier {
    switch (this) {
      case CleaningDifficulty.light:
        return 0.95;
      case CleaningDifficulty.normal:
        return 1.00;
      case CleaningDifficulty.heavy:
        return 1.20;
    }
  }
}
