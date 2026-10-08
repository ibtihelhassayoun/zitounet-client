import '../models/lot.dart';
import '../models/status_history.dart';
import '../models/quality_analysis.dart';

abstract class ILotRepository {
  Future<List<Lot>> getScannedLots();
  Future<Lot?> getLotByCode(String codeOrId);
  Future<void> addScannedLot(Lot lot);
  Future<List<Lot>> getAllAvailableMockLots();
}

class MockLotRepository implements ILotRepository {
  // Local list of lots scanned/saved by the grower
  final List<Lot> _userScannedLots = [];

  // Global Mock Store (simulates NestJS Database backend)
  final List<Lot> _mockBackendStore = [
    Lot(
      id: 'ZT-2026-001258',
      lotCode: 'ZT-2026-001258',
      clientName: 'Ahmed Ben Ali',
      clientPhone: '20 123 456',
      quantityKg: 250,
      variety: 'Chemlali',
      origin: 'Sfax (Agareb)',
      receptionDate: DateTime.now().subtract(const Duration(hours: 4)),
      currentStatus: LotStatus.crushing,
      huilerieName: 'Huilerie El Baraka',
      huilerieLocation: 'Sousse - Sahel',
      observations: 'Olives de première cueillette, bon état sanitaire.',
      statusHistory: [
        StatusHistory(
          id: 'sh-101',
          lotId: 'ZT-2026-001258',
          status: LotStatus.reception,
          date: DateTime.now().subtract(const Duration(hours: 4)),
          note: 'Réception et pesée du lot',
          updatedBy: 'Agent Huilerie',
        ),
        StatusHistory(
          id: 'sh-102',
          lotId: 'ZT-2026-001258',
          status: LotStatus.weighing,
          date: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)),
          note: 'Poids net 250 kg validé',
          updatedBy: 'Pont Bascule',
        ),
        StatusHistory(
          id: 'sh-103',
          lotId: 'ZT-2026-001258',
          status: LotStatus.waiting,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          note: 'Trémie N° 3',
          updatedBy: 'Habib',
        ),
        StatusHistory(
          id: 'sh-104',
          lotId: 'ZT-2026-001258',
          status: LotStatus.crushing,
          date: DateTime.now().subtract(const Duration(minutes: 45)),
          note: 'Malaxage en cours à 26°C',
          updatedBy: 'Ridha',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    Lot(
      id: 'ZT-2026-001104',
      lotCode: 'ZT-2026-001104',
      clientName: 'Exemple Producteur',
      clientPhone: '98 765 432',
      quantityKg: 180,
      variety: 'Chétoui',
      origin: 'Sousse (Kalâa Kebira)',
      receptionDate: DateTime.now().subtract(const Duration(days: 1)),
      currentStatus: LotStatus.ready,
      huilerieName: 'Huilerie El Baraka',
      huilerieLocation: 'Sousse - Sahel',
      observations: 'Olives vertes récoltées à la main.',
      oilProducedLiters: 42,
      extractionYield: 16.8,
      analysis: QualityAnalysis(
        acidityPercent: 0.35,
        peroxideValue: 5.8,
        qualityGrade: 'Extra Vierge',
        sensoryNote: 'Huile obtenue après extraction à froid.',
        analyzedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      statusHistory: [
        StatusHistory(
          id: 'sh-201',
          lotId: 'ZT-2026-001104',
          status: LotStatus.reception,
          date: DateTime.now().subtract(const Duration(days: 1)),
          note: 'Réception du lot',
        ),
        StatusHistory(
          id: 'sh-202',
          lotId: 'ZT-2026-001104',
          status: LotStatus.weighing,
          date: DateTime.now().subtract(const Duration(hours: 22)),
          note: '180 kg pesé',
        ),
        StatusHistory(
          id: 'sh-203',
          lotId: 'ZT-2026-001104',
          status: LotStatus.waiting,
          date: DateTime.now().subtract(const Duration(hours: 18)),
          note: 'Attente trémie',
        ),
        StatusHistory(
          id: 'sh-204',
          lotId: 'ZT-2026-001104',
          status: LotStatus.crushing,
          date: DateTime.now().subtract(const Duration(hours: 14)),
          note: 'Trituration',
        ),
        StatusHistory(
          id: 'sh-205',
          lotId: 'ZT-2026-001104',
          status: LotStatus.extraction,
          date: DateTime.now().subtract(const Duration(hours: 10)),
          note: 'Extraction centrifuge',
        ),
        StatusHistory(
          id: 'sh-206',
          lotId: 'ZT-2026-001104',
          status: LotStatus.analysis,
          date: DateTime.now().subtract(const Duration(hours: 6)),
          note: 'Acidité 0.35%',
        ),
        StatusHistory(
          id: 'sh-207',
          lotId: 'ZT-2026-001104',
          status: LotStatus.ready,
          date: DateTime.now().subtract(const Duration(hours: 5)),
          note: 'Conditionné (42 L)',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Lot(
      id: 'ZT-2026-001259',
      lotCode: 'ZT-2026-001259',
      clientName: 'Moncef Trabelsi',
      clientPhone: '98 123 456',
      quantityKg: 1400,
      variety: 'Chétoui',
      origin: 'Testour (Béja)',
      receptionDate: DateTime.now().subtract(const Duration(hours: 8)),
      currentStatus: LotStatus.extraction,
      huilerieName: 'Huilerie El Baraka',
      huilerieLocation: 'Sousse - Sahel',
      observations: 'Olives fraîchement cueillies.',
      statusHistory: [
        StatusHistory(
          id: 'sh-301',
          lotId: 'ZT-2026-001259',
          status: LotStatus.reception,
          date: DateTime.now().subtract(const Duration(hours: 8)),
        ),
        StatusHistory(
          id: 'sh-302',
          lotId: 'ZT-2026-001259',
          status: LotStatus.weighing,
          date: DateTime.now().subtract(const Duration(hours: 7)),
        ),
        StatusHistory(
          id: 'sh-303',
          lotId: 'ZT-2026-001259',
          status: LotStatus.waiting,
          date: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        StatusHistory(
          id: 'sh-304',
          lotId: 'ZT-2026-001259',
          status: LotStatus.crushing,
          date: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        StatusHistory(
          id: 'sh-305',
          lotId: 'ZT-2026-001259',
          status: LotStatus.extraction,
          date: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];

  MockLotRepository() {
    // Initially add ZT-2026-001258 and ZT-2026-001104 to user's saved list
    _userScannedLots.add(_mockBackendStore[0]);
    _userScannedLots.add(_mockBackendStore[1]);
  }

  @override
  Future<List<Lot>> getScannedLots() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.from(_userScannedLots);
  }

  @override
  Future<Lot?> getLotByCode(String codeOrId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final normalized = codeOrId.trim().toUpperCase();
    
    // Search in mock backend store
    final found = _mockBackendStore.firstWhere(
      (l) => l.id.toUpperCase() == normalized || l.lotCode.toUpperCase() == normalized,
      orElse: () {
        // If not found in store, generate dynamic lot for testing any code
        final newMock = Lot(
          id: normalized,
          lotCode: normalized,
          clientName: 'Producteur ZitouNet',
          clientPhone: '22 000 111',
          quantityKg: 320,
          variety: 'Chemlali',
          origin: 'Sousse',
          receptionDate: DateTime.now().subtract(const Duration(hours: 2)),
          currentStatus: LotStatus.crushing,
          huilerieName: 'Huilerie El Baraka',
          huilerieLocation: 'Sousse - Sahel',
          statusHistory: [
            StatusHistory(
              id: 'sh-dyn-1',
              lotId: normalized,
              status: LotStatus.reception,
              date: DateTime.now().subtract(const Duration(hours: 2)),
            ),
            StatusHistory(
              id: 'sh-dyn-2',
              lotId: normalized,
              status: LotStatus.weighing,
              date: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
            ),
            StatusHistory(
              id: 'sh-dyn-3',
              lotId: normalized,
              status: LotStatus.waiting,
              date: DateTime.now().subtract(const Duration(hours: 1)),
            ),
            StatusHistory(
              id: 'sh-dyn-4',
              lotId: normalized,
              status: LotStatus.crushing,
              date: DateTime.now().subtract(const Duration(minutes: 20)),
            ),
          ],
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 20)),
        );
        _mockBackendStore.add(newMock);
        return newMock;
      },
    );

    // Add to user's scanned list if not already present
    await addScannedLot(found);
    return found;
  }

  @override
  Future<void> addScannedLot(Lot lot) async {
    if (!_userScannedLots.any((l) => l.lotCode == lot.lotCode)) {
      _userScannedLots.insert(0, lot);
    }
  }

  @override
  Future<List<Lot>> getAllAvailableMockLots() async {
    return _mockBackendStore;
  }
}
