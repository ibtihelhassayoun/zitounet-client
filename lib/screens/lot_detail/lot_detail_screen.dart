import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/lot.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/status_badge_widget.dart';
import '../../widgets/process_timeline_widget.dart';
import '../../widgets/oil_results_widget.dart';

class LotDetailScreen extends StatelessWidget {
  final Lot lot;

  const LotDetailScreen({super.key, required this.lot});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy à HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: Text('Lot ${lot.lotCode}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lien de suivi : ZitouNet ${lot.lotCode}'),
                  backgroundColor: AppColors.olivePrimary,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Callout Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.oliveDeep, AppColors.olivePrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.olivePrimary.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lot.currentStatus.icon,
                        style: const TextStyle(fontSize: 28),
                      ),
                      StatusBadgeWidget(status: lot.currentStatus),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lot.currentStatus.clientMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Huilerie : ${lot.huilerieName} (${lot.huilerieLocation})',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFD1E2C4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Read-Only Lot Metadata Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations du Lot (Lecture Seule)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.olivePrimary,
                      ),
                    ),
                    const Divider(height: 20),
                    _buildMetaRow('Producteur', lot.clientName),
                    _buildMetaRow('Téléphone', lot.clientPhone),
                    _buildMetaRow('Poids Olives', '${lot.quantityKg.toInt()} kg', isBold: true),
                    _buildMetaRow('Variété', lot.variety),
                    _buildMetaRow('Origine', lot.origin),
                    _buildMetaRow('Date Réception', dateFormat.format(lot.receptionDate)),
                    if (lot.observations != null && lot.observations!.isNotEmpty)
                      _buildMetaRow('Observations', lot.observations!),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Oil Output Results if ready
            OilResultsWidget(lot: lot),

            const SizedBox(height: 16),

            // Process Timeline 7 Steps Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Progression du Traitement',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.olivePrimary,
                          ),
                        ),
                        Text(
                          'Étape ${lot.currentStatus.stepOrder}/7',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldDark,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    ProcessTimelineWidget(currentStatus: lot.currentStatus),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // History Log Card
            if (lot.statusHistory.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Historique des Changements de Statut',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.olivePrimary,
                        ),
                      ),
                      const Divider(height: 20),
                      ...lot.statusHistory.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.status.icon, style: const TextStyle(fontSize: 18)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.status.shortLabel,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                        Text(
                                          dateFormat.format(item.date),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (item.note != null)
                                      Text(
                                        item.note!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
                color: isBold ? AppColors.olivePrimary : AppColors.textDark,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
