import '../../domain/entities/customer.dart';
import '../mock/sample_data.dart';

/// Repository interface and in-memory/local storage for Customer records.
class CustomerRepository {
  final List<Customer> _customers = [];

  CustomerRepository() {
    _customers.addAll(SampleData.sampleCustomers);
  }

  List<Customer> getAllCustomers() {
    return List.unmodifiable(_customers);
  }

  Customer? getCustomerById(String id) {
    try {
      return _customers.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  void saveCustomer(Customer customer) {
    final int index = _customers.indexWhere((c) => c.id == customer.id);
    if (index >= 0) {
      _customers[index] = customer;
    } else {
      _customers.insert(0, customer);
    }
  }

  void deleteCustomer(String id) {
    _customers.removeWhere((c) => c.id == id);
  }

  void markAsActiveAccount(String id) {
    final Customer? existing = getCustomerById(id);
    if (existing != null) {
      saveCustomer(existing.copyWith(isActiveAccount: true, updatedAt: DateTime.now()));
    }
  }
}
