import 'package:flutter/material.dart';
import '../models/lot.dart';
import '../core/constants/app_colors.dart';

class ProcessTimelineWidget extends StatelessWidget {
  final LotStatus currentStatus;

  const ProcessTimelineWidget({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    final currentOrder = currentStatus.stepOrder;

    return Column(
      children: LotStatus.values.map((status) {
        final stepOrder = status.stepOrder;
        final isCompleted = stepOrder < currentOrder;
        final isCurrent = stepOrder == currentOrder;
        final isLast = stepOrder == LotStatus.values.length;

        String symbol = '○';
        String tagText = 'à venir';
        Color nodeBorder = const Color(0xFFCBD5E1);
        Color textColor = AppColors.textMuted;

        if (isCompleted) {
          symbol = '✓';
          tagText = 'terminée';
          nodeBorder = AppColors.olivePrimary;
          textColor = AppColors.textDark;
        } else if (isCurrent) {
          symbol = '●';
          tagText = 'en cours';
          nodeBorder = AppColors.oliveDeep;
          textColor = AppColors.oliveDeep;
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Connector Node
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.olivePrimary
                            : isCurrent
                                ? AppColors.goldPrimary
                                : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: nodeBorder,
                          width: isCurrent ? 3 : 2,
                        ),
                        boxShadow: isCurrent
                            ? [
                                BoxShadow(
                                  color: AppColors.goldPrimary.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                )
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          symbol,
                          style: TextStyle(
                            color: isCompleted
                                ? Colors.white
                                : isCurrent
                                    ? AppColors.oliveDeep
                                    : const Color(0xFF94A3B8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 3,
                          color: isCompleted ? AppColors.olivePrimary : const Color(0xFFE2E8F0),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Right Step Title & Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            status.icon,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              status.label,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                                color: isCurrent ? AppColors.olivePrimary : textColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? const Color(0xFFE8F5E9)
                                  : isCurrent
                                      ? const Color(0xFFFEF3C7)
                                      : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tagText,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isCompleted
                                    ? const Color(0xFF2E7D32)
                                    : isCurrent
                                        ? const Color(0xFF92400E)
                                        : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isCurrent)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            status.clientMessage,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.oliveLeaf,
                              height: 1.3,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
