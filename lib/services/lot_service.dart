import '../models/lot.dart';
import '../repositories/lot_repository.dart';

class LotService {
  final ILotRepository repository;

  LotService({required this.repository});

  Future<List<Lot>> getMyScannedLots() async {
    return await repository.getScannedLots();
  }

  Future<Lot?> searchLotByCode(String code) async {
    if (code.trim().isEmpty) return null;
    return await repository.getLotByCode(code.trim());
  }

  Future<List<Lot>> getDemoLots() async {
    return await repository.getAllAvailableMockLots();
  }
}
