import 'package:flutter/material.dart';
import '../../services/lot_service.dart';
import '../../models/lot.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/lot_card_widget.dart';
import '../lot_detail/lot_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final LotService lotService;
  final VoidCallback onOpenScanner;

  const HomeScreen({
    super.key,
    required this.lotService,
    required this.onOpenScanner,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Lot> _myLots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final lots = await widget.lotService.getMyScannedLots();
    if (mounted) {
      setState(() {
        _myLots = lots;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Welcome Banner Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.deepGreen, AppColors.deepGreen2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.oliveLight.withValues(alpha: 0.5)),
                    ),
                    child: const Text(
                      '🇹🇳 Plateforme Oléicole Nationale',
                      style: TextStyle(
                        color: AppColors.beige,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Bienvenue sur ZitouNet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Suivez facilement le traitement de vos olives dans votre huilerie.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.beige,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Main Scan Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: widget.onOpenScanner,
                      icon: const Icon(Icons.qr_code_scanner, size: 22),
                      label: const Text(
                        'Scanner un QR Code',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.olive,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section: Recent Scanned Lots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mes derniers lots',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.oliveDeep,
                        ),
                      ),
                      Text(
                        '${_myLots.length} lot(s)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_myLots.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(24),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Column(
                        children: [
                          Text('📦', style: TextStyle(fontSize: 32)),
                          SizedBox(height: 8),
                          Text(
                            'Aucun lot scanné pour l\'instant',
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Scannez le QR Code de votre ticket de pesée pour ajouter votre lot.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: _myLots.map((lot) {
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
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
