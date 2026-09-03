import 'package:test/test.dart';
import '../lib/domain/entities/customer.dart';
import '../lib/domain/entities/site_data.dart';
import '../lib/domain/entities/service_frequency.dart';
import '../lib/domain/entities/employee_role.dart';
import '../lib/domain/entities/pricing_settings.dart';
import '../lib/domain/entities/quote.dart';
import '../lib/domain/services/quote_engine.dart';
import '../lib/data/repositories/customer_repository.dart';
import '../lib/data/repositories/quote_repository.dart';

void main() {
  group('Quote Lifecycle & Repository Tests', () {
    late CustomerRepository customerRepo;
    late QuoteRepository quoteRepo;
    late PricingSettings settings;

    setUp(() {
      customerRepo = CustomerRepository();
      settings = PricingSettings.defaultSettings();
      quoteRepo = QuoteRepository(customerRepo, settings);
    });

    test('creates and saves new quote in repository with learning fields', () {
      final customer = Customer(
        id: 'cust-999',
        companyName: 'Test Commercial Tower',
        contactName: 'Alex Mercer',
        phone: '(555) 999-1111',
        email: 'amercer@tower.example.com',
        serviceAddress: '999 High St, Metro City',
        billingAddress: '999 High St, Metro City',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      const site = SiteData(
        totalSquareFeet: 10000,
        bathroomsCount: 4,
        toiletsCount: 6,
        sinksCount: 6,
        standardBreakroomsCount: 2,
      );

      final summary = QuoteEngine.calculateQuoteSummary(
        site: site,
        frequency: ServiceFrequency.fiveTimesWeekly,
        role: EmployeeRole.defaultWageLadder[1], // Cleaner
        settings: settings,
      );

      final quote = Quote(
        id: 'quote-test-01',
        quoteNumber: 'SS-2026-9999',
        customer: customer,
        siteData: site,
        frequency: ServiceFrequency.fiveTimesWeekly,
        assignedRole: EmployeeRole.defaultWageLadder[1],
        summary: summary,
        status: QuoteStatus.draft,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 30)),
        estimatedMinutes: summary.laborBreakdown.finalTotalMinutes,
        estimatedCost: summary.costBreakdown.trueJobCostPerVisit,
        estimatedMargin: summary.pricingResult.grossMarginPercentage,
      );

      quoteRepo.saveQuote(quote);

      final retrieved = quoteRepo.getQuoteById('quote-test-01');
      expect(retrieved, isNotNull);
      expect(retrieved!.customer.companyName, equals('Test Commercial Tower'));
      expect(retrieved.status, equals(QuoteStatus.draft));
      expect(retrieved.estimatedMinutes, greaterThan(0));
    });

    test('duplicates quote into a new draft with unique id and reference number', () {
      final all = quoteRepo.getAllQuotes();
      final original = all.first;

      final duplicate = quoteRepo.duplicateQuote(original.id);

      expect(duplicate.id, isNot(equals(original.id)));
      expect(duplicate.quoteNumber, isNot(equals(original.quoteNumber)));
      expect(duplicate.status, equals(QuoteStatus.draft));
      expect(duplicate.customer.companyName, equals(original.customer.companyName));
    });

    test('transitions quote status from draft to sent to accepted and converts to active customer', () {
      final all = quoteRepo.getAllQuotes();
      final target = all.firstWhere((q) => q.status == QuoteStatus.draft);

      // 1. Mark Sent
      final sent = quoteRepo.markAsSent(target.id);
      expect(sent.status, equals(QuoteStatus.sent));
      expect(sent.sentAt, isNotNull);

      // 2. Mark Accepted
      final accepted = quoteRepo.markAsAccepted(target.id);
      expect(accepted.status, equals(QuoteStatus.accepted));
      expect(accepted.acceptedAt, isNotNull);

      // 3. Convert to Active Customer
      final converted = quoteRepo.convertToActiveCustomer(target.id);
      expect(converted.status, equals(QuoteStatus.convertedToCustomer));

      final customer = customerRepo.getCustomerById(target.customer.id);
      expect(customer, isNotNull);
      expect(customer!.isActiveAccount, isTrue);
    });
  });
}
