import 'package:flutter/foundation.dart';
import '../../domain/entities/quote.dart';
import '../../data/repositories/quote_repository.dart';

/// State controller managing saved quotes, filtering, search, and lifecycle transitions.
class QuotesController extends ChangeNotifier {
  final QuoteRepository _repository;
  String _searchQuery = '';
  QuoteStatus? _statusFilter;

  QuotesController(this._repository);

  String get searchQuery => _searchQuery;
  QuoteStatus? get statusFilter => _statusFilter;

  List<Quote> get quotes {
    List<Quote> list = _repository.getAllQuotes();
    if (_statusFilter != null) {
      list = list.where((q) => q.status == _statusFilter).toList();
    }
    if (_searchQuery.trim().isNotEmpty) {
      final String q = _searchQuery.toLowerCase();
      list = list.where((quote) {
        return quote.quoteNumber.toLowerCase().contains(q) ||
            quote.customer.companyName.toLowerCase().contains(q) ||
            quote.customer.contactName.toLowerCase().contains(q) ||
            quote.customer.serviceAddress.toLowerCase().contains(q);
      }).toList();
    }
    return list;
  }

  // KPI Metrics
  int get totalQuotesCount => _repository.getAllQuotes().length;
  int get draftCount => _repository.getAllQuotes().where((q) => q.status == QuoteStatus.draft).length;
  int get sentCount => _repository.getAllQuotes().where((q) => q.status == QuoteStatus.sent).length;
  int get acceptedCount => _repository.getAllQuotes().where((q) => q.status == QuoteStatus.accepted || q.status == QuoteStatus.convertedToCustomer).length;

  double get totalPipelineMonthlyValue {
    return _repository.getAllQuotes()
        .where((q) => q.status == QuoteStatus.sent || q.status == QuoteStatus.accepted || q.status == QuoteStatus.convertedToCustomer)
        .fold(0.0, (sum, q) => sum + q.summary.totalMonthlyInvoice);
  }

  double get totalAnnualAcceptedValue {
    return _repository.getAllQuotes()
        .where((q) => q.status == QuoteStatus.accepted || q.status == QuoteStatus.convertedToCustomer)
        .fold(0.0, (sum, q) => sum + q.summary.totalAnnualContractValue);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(QuoteStatus? filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  void saveQuote(Quote quote) {
    _repository.saveQuote(quote);
    notifyListeners();
  }

  void deleteQuote(String id) {
    _repository.deleteQuote(id);
    notifyListeners();
  }

  Quote duplicateQuote(String id) {
    final Quote duplicate = _repository.duplicateQuote(id);
    notifyListeners();
    return duplicate;
  }

  Quote markAsSent(String id) {
    final Quote updated = _repository.markAsSent(id);
    notifyListeners();
    return updated;
  }

  Quote markAsAccepted(String id) {
    final Quote updated = _repository.markAsAccepted(id);
    notifyListeners();
    return updated;
  }

  Quote markAsRejected(String id) {
    final Quote updated = _repository.markAsRejected(id);
    notifyListeners();
    return updated;
  }

  Quote convertToActiveCustomer(String id) {
    final Quote updated = _repository.convertToActiveCustomer(id);
    notifyListeners();
    return updated;
  }
}
