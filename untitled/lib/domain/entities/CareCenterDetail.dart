import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class CareCenterDetail {
  final LatLng location;
  final String open;
  final String close;
  final String open_sat;
  final String close_sat;
  final int price;
  final String detail_url;

  CareCenterDetail({
      required this.location,
      required this.open,
      required this.close,
      this.open_sat = '',
      this.close_sat = '',
      this.price = 0,
      this.detail_url = ''
  });

  factory CareCenterDetail.fromJson(Map<String, dynamic> json) =>
      CareCenterDetail(
        location: LatLng(
            json['coordinateY'] as double,
            json['coordinateX'] as double
        ),
        open: json['open'] as String,
        close: json['close'] as String,
        open_sat: json['openSat'] as String ?? '',
        close_sat: json['closeSat'] as String ?? '',
        price: json['price'] as int ?? 0,
        detail_url: json['detailUrl'] as String? ?? '',
      );

  @override
  String toString() => '''
  {
    location: $location,
    open: $open,
    close: $close,
    open_sat: $open_sat,
    close_sat: $close_sat,
    price: $price,
    detail_url: $detail_url,
  }
  ''';
}
