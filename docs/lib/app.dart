import 'package:flutter/material.dart';
import 'core/constants/app_theme.dart';
import 'core/constants/app_metadata.dart';
import 'data/repositories/customer_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/repositories/quote_repository.dart';
import 'presentation/state/settings_controller.dart';
import 'presentation/state/quotes_controller.dart';
import 'presentation/state/estimate_wizard_controller.dart';
import 'presentation/screens/home_dashboard_screen.dart';

/// Root Application Widget wiring up theme, repositories, and state controllers.
class SpotlessEstimatorApp extends StatefulWidget {
  const SpotlessEstimatorApp({super.key});

  @override
  State<SpotlessEstimatorApp> createState() => _SpotlessEstimatorAppState();
}

class _SpotlessEstimatorAppState extends State<SpotlessEstimatorApp> {
  late final CustomerRepository _customerRepository;
  late final SettingsRepository _settingsRepository;
  late final QuoteRepository _quoteRepository;

  late final SettingsController _settingsController;
  late final QuotesController _quotesController;
  late final EstimateWizardController _wizardController;

  @override
  void initState() {
    super.initState();
    _customerRepository = CustomerRepository();
    _settingsRepository = SettingsRepository();
    _quoteRepository = QuoteRepository(_customerRepository, _settingsRepository.getSettings());

    _settingsController = SettingsController(_settingsRepository);
    _quotesController = QuotesController(_quoteRepository);
    _wizardController = EstimateWizardController(_settingsRepository.getSettings());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppMetadata.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeDashboardScreen(
        wizardController: _wizardController,
        quotesController: _quotesController,
        settingsController: _settingsController,
        customerRepository: _customerRepository,
      ),
    );
  }
}
