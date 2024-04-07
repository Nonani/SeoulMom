import 'package:logger/logger.dart';
import 'package:untitled/domain/entities/CareerNotice.dart';
import 'package:untitled/domain/repositories/CareerNoticesRepository.dart';

import '../../domain/entities/Notice.dart';
import '../../domain/repositories/NoticesRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CareerNoticesRepositoryImpl implements CareerNoticesRepository {
  CareerNoticesRepositoryImpl();

  @override
  Future<List<CareerNotice>> getCareerNotices() async{
    // TODO: implement getCareerNotices
    Logger logger = Logger();
    final url =  'http://18.218.253.250:8080/career_info';
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));

    // Check the status code before decoding the response
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      logger.w(jsonDecode(utf8.decode(response.bodyBytes)));

      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))["careerInfoDtoList"];
      List<CareerNotice> notices = body.map((dynamic item) => CareerNotice.fromJson(item)).toList();
      return notices;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load notices');
    }

  }

}
