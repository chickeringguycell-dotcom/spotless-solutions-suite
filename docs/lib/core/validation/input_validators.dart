/// Input validation utilities for walkthrough inputs, square footage, and settings.
class InputValidators {
  /// Validates required text fields
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates email address format
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return null; // Optional if empty
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates phone number
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final String digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) {
      return 'Please enter at least 10 digits for phone';
    }
    return null;
  }

  /// Validates positive numeric value
  static String? validatePositiveNumber(String? value, String fieldName, {bool allowZero = false}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    final double? numVal = double.tryParse(value.replaceAll(',', '').trim());
    if (numVal == null) {
      return 'Please enter a valid number';
    }
    if (allowZero && numVal < 0) {
      return '$fieldName cannot be negative';
    }
    if (!allowZero && numVal <= 0) {
      return '$fieldName must be greater than zero';
    }
    return null;
  }

  /// Validates gross margin target (must be between 0% and 95% to avoid division by zero)
  static String? validateGrossMargin(double marginFraction) {
    if (marginFraction < 0.0) {
      return 'Target gross margin cannot be negative';
    }
    if (marginFraction >= 0.95) {
      return 'Target gross margin must be under 95% to maintain realistic pricing';
    }
    return null;
  }

  /// Validates production rate (must be positive, e.g. 500 to 10,000 sqft/hr)
  static String? validateProductionRate(double rate) {
    if (rate <= 0) {
      return 'Production rate must be greater than zero';
    }
    if (rate < 500) {
      return 'Production rate is unusually low (< 500 sq ft/hr)';
    }
    if (rate > 10000) {
      return 'Production rate exceeds typical commercial cleaning capacity';
    }
    return null;
  }
}
