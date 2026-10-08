import 'package:flutter/material.dart';
import '../models/lot.dart';
import '../core/constants/app_colors.dart';

class OilResultsWidget extends StatelessWidget {
  final Lot lot;

  const OilResultsWidget({super.key, required this.lot});

  @override
  Widget build(BuildContext context) {
    if (lot.oilProducedLiters == null && lot.analysis == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('🛢️', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Résultats du Traitement',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepGreen,
                    ),
                  ),
                  Text(
                    'Données officielles fournies par l\'huilerie',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 4 Grid Stat boxes
          Row(
            children: [
              Expanded(
                child: _buildResultBox(
                  label: 'Huile Produite',
                  value: lot.oilProducedLiters != null ? '${lot.oilProducedLiters!.toInt()} L' : '-',
                  color: AppColors.olive,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildResultBox(
                  label: 'Rendement',
                  value: lot.extractionYield != null ? '${lot.extractionYield}%' : '-',
                  color: AppColors.deepGreen,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildResultBox(
                  label: 'Acidité',
                  value: lot.analysis?.acidityPercent != null ? '${lot.analysis!.acidityPercent}%' : '-',
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),

          if (lot.analysis?.qualityGrade != null || lot.analysis?.sensoryNote != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (lot.analysis?.qualityGrade != null)
                    Row(
                      children: [
                        const Text(
                          'Catégorie : ',
                          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.beige,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            lot.analysis!.qualityGrade!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (lot.analysis?.sensoryNote != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Remarques : ${lot.analysis!.sensoryNote}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultBox({required String label, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
