import 'CareCenterDetail.dart';

class CareCenter {
  final String name;
  final CareCenterDetail care_center_detail;

  CareCenter({required this.name, required this.care_center_detail});

  factory CareCenter.fromJson(Map<String, dynamic> json) => CareCenter(
        name: json['name'] as String,
        care_center_detail:
            CareCenterDetail.fromJson(json['careCenterDetailInfoDto']),
      );

  @override
  String toString() => '''
  CareCenter{
    title: $name,
    care_center_detail: ${care_center_detail.toString()}
  }
  ''';
}
