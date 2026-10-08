class QualityAnalysis {
  final double? acidityPercent;
  final double? peroxideValue;
  final String? qualityGrade;
  final String? sensoryNote;
  final DateTime? analyzedAt;

  QualityAnalysis({
    this.acidityPercent,
    this.peroxideValue,
    this.qualityGrade,
    this.sensoryNote,
    this.analyzedAt,
  });

  factory QualityAnalysis.fromJson(Map<String, dynamic> json) {
    return QualityAnalysis(
      acidityPercent: (json['acidityPercent'] as num?)?.toDouble(),
      peroxideValue: (json['peroxideValue'] as num?)?.toDouble(),
      qualityGrade: json['qualityGrade'] as String?,
      sensoryNote: json['sensoryNote'] as String?,
      analyzedAt: json['analyzedAt'] != null
          ? DateTime.parse(json['analyzedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acidityPercent': acidityPercent,
      'peroxideValue': peroxideValue,
      'qualityGrade': qualityGrade,
      'sensoryNote': sensoryNote,
      'analyzedAt': analyzedAt?.toIso8601String(),
    };
  }
}
