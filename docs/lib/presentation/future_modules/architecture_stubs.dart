/// Future Architecture Extension Interfaces for V2+
///
/// Designed to provide clean integration seams for:
/// - Employee accounts & multi-user permissions
/// - Job scheduling & cleaner checklists
/// - Clock-in/clock-out & GPS check-in
/// - Photo verification & quality inspections (QC Sentinel)
/// - Supply inventory & order replenishment
/// - Customer self-service portal
/// - Invoicing & automated recurring Stripe/ACH billing
/// - Cloud sync & Push notifications

abstract class IJobSchedulingService {
  Future<void> scheduleRecurringVisits({required String quoteId, required List<DateTime> shiftDates});
}

abstract class ICleanerChecklistService {
  Future<List<String>> generateChecklistForSite(String siteId);
  Future<void> completeTask(String siteId, String taskId);
}

abstract class ITimecardGpsService {
  Future<bool> verifyGpsClockIn({
    required String employeeId,
    required String siteAddress,
    required double latitude,
    required double longitude,
  });
  Future<void> recordClockOut({required String employeeId, required DateTime timestamp});
}

abstract class IQualityInspectionService {
  Future<void> submitInspectionScorecard({
    required String siteId,
    required int inspectionScore, // 0 - 100
    required List<String> photoUris,
    required String auditorNotes,
  });
}

abstract class ISupplyInventoryService {
  Future<void> trackSupplyDepletion({required String siteId, required Map<String, double> itemsUsed});
  Future<void> reorderSupplies({required String supplierId, required Map<String, int> orderQuantities});
}

abstract class IInvoicingRecurringBillingService {
  Future<String> generateMonthlyInvoice({required String customerId, required String quoteId});
  Future<void> processAutoDebit({required String invoiceId, required double amount});
}

abstract class ICloudSyncProvider {
  Future<void> syncLocalToCloud();
  Future<void> pullCloudUpdates();
}
