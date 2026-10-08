import 'status_history.dart';
import 'quality_analysis.dart';

enum LotStatus {
  reception,
  weighing,
  waiting,
  crushing,
  extraction,
  analysis,
  ready;

  String get backendValue {
    switch (this) {
      case LotStatus.reception: return 'reception';
      case LotStatus.weighing: return 'pesee';
      case LotStatus.waiting: return 'attente';
      case LotStatus.crushing: return 'trituration';
      case LotStatus.extraction: return 'extraction';
      case LotStatus.analysis: return 'analyse';
      case LotStatus.ready: return 'huileDisponible';
    }
  }

  static LotStatus fromBackend(String value) {
    return LotStatus.values.firstWhere(
      (e) => e.backendValue.toLowerCase() == value.toLowerCase(),
      orElse: () => LotStatus.reception,
    );
  }

  int get stepOrder {
    switch (this) {
      case LotStatus.reception: return 1;
      case LotStatus.weighing: return 2;
      case LotStatus.waiting: return 3;
      case LotStatus.crushing: return 4;
      case LotStatus.extraction: return 5;
      case LotStatus.analysis: return 6;
      case LotStatus.ready: return 7;
    }
  }

  String get label {
    switch (this) {
      case LotStatus.reception: return 'Olives Réceptionnées';
      case LotStatus.weighing: return 'Pesée Effectuée';
      case LotStatus.waiting: return 'En Attente de Transformation';
      case LotStatus.crushing: return 'Trituration & Broyage';
      case LotStatus.extraction: return 'Extraction de l\'Huile';
      case LotStatus.analysis: return 'Analyse Qualité';
      case LotStatus.ready: return 'Huile Disponible';
    }
  }

  String get shortLabel {
    switch (this) {
      case LotStatus.reception: return 'Réception';
      case LotStatus.weighing: return 'Pesée';
      case LotStatus.waiting: return 'En attente';
      case LotStatus.crushing: return 'Trituration';
      case LotStatus.extraction: return 'Extraction';
      case LotStatus.analysis: return 'Analyse';
      case LotStatus.ready: return 'Disponible';
    }
  }

  String get icon {
    switch (this) {
      case LotStatus.reception: return '📥';
      case LotStatus.weighing: return '⚖️';
      case LotStatus.waiting: return '⏳';
      case LotStatus.crushing: return '⚙️';
      case LotStatus.extraction: return '🛢️';
      case LotStatus.analysis: return '🧪';
      case LotStatus.ready: return '✨';
    }
  }

  String get clientMessage {
    switch (this) {
      case LotStatus.reception:
        return 'Votre lot a été réceptionné avec succès et enregistré à l\'huilerie.';
      case LotStatus.weighing:
        return 'Votre lot a été pesé avec précision et validé sur pont bascule.';
      case LotStatus.waiting:
        return 'Votre lot est actuellement en attente dans la file de transformation.';
      case LotStatus.crushing:
        return 'Votre lot est actuellement en cours de trituration et malaxage.';
      case LotStatus.extraction:
        return 'L\'extraction de votre huile d\'olive est en cours de séparation centrifuge.';
      case LotStatus.analysis:
        return 'Votre huile d\'olive est en laboratoire pour contrôle de qualité et acidité.';
      case LotStatus.ready:
        return 'Votre huile d\'olive est prête ! Vous pouvez venir la récupérer à l\'huilerie.';
    }
  }
}

class Lot {
  final String id;
  final String lotCode;
  final String clientName;
  final String clientPhone;
  final double quantityKg;
  final String variety;
  final String origin;
  final DateTime receptionDate;
  final LotStatus currentStatus;
  final String huilerieName;
  final String huilerieLocation;
  final String? observations;
  final double? oilProducedLiters;
  final double? extractionYield;
  final QualityAnalysis? analysis;
  final List<StatusHistory> statusHistory;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lot({
    required this.id,
    required this.lotCode,
    required this.clientName,
    required this.clientPhone,
    required this.quantityKg,
    required this.variety,
    required this.origin,
    required this.receptionDate,
    required this.currentStatus,
    required this.huilerieName,
    required this.huilerieLocation,
    this.observations,
    this.oilProducedLiters,
    this.extractionYield,
    this.analysis,
    required this.statusHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lot.fromJson(Map<String, dynamic> json) {
    return Lot(
      id: json['id'] as String,
      lotCode: json['lotCode'] as String,
      clientName: json['clientName'] as String,
      clientPhone: json['clientPhone'] as String,
      quantityKg: (json['quantityKg'] as num).toDouble(),
      variety: json['variety'] as String,
      origin: json['origin'] as String,
      receptionDate: DateTime.parse(json['receptionDate'] as String),
      currentStatus: LotStatus.fromBackend(json['currentStatus'] as String? ?? 'reception'),
      huilerieName: json['huilerieName'] as String? ?? 'Huilerie El Baraka',
      huilerieLocation: json['huilerieLocation'] as String? ?? 'Sousse - Sahel',
      observations: json['observations'] as String?,
      oilProducedLiters: (json['oilProducedLiters'] as num?)?.toDouble(),
      extractionYield: (json['extractionYield'] as num?)?.toDouble(),
      analysis: json['analysis'] != null
          ? QualityAnalysis.fromJson(json['analysis'] as Map<String, dynamic>)
          : null,
      statusHistory: (json['statusHistory'] as List<dynamic>?)
              ?.map((e) => StatusHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotCode': lotCode,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'quantityKg': quantityKg,
      'variety': variety,
      'origin': origin,
      'receptionDate': receptionDate.toIso8601String(),
      'currentStatus': currentStatus.backendValue,
      'huilerieName': huilerieName,
      'huilerieLocation': huilerieLocation,
      'observations': observations,
      'oilProducedLiters': oilProducedLiters,
      'extractionYield': extractionYield,
      'analysis': analysis?.toJson(),
      'statusHistory': statusHistory.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
