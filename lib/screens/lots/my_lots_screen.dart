import 'package:flutter/material.dart';
import '../../services/lot_service.dart';
import '../../models/lot.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/lot_card_widget.dart';
import '../lot_detail/lot_detail_screen.dart';

class MyLotsScreen extends StatefulWidget {
  final LotService lotService;

  const MyLotsScreen({super.key, required this.lotService});

  @override
  State<MyLotsScreen> createState() => _MyLotsScreenState();
}

class _MyLotsScreenState extends State<MyLotsScreen> {
  List<Lot> _lots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLots();
  }

  Future<void> _fetchLots() async {
    final list = await widget.lotService.getMyScannedLots();
    if (mounted) {
      setState(() {
        _lots = list;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Lots d\'Olives'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lots.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('📜', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        const Text(
                          'Aucun lot dans votre historique',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Scannez le QR Code présent sur votre ticket d\'huilerie pour suivre la trituration de vos olives.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchLots,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _lots.length,
                    itemBuilder: (context, index) {
                      final lot = _lots[index];
                      return LotCardWidget(
                        lot: lot,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LotDetailScreen(lot: lot),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
