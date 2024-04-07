class CareerNotice {
  final String? title;
  final String? center;
  final DateTime? applyOpen;
  final DateTime? applyClose;
  final DateTime? lectureOpen;
  final DateTime? lectureClose;
  final String? start;
  final String? end;
  final int? capacity;
  final int? reserve;
  final int? price;
  final String? detailUrl;
  final String? type;

  CareerNotice({
    this.title,
    this.center,
    this.applyOpen,
    this.applyClose,
    this.lectureOpen,
    this.lectureClose,
    this.start,
    this.end,
    this.capacity,
    this.reserve,
    this.price,
    this.detailUrl,
    this.type,
  });

  // JSON에서 CareerNotice 객체로 변환하는 팩토리 생성자
  factory CareerNotice.fromJson(Map<String, dynamic> json) {
    return CareerNotice(
      title: json['title'] as String?,
      center: json['center'] as String?,
      applyOpen: json['applyOpen'] != null ? DateTime.parse(json['applyOpen']) : null,
      applyClose: json['applyClose'] != null ? DateTime.parse(json['applyClose']) : null,
      lectureOpen: json['lectureOpen'] != null ? DateTime.parse(json['lectureOpen']) : null,
      lectureClose: json['lectureClose'] != null ? DateTime.parse(json['lectureClose']) : null,
      start: json['start'] as String?,
      end: json['end'] as String?,
      capacity: json['capacity'] as int?,
      reserve: json['reserve'] as int?,
      price: json['price'] as int?,
      detailUrl: json['detailUrl'] as String?,
      type: json['type'] as String?,
    );
  }

  // CareerNotice 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'center': center,
      'applyOpen': applyOpen?.toString(),
      'applyClose': applyClose?.toString(),
      'lectureOpen': lectureOpen?.toString(),
      'lectureClose': lectureClose?.toString(),
      'start': start,
      'end': end,
      'capacity': capacity,
      'reserve': reserve,
      'price': price,
      'detailUrl': detailUrl,
      'type': type,
    };
  }
}
