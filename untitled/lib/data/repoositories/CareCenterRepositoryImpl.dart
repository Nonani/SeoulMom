import 'package:untitled/domain/entities/CareCenter.dart';
import '../../domain/repositories/CareCenterRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CareCenterRepositoryImpl implements CareCenterRepository {
  CareCenterRepositoryImpl();

  @override
  Future<List<CareCenter>> getCareCenterList() async {
    const url = 'http://18.218.253.250:8080/care_center_info';
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))["careCenterInfoDtoList"];
      List<CareCenter> careCenterList= body.map((dynamic item) => CareCenter.fromJson(item)).toList();

      return careCenterList;
    } else {
      throw Exception('Failed to load careCenter');
    }
  }
}
