import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/lot.dart';
import '../core/constants/app_colors.dart';
import 'status_badge_widget.dart';

class LotCardWidget extends StatelessWidget {
  final Lot lot;
  final VoidCallback onTap;

  const LotCardWidget({
    super.key,
    required this.lot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy à HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Lot Code & Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('🫒 ', style: TextStyle(fontSize: 18)),
                      Text(
                        lot.lotCode,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.olivePrimary,
                        ),
                      ),
                    ],
                  ),
                  StatusBadgeWidget(status: lot.currentStatus),
                ],
              ),
              const Divider(height: 20, color: Color(0xFFF1F5F9)),

              // Middle Row: Variety & Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${lot.variety} · ${lot.origin}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Producteur : ${lot.clientName}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.oliveLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${lot.quantityKg.toInt()} kg',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.olivePrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Bottom Info: Date & Action hint
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(lot.receptionDate),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Voir détails ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.olivePrimary,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.olivePrimary),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
