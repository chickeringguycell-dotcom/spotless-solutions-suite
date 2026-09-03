import '../../domain/entities/pricing_settings.dart';

/// Repository for retrieving and updating owner configurable pricing settings.
class SettingsRepository {
  PricingSettings _settings = PricingSettings.defaultSettings();

  PricingSettings getSettings() {
    return _settings;
  }

  void updateSettings(PricingSettings newSettings) {
    _settings = newSettings;
  }

  void resetToDefaults() {
    _settings = PricingSettings.defaultSettings();
  }
}
