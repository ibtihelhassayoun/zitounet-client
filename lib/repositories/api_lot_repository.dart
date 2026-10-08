import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lot.dart';
import '../core/config/api_config.dart';
import 'lot_repository.dart';

class ApiLotRepository implements ILotRepository {
  // Local list of lotCodes scanned/saved by the grower
  final List<String> _scannedLotCodes = [];
  
  // Cache of fetched lots
  final Map<String, Lot> _cachedLots = {};

  ApiLotRepository() {
    // Optionally pre-populate for demo/test purposes if needed.
    // _scannedLotCodes.add('ZT-2026-585342');
  }

  @override
  Future<List<Lot>> getScannedLots() async {
    List<Lot> lots = [];
    // Fetch fresh data for all scanned codes
    for (String code in _scannedLotCodes) {
      try {
        final lot = await getLotByCode(code);
        if (lot != null) {
          lots.add(lot);
        }
      } catch (e) {
        // Fallback to cache if network fails, or ignore
        if (_cachedLots.containsKey(code)) {
          lots.add(_cachedLots[code]!);
        }
      }
    }
    return lots;
  }

  @override
  Future<Lot?> getLotByCode(String codeOrId) async {
    final code = codeOrId.trim();
    
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/lots/$code'));
    
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final lot = Lot.fromJson(jsonResponse);
      _cachedLots[lot.lotCode] = lot;
      return lot;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Impossible de contacter le serveur. (Code ${response.statusCode})');
    }
  }

  @override
  Future<void> addScannedLot(Lot lot) async {
    if (!_scannedLotCodes.contains(lot.lotCode)) {
      _scannedLotCodes.insert(0, lot.lotCode);
    }
    _cachedLots[lot.lotCode] = lot;
  }

  @override
  Future<List<Lot>> getAllAvailableMockLots() async {
    // Not applicable for API, return cached or empty
    return _cachedLots.values.toList();
  }
}
