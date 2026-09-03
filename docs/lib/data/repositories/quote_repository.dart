import '../../domain/entities/quote.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../core/utils/id_generator.dart';
import '../mock/sample_data.dart';
import 'customer_repository.dart';

/// Repository for storing, updating, filtering, and managing the lifecycle of quotes.
class QuoteRepository {
  final CustomerRepository _customerRepository;
  final List<Quote> _quotes = [];

  QuoteRepository(this._customerRepository, PricingSettings initialSettings) {
    _quotes.addAll(SampleData.generateSampleQuotes(initialSettings));
  }

  List<Quote> getAllQuotes() {
    return List.unmodifiable(_quotes);
  }

  Quote? getQuoteById(String id) {
    try {
      return _quotes.firstWhere((q) => q.id == id);
    } catch (_) {
      return null;
    }
  }

  void saveQuote(Quote quote) {
    final int index = _quotes.indexWhere((q) => q.id == quote.id);
    if (index >= 0) {
      _quotes[index] = quote.copyWith(updatedAt: DateTime.now());
    } else {
      _quotes.insert(0, quote);
    }
  }

  void deleteQuote(String id) {
    _quotes.removeWhere((q) => q.id == id);
  }

  /// Duplicates an existing quote into a new Draft with a fresh quote reference number.
  Quote duplicateQuote(String id) {
    final Quote? original = getQuoteById(id);
    if (original == null) {
      throw Exception('Quote not found for duplication');
    }

    final Quote duplicate = original.copyWith(
      id: IdGenerator.generateId('quote'),
      quoteNumber: IdGenerator.generateQuoteNumber(),
      status: QuoteStatus.draft,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      sentAt: null,
      acceptedAt: null,
      internalNotes: 'Duplicated from ${original.quoteNumber}. ${original.internalNotes}',
    );

    _quotes.insert(0, duplicate);
    return duplicate;
  }

  /// Mark quote as Sent to client
  Quote markAsSent(String id) {
    final Quote? quote = getQuoteById(id);
    if (quote == null) throw Exception('Quote not found');
    final Quote updated = quote.copyWith(
      status: QuoteStatus.sent,
      sentAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    saveQuote(updated);
    return updated;
  }

  /// Mark quote as Accepted by client
  Quote markAsAccepted(String id) {
    final Quote? quote = getQuoteById(id);
    if (quote == null) throw Exception('Quote not found');
    final Quote updated = quote.copyWith(
      status: QuoteStatus.accepted,
      acceptedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    saveQuote(updated);
    return updated;
  }

  /// Mark quote as Rejected
  Quote markAsRejected(String id) {
    final Quote? quote = getQuoteById(id);
    if (quote == null) throw Exception('Quote not found');
    final Quote updated = quote.copyWith(
      status: QuoteStatus.rejected,
      updatedAt: DateTime.now(),
    );
    saveQuote(updated);
    return updated;
  }

  /// Converts an accepted quote into an active customer account
  Quote convertToActiveCustomer(String id) {
    final Quote? quote = getQuoteById(id);
    if (quote == null) throw Exception('Quote not found');

    // 1. Mark quote status as converted
    final Quote updatedQuote = quote.copyWith(
      status: QuoteStatus.convertedToCustomer,
      acceptedAt: quote.acceptedAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    saveQuote(updatedQuote);

    // 2. Update customer record to active account in customer repository
    _customerRepository.markAsActiveAccount(quote.customer.id);

    return updatedQuote;
  }
}
