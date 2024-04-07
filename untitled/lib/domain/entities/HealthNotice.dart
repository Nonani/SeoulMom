class HealthNotice {
  final String title;
  final String date;
  final String detail_url;

  HealthNotice({
    required this.title,
    required this.date,
    required this.detail_url
  });

  factory HealthNotice.fromJson(Map<String, dynamic> json) => HealthNotice(
    title: json['title'] as String,
    date : json['date'] as String,
    detail_url: json['detailUrl'] as String? ?? ''
  );

  @override
  String toString() => '''
  Notice{
    title: $title,
    date: $date,
    detail_url: $detail_url,
  }
  ''';
}
