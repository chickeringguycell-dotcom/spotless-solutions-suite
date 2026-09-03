import 'package:flutter/material.dart';
import '../../widgets/touch_stepper.dart';
import '../../widgets/common_text_field.dart';
import '../../state/estimate_wizard_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/validation/input_validators.dart';
import '../../../domain/entities/site_data.dart';

/// Step 2: Site Walkthrough & Building Physical Specifications.
class Step2SiteWalkthroughScreen extends StatefulWidget {
  final EstimateWizardController controller;

  const Step2SiteWalkthroughScreen({super.key, required this.controller});

  @override
  State<Step2SiteWalkthroughScreen> createState() => _Step2SiteWalkthroughScreenState();
}

class _Step2SiteWalkthroughScreenState extends State<Step2SiteWalkthroughScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _sqFtController;
  late TextEditingController _carpetSqFtController;
  late TextEditingController _vinylSqFtController;
  late TextEditingController _tileSqFtController;
  late TextEditingController _concreteSqFtController;
  late TextEditingController _hardwoodSqFtController;
  late TextEditingController _customSecurityMinutesController;
  late TextEditingController _securityDetailsController;
  late TextEditingController _parkingNotesController;

  // Mobilization controllers
  late TextEditingController _travelTimeController;
  late TextEditingController _mileageController;
  late TextEditingController _parkingFeesController;
  late TextEditingController _tollFeesController;
  late TextEditingController _setupMinutesController;

  @override
  void initState() {
    super.initState();
    final site = widget.controller.siteData;
    _sqFtController = TextEditingController(text: site.totalSquareFeet.toStringAsFixed(0));
    _carpetSqFtController = TextEditingController(text: site.carpetSqFt.toStringAsFixed(0));
    _vinylSqFtController = TextEditingController(text: site.vinylLvtSqFt.toStringAsFixed(0));
    _tileSqFtController = TextEditingController(text: site.tileSqFt.toStringAsFixed(0));
    _concreteSqFtController = TextEditingController(text: site.concreteSqFt.toStringAsFixed(0));
    _hardwoodSqFtController = TextEditingController(text: site.hardwoodSqFt.toStringAsFixed(0));
    _customSecurityMinutesController = TextEditingController(text: site.customSecurityMinutes.toStringAsFixed(0));
    _securityDetailsController = TextEditingController(text: site.securityAccessDetails);
    _parkingNotesController = TextEditingController(text: site.parkingAccessNotes);

    _travelTimeController = TextEditingController(text: site.mobilization.travelTimeMinutes.toStringAsFixed(0));
    _mileageController = TextEditingController(text: site.mobilization.mileage.toStringAsFixed(0));
    _parkingFeesController = TextEditingController(text: site.mobilization.parkingFees.toStringAsFixed(2));
    _tollFeesController = TextEditingController(text: site.mobilization.tollFees.toStringAsFixed(2));
    _setupMinutesController = TextEditingController(text: site.mobilization.setupUnloadMinutes.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _sqFtController.dispose();
    _carpetSqFtController.dispose();
    _vinylSqFtController.dispose();
    _tileSqFtController.dispose();
    _concreteSqFtController.dispose();
    _hardwoodSqFtController.dispose();
    _customSecurityMinutesController.dispose();
    _securityDetailsController.dispose();
    _parkingNotesController.dispose();
    _travelTimeController.dispose();
    _mileageController.dispose();
    _parkingFeesController.dispose();
    _tollFeesController.dispose();
    _setupMinutesController.dispose();
    super.dispose();
  }

  SiteData get _currentSite => widget.controller.siteData;

  void _updateSite(SiteData updated) {
    widget.controller.updateSiteData(updated);
  }

  void _syncSqFt() {
    final double sqft = double.tryParse(_sqFtController.text.replaceAll(',', '').trim()) ?? 0;
    _updateSite(_currentSite.copyWith(totalSquareFeet: sqft));
  }

  void _syncFlooring() {
    _updateSite(_currentSite.copyWith(
      carpetSqFt: double.tryParse(_carpetSqFtController.text.replaceAll(',', '').trim()) ?? 0,
      vinylLvtSqFt: double.tryParse(_vinylSqFtController.text.replaceAll(',', '').trim()) ?? 0,
      tileSqFt: double.tryParse(_tileSqFtController.text.replaceAll(',', '').trim()) ?? 0,
      concreteSqFt: double.tryParse(_concreteSqFtController.text.replaceAll(',', '').trim()) ?? 0,
      hardwoodSqFt: double.tryParse(_hardwoodSqFtController.text.replaceAll(',', '').trim()) ?? 0,
    ));
  }

  void _syncMobilization() {
    _updateSite(_currentSite.copyWith(
      mobilization: MobilizationData(
        travelTimeMinutes: double.tryParse(_travelTimeController.text) ?? 0,
        mileage: double.tryParse(_mileageController.text) ?? 0,
        parkingFees: double.tryParse(_parkingFeesController.text) ?? 0,
        tollFees: double.tryParse(_tollFeesController.text) ?? 0,
        setupUnloadMinutes: double.tryParse(_setupMinutesController.text) ?? 0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final site = _currentSite;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Total Cleanable Area
            CommonTextField(
              label: 'Total Cleanable Area (Sq Ft) *',
              hint: 'e.g. 5,000',
              controller: _sqFtController,
              prefixIcon: Icons.square_foot,
              keyboardType: TextInputType.number,
              validator: (v) => InputValidators.validatePositiveNumber(v, 'Total square feet'),
              onChanged: (_) => _syncSqFt(),
            ),

            const SizedBox(height: 16),
            _buildSectionHeader('1. Restrooms & Fixtures (+5m Toilet, +3m Urinal, +2m Sink, +8m Shower)'),
            const SizedBox(height: 8),

            TouchStepper(
              label: 'Restroom Enclosures',
              subtitle: 'Multi-stall or private restroom suites',
              value: site.bathroomsCount,
              icon: Icons.wc,
              onChanged: (val) => _updateSite(site.copyWith(bathroomsCount: val)),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TouchStepper(
                    label: 'Toilets (+5m)',
                    value: site.toiletsCount,
                    onChanged: (val) => _updateSite(site.copyWith(toiletsCount: val)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TouchStepper(
                    label: 'Urinals (+3m)',
                    value: site.urinalsCount,
                    onChanged: (val) => _updateSite(site.copyWith(urinalsCount: val)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TouchStepper(
                    label: 'Sinks (+2m)',
                    value: site.sinksCount,
                    onChanged: (val) => _updateSite(site.copyWith(sinksCount: val)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TouchStepper(
                    label: 'Showers (+8m)',
                    value: site.showersCount,
                    icon: Icons.shower,
                    onChanged: (val) => _updateSite(site.copyWith(showersCount: val)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            _buildSectionHeader('2. Breakrooms, Workstations & Common Areas'),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TouchStepper(
                    label: 'Standard Breakrooms (+10m)',
                    value: site.standardBreakroomsCount,
                    icon: Icons.coffee,
                    onChanged: (val) => _updateSite(site.copyWith(standardBreakroomsCount: val)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TouchStepper(
                    label: 'Large/Full Kitchens (+20m)',
                    value: site.largeKitchensCount,
                    icon: Icons.kitchen,
                    onChanged: (val) => _updateSite(site.copyWith(largeKitchensCount: val)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            TouchStepper(
              label: 'Workstations / Desks',
              subtitle: 'Individual offices & cubicles',
              value: site.workstationsCount,
              icon: Icons.desk,
              onChanged: (val) => _updateSite(site.copyWith(workstationsCount: val)),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TouchStepper(
                    label: 'Conference Rooms (+3m)',
                    value: site.conferenceRoomsCount,
                    icon: Icons.meeting_room,
                    onChanged: (val) => _updateSite(site.copyWith(conferenceRoomsCount: val)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TouchStepper(
                    label: 'Main Entrances (+5m)',
                    value: site.entrancesCount,
                    icon: Icons.door_front_door_outlined,
                    onChanged: (val) => _updateSite(site.copyWith(entrancesCount: val)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            _buildSectionHeader('3. Operational Complexity Multipliers'),
            const SizedBox(height: 8),

            // Traffic Level Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Occupancy & Foot Traffic Level:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<TrafficLevel>(
                      value: site.trafficLevel,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                      items: TrafficLevel.values
                          .map((t) => DropdownMenuItem(value: t, child: Text(t.displayName, style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) _updateSite(site.copyWith(trafficLevel: val));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Trash Level Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Trash & Waste Generation Level:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<TrashLevel>(
                      value: site.trashLevel,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                      items: TrashLevel.values
                          .map((t) => DropdownMenuItem(value: t, child: Text(t.displayName, style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) _updateSite(site.copyWith(trashLevel: val));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Site Condition Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Facility Soil / Maintenance Condition:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<SiteCondition>(
                      value: site.siteCondition,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                      items: SiteCondition.values
                          .map((c) => DropdownMenuItem(value: c, child: Text(c.displayName, style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) _updateSite(site.copyWith(siteCondition: val));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Vertical Transport: Stairs vs Elevators
            Row(
              children: [
                Expanded(
                  child: TouchStepper(
                    label: 'Staircases (+8m)',
                    value: site.stairsCount,
                    icon: Icons.stairs,
                    onChanged: (val) => _updateSite(site.copyWith(stairsCount: val)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TouchStepper(
                    label: 'Elevators (+4m)',
                    value: site.elevatorsCount,
                    icon: Icons.elevator,
                    onChanged: (val) => _updateSite(site.copyWith(elevatorsCount: val)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            _buildSectionHeader('4. Security & Access Protocol'),
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Security / Alarm Complexity:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<SecurityComplexity>(
                      value: site.securityComplexity,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                      items: SecurityComplexity.values
                          .map((s) => DropdownMenuItem(value: s, child: Text(s.displayName, style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) _updateSite(site.copyWith(securityComplexity: val));
                      },
                    ),
                    if (site.securityComplexity == SecurityComplexity.highSecurityCustom) ...[
                      const SizedBox(height: 8),
                      TextField(
                        controller: _customSecurityMinutesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Custom Security Minutes Per Visit', suffixText: 'min'),
                        onChanged: (v) {
                          final double? mins = double.tryParse(v);
                          if (mins != null) _updateSite(site.copyWith(customSecurityMinutes: mins));
                        },
                      ),
                    ],
                    const SizedBox(height: 8),
                    TextField(
                      controller: _securityDetailsController,
                      decoration: const InputDecoration(
                        labelText: 'Security Access Notes & Alarm Codes',
                        hintText: 'e.g. Disarm panel code 4912 within 45s of entry',
                      ),
                      onChanged: (v) => _updateSite(site.copyWith(securityAccessDetails: v)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            _buildSectionHeader('5. Mobilization & Route Travel (Internal Costs)'),
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _travelTimeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Travel Time (min)', suffixText: 'min'),
                            onChanged: (_) => _syncMobilization(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _mileageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Roundtrip Miles', suffixText: 'mi'),
                            onChanged: (_) => _syncMobilization(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _parkingFeesController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(labelText: 'Parking Fees (\$/visit)', prefixText: '\$ '),
                            onChanged: (_) => _syncMobilization(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _tollFeesController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(labelText: 'Tolls (\$/visit)', prefixText: '\$ '),
                            onChanged: (_) => _syncMobilization(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _setupMinutesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Setup / Unload / Staging Time (min)', suffixText: 'min'),
                      onChanged: (_) => _syncMobilization(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            _buildSectionHeader('6. Flooring Breakdown (Sq Ft)'),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    label: 'Carpet (sq ft)',
                    controller: _carpetSqFtController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _syncFlooring(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonTextField(
                    label: 'Vinyl / LVT (sq ft)',
                    controller: _vinylSqFtController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _syncFlooring(),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    label: 'Tile / Grout (sq ft)',
                    controller: _tileSqFtController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _syncFlooring(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonTextField(
                    label: 'Concrete / Hardwood',
                    controller: _concreteSqFtController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _syncFlooring(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => widget.controller.previousStep(),
                    child: const Text('Back to Customer'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _syncSqFt();
                        _syncFlooring();
                        _syncMobilization();
                        widget.controller.nextStep();
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Service Frequency'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: -0.2,
      ),
    );
  }
}
