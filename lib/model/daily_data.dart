class DailyData {
  final String date;
  final double averageStress;
  final List<String> emotions;
  final int diaryCount;

  DailyData({
    required this.date,
    required this.averageStress,
    required this.emotions,
    required this.diaryCount,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      date: json['date'],
      averageStress: (json['average_stress'] as num).toDouble(),
      emotions: List<String>.from(json['emotions']),
      diaryCount: json['diary_count'],
    );
  }

  @override
  String toString() {
    return 'DailyData(date: $date, averageStress: $averageStress, emotions: $emotions, diaryCount: $diaryCount)';
  }
}
