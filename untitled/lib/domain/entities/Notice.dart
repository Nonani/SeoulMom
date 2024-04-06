class Notice {
  final String title;
  final String content;
  final String detail_url;
  final String type;

  Notice({
    required this.title,
    required this.content,
    this.detail_url = '',
    required this.type,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        title: json['title'] as String,
        content: json['content'] as String,
        detail_url: json['detail_url'] as String? ?? '',
        type: json['type'] as String? ?? '',
      );

  @override
  String toString() => '''
  Notice{
    title: $title,
    content: $content,
    detail_url: $detail_url,
    type: $type,
  }
  ''';
}
