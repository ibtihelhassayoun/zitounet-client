import 'lot.dart';

class StatusHistory {
  final String id;
  final String lotId;
  final LotStatus status;
  final DateTime date;
  final String? note;
  final String? updatedBy;

  StatusHistory({
    required this.id,
    required this.lotId,
    required this.status,
    required this.date,
    this.note,
    this.updatedBy,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      id: json['id'] as String,
      lotId: json['lotId'] as String,
      status: LotStatus.fromBackend(json['status'] as String? ?? 'reception'),
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      updatedBy: json['updatedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotId': lotId,
      'status': status.backendValue,
      'date': date.toIso8601String(),
      'note': note,
      'updatedBy': updatedBy,
    };
  }
}
