import '../../domain/entities/customer.dart';
import '../../domain/entities/site_data.dart';
import '../../domain/entities/service_frequency.dart';
import '../../domain/entities/employee_role.dart';
import '../../domain/entities/special_service.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../domain/entities/quote.dart';
import '../../domain/services/quote_engine.dart';

/// Pre-populated realistic sample commercial accounts for live walkthrough testing.
class SampleData {
  static final DateTime _now = DateTime.now();

  static List<Customer> get sampleCustomers => [
        Customer(
          id: 'cust-101',
          companyName: 'Apex Technology Partners',
          contactName: 'Sarah Jenkins',
          phone: '(555) 234-8901',
          email: 'sjenkins@apextech.example.com',
          serviceAddress: '450 Innovation Parkway, Suite 300, Metro City',
          billingAddress: '450 Innovation Parkway, Suite 300, Metro City',
          notes: 'Keycard access at west lobby. Security guard on duty until 8 PM.',
          isActiveAccount: true,
          createdAt: _now.subtract(const Duration(days: 45)),
          updatedAt: _now.subtract(const Duration(days: 2)),
        ),
        Customer(
          id: 'cust-102',
          companyName: 'Horizon Financial Group',
          contactName: 'Marcus Vance',
          phone: '(555) 876-4321',
          email: 'mvance@horizonfg.example.com',
          serviceAddress: '1200 Financial Plaza, Floor 8, Metro City',
          billingAddress: 'P.O. Box 4402, Metro City',
          notes: 'High-end executive boardroom. Specialized hardwood care required.',
          isActiveAccount: false,
          createdAt: _now.subtract(const Duration(days: 12)),
          updatedAt: _now.subtract(const Duration(days: 1)),
        ),
        Customer(
          id: 'cust-103',
          companyName: 'Synergy Health Clinic',
          contactName: 'Dr. Elena Rostova',
          phone: '(555) 349-1122',
          email: 'erostova@synergyhealth.example.com',
          serviceAddress: '88 Wellness Boulevard, Suite 100, Metro City',
          billingAddress: '88 Wellness Boulevard, Suite 100, Metro City',
          notes: 'Medical-grade terminal disinfection protocol required for exam rooms.',
          isActiveAccount: false,
          createdAt: _now.subtract(const Duration(days: 4)),
          updatedAt: _now.subtract(const Duration(days: 4)),
        ),
      ];

  static List<Quote> generateSampleQuotes(PricingSettings settings) {
    final List<Customer> customers = sampleCustomers;
    final List<EmployeeRole> roles = settings.wageLadder;

    // Quote 1: Apex Technology (5x Weekly M-F, Accepted)
    const site1 = SiteData(
      totalSquareFeet: 8500,
      workstationsCount: 45,
      bathroomsCount: 4,
      toiletsCount: 6,
      urinalsCount: 2,
      sinksCount: 6,
      showersCount: 1,
      standardBreakroomsCount: 2,
      largeKitchensCount: 0,
      conferenceRoomsCount: 4,
      entrancesCount: 2,
      carpetSqFt: 6000,
      vinylLvtSqFt: 2500,
      estimatedOccupancy: 50,
      trafficLevel: TrafficLevel.normal,
      trashLevel: TrashLevel.normal,
      siteCondition: SiteCondition.normal,
      stairsCount: 1,
      elevatorsCount: 2,
      securityComplexity: SecurityComplexity.normalKeyAlarm,
      securityAccessDetails: 'Keycard reader on 3rd floor foyer',
      cleaningShift: CleaningShift.night,
      parkingAccessNotes: 'Underground garage space #42',
    );
    final summary1 = QuoteEngine.calculateQuoteSummary(
      site: site1,
      frequency: ServiceFrequency.fiveTimesWeekly,
      role: roles[1], // Cleaner $24/hr
      settings: settings,
      specialServices: [
        SpecialService.standardCatalog[0].copyWith(quantity: 8500), // Initial deep clean
        SpecialService.standardCatalog[1].copyWith(quantity: 6000), // Carpet extraction
      ],
    );
    final quote1 = Quote(
      id: 'quote-001',
      quoteNumber: 'SS-2026-1088',
      customer: customers[0],
      siteData: site1,
      frequency: ServiceFrequency.fiveTimesWeekly,
      assignedRole: roles[1],
      summary: summary1,
      status: QuoteStatus.accepted,
      internalNotes: 'Targeted standard 40% margin. Client approved initial deep clean add-on.',
      customerFacingNotes: 'Scope includes nightly general commercial office cleaning and surface disinfection.',
      createdAt: _now.subtract(const Duration(days: 20)),
      updatedAt: _now.subtract(const Duration(days: 15)),
      sentAt: _now.subtract(const Duration(days: 18)),
      acceptedAt: _now.subtract(const Duration(days: 15)),
      expirationDate: _now.add(const Duration(days: 10)),
      estimatedMinutes: summary1.laborBreakdown.finalTotalMinutes,
      estimatedCost: summary1.costBreakdown.trueJobCostPerVisit,
      estimatedMargin: summary1.pricingResult.grossMarginPercentage,
    );

    // Quote 2: Horizon Financial (3x Weekly, Sent)
    const site2 = SiteData(
      totalSquareFeet: 12000,
      workstationsCount: 60,
      bathroomsCount: 6,
      toiletsCount: 8,
      urinalsCount: 4,
      sinksCount: 10,
      showersCount: 0,
      standardBreakroomsCount: 2,
      largeKitchensCount: 1,
      conferenceRoomsCount: 6,
      entrancesCount: 2,
      carpetSqFt: 9000,
      vinylLvtSqFt: 2000,
      hardwoodSqFt: 1000,
      estimatedOccupancy: 70,
      trafficLevel: TrafficLevel.high,
      trashLevel: TrashLevel.heavy,
      siteCondition: SiteCondition.normal,
      stairsCount: 2,
      elevatorsCount: 3,
      securityComplexity: SecurityComplexity.complexSecurity,
      securityAccessDetails: 'Arm/Disarm DSC security panel code 4912',
      cleaningShift: CleaningShift.night,
    );
    final summary2 = QuoteEngine.calculateQuoteSummary(
      site: site2,
      frequency: ServiceFrequency.threeTimesWeekly,
      role: roles[2], // Senior cleaner $26/hr
      settings: settings,
      specialServices: [
        SpecialService.standardCatalog[2].copyWith(quantity: 2000), // Floor stripping
        SpecialService.standardCatalog[3].copyWith(quantity: 2000), // Floor waxing
      ],
    );
    final quote2 = Quote(
      id: 'quote-002',
      quoteNumber: 'SS-2026-2144',
      customer: customers[1],
      siteData: site2,
      frequency: ServiceFrequency.threeTimesWeekly,
      assignedRole: roles[2],
      summary: summary2,
      status: QuoteStatus.sent,
      internalNotes: 'Client reviewing budget with board of directors next Tuesday.',
      customerFacingNotes: 'Spotless Solutions comprehensive triple-weekly office maintenance package.',
      createdAt: _now.subtract(const Duration(days: 5)),
      updatedAt: _now.subtract(const Duration(days: 4)),
      sentAt: _now.subtract(const Duration(days: 4)),
      expirationDate: _now.add(const Duration(days: 25)),
      estimatedMinutes: summary2.laborBreakdown.finalTotalMinutes,
      estimatedCost: summary2.costBreakdown.trueJobCostPerVisit,
      estimatedMargin: summary2.pricingResult.grossMarginPercentage,
    );

    // Quote 3: Synergy Health Clinic (5x Weekly, Draft)
    const site3 = SiteData(
      totalSquareFeet: 4200,
      workstationsCount: 15,
      bathroomsCount: 3,
      toiletsCount: 3,
      urinalsCount: 1,
      sinksCount: 8,
      showersCount: 0,
      standardBreakroomsCount: 1,
      largeKitchensCount: 0,
      conferenceRoomsCount: 1,
      entrancesCount: 1,
      carpetSqFt: 1200,
      vinylLvtSqFt: 3000,
      estimatedOccupancy: 30,
      trafficLevel: TrafficLevel.high,
      trashLevel: TrashLevel.normal,
      siteCondition: SiteCondition.needsImprovement,
      securityComplexity: SecurityComplexity.normalKeyAlarm,
      cleaningShift: CleaningShift.night,
      requiresSpecialSanitation: true,
    );
    final summary3 = QuoteEngine.calculateQuoteSummary(
      site: site3,
      frequency: ServiceFrequency.fiveTimesWeekly,
      role: roles[3], // Lead cleaner $28/hr
      settings: settings,
      specialServices: [
        SpecialService.standardCatalog[0].copyWith(quantity: 4200), // Initial deep clean
      ],
    );
    final quote3 = Quote(
      id: 'quote-003',
      quoteNumber: 'SS-2026-3091',
      customer: customers[2],
      siteData: site3,
      frequency: ServiceFrequency.fiveTimesWeekly,
      assignedRole: roles[3],
      summary: summary3,
      status: QuoteStatus.draft,
      internalNotes: 'Requires special hospital-grade disinfectant spray and dwell-time protocols.',
      customerFacingNotes: 'Spotless Solutions healthcare clinic sanitation specifications.',
      createdAt: _now.subtract(const Duration(hours: 3)),
      updatedAt: _now.subtract(const Duration(hours: 1)),
      expirationDate: _now.add(const Duration(days: 30)),
      estimatedMinutes: summary3.laborBreakdown.finalTotalMinutes,
      estimatedCost: summary3.costBreakdown.trueJobCostPerVisit,
      estimatedMargin: summary3.pricingResult.grossMarginPercentage,
    );

    return [quote1, quote2, quote3];
  }
}
