import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Informations'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // App Branding Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('🫒', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 8),
                    const Text(
                      'ZitouNet Client',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.olivePrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Application Mobile Producteur 🇹🇳',
                      style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.statusCurrentBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFCD34D)),
                      ),
                      child: const Text(
                        'Accès Producteur (Lecture Seule)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // How it works info list
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'À propos de ZitouNet',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.olivePrimary,
                      ),
                    ),
                    const Divider(height: 20),
                    _buildInfoTile(
                      icon: Icons.qr_code_scanner,
                      title: 'Scannez votre ticket',
                      subtitle: 'Chaque lot possède un QR Code unique délivré à la pesée.',
                    ),
                    _buildInfoTile(
                      icon: Icons.timeline,
                      title: 'Suivi des 7 étapes',
                      subtitle: 'Réception, Pesée, Attente, Trituration, Extraction, Analyse, Huile disponible.',
                    ),
                    _buildInfoTile(
                      icon: Icons.opacity,
                      title: 'Bilan d\'extraction',
                      subtitle: 'Consultez votre volume final d\'huile (L), le rendement % et l\'acidité.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // App Version Footer
            const Text(
              'ZitouNet Mobile v1.0.0 • Plateforme Numérique Oléicole',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.olivePrimary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
