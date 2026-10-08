import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/lot_service.dart';
import '../../core/constants/app_colors.dart';
import '../lot_detail/lot_detail_screen.dart';

class QrScannerScreen extends StatefulWidget {
  final LotService lotService;

  const QrScannerScreen({super.key, required this.lotService});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  final TextEditingController _manualInputController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _scannerController.dispose();
    _manualInputController.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? rawValue = barcode.rawValue;
      if (rawValue != null && rawValue.isNotEmpty) {
        _isProcessing = true;
        _processLotCode(rawValue);
        break;
      }
    }
  }

  void _processLotCode(String rawCode) async {
    // Extract lot code if full URL was scanned e.g. https://zitounet.tn/suivi/ZT-2026-001258
    String cleanCode = rawCode.trim();
    if (cleanCode.contains('/suivi/')) {
      cleanCode = cleanCode.split('/suivi/').last;
    }

    if (!cleanCode.startsWith('ZT-')) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Code ZitouNet invalide.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isProcessing = false;
      });
      return;
    }

    try {
      final lot = await widget.lotService.searchLotByCode(cleanCode);

      if (!mounted) return;

      if (lot != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LotDetailScreen(lot: lot),
          ),
        ).then((_) {
          setState(() {
            _isProcessing = false;
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lot introuvable. Vérifiez le QR Code ou contactez l\'huilerie.'),
            backgroundColor: Colors.orange,
          ),
        );
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().contains('Impossible') 
            ? 'Impossible de contacter le serveur. Vérifiez votre connexion et réessayez.' 
            : 'Erreur serveur. Veuillez réessayer plus tard.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _onManualSubmit() {
    if (_manualInputController.text.trim().isNotEmpty) {
      _processLotCode(_manualInputController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner le QR Code'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _scannerController,
              builder: (context, state, child) {
                return Icon(
                  state.torchState == TorchState.on ? Icons.flash_on : Icons.flash_off,
                );
              },
            ),
            onPressed: () => _scannerController.toggleTorch(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Camera Viewport Section
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center, fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _scannerController,
                  onDetect: _handleBarcode,
                ),
                // Viewfinder Target Overlay
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.goldPrimary, width: 3),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldPrimary.withValues(alpha: 0.2),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 24,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Text(
                      'Pointez la caméra vers le QR Code du ticket',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Manual Entry Fallback Section
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saisie manuelle du code lot :',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _manualInputController,
                        decoration: InputDecoration(
                          hintText: 'ex: ZT-2026-001258',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.olivePrimary, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _onManualSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.olivePrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Valider', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
