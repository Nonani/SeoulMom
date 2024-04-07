import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

import '../../domain/entities/HealthNotice.dart';
import '../../domain/repositories/HealthNoticeRepository.dart';
class HealthNoticeRepositoryImpl implements HealthNoticeRepository {
  HealthNoticeRepositoryImpl();

  @override
  Future<List<HealthNotice>> getHealthNoticeList() async {
    const url = 'http://18.218.253.250:8080/health_info';
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));
    var logger = Logger();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))["supportInfoDtoList"];
      List<HealthNotice> healthNoticeList= body.map((dynamic item) => HealthNotice.fromJson(item)).toList();
      logger.w(healthNoticeList);
      return healthNoticeList;
    } else {
      throw Exception('Failed to load careCenter');
    }
  }
}
