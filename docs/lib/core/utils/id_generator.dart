import 'dart:math';

/// Utility to generate robust unique identifiers for entities and quotes.
class IdGenerator {
  static final Random _random = Random.secure();

  /// Generates a standard pseudo-UUID string
  static String generateId([String prefix = '']) {
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final String randomHex = List.generate(4, (_) => _random.nextInt(65536).toRadixString(16).padLeft(4, '0')).join('');
    return prefix.isEmpty ? '$timestamp-$randomHex' : '$prefix-$timestamp-$randomHex';
  }

  /// Generates a friendly quote reference number: e.g. SS-2026-8942
  static String generateQuoteNumber() {
    final int year = DateTime.now().year;
    final int randomNum = 1000 + _random.nextInt(9000);
    return 'SS-$year-$randomNum';
  }
}
