import 'package:logger/logger.dart';

import '../../domain/entities/Notice.dart';
import '../../domain/repositories/NoticesRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class NoticesRepositoryImpl implements NoticesRepository {
  NoticesRepositoryImpl();

  @override
  Future<List<Notice>> getNoticesByCategory(String category) async {
// Fetch data from API and convert to List<Notice>
//     final testSet = [
//       {
//         "cid": "1234",
//         "title": "공지 제목 1",
//         "date": "2024-03-31T13:15:00.000Z",
//         "content": "공지 내용 1",
//         "detailUrl": "https://example.com/notice/1234",
//         "category": "공지1"
//       },
//       {
//         "cid": "5678",
//         "title": "공지 제목 2",
//         "date": "2024-03-30T12:00:00.000Z",
//         "content": "공지 내용 2",
//         "detailUrl": "https://example.com/notice/5678",
//         "category": "공지1"
//       },
//       {
//         "cid": "9012",
//         "title": "공지 제목 3",
//         "date": "2024-03-29T11:00:00.000Z",
//         "content": "공지 내용 3",
//         "detailUrl": "https://example.com/notice/9012",
//         "category": "공지1"
//       }
//     ];
    // Define the URL
    // /career_info : 커리어
    // /health_info : 임산부
    // /care_center_info : 돌봄 센터
    // final categoryName = [
    //   "탄생응원",
    //   "임산부",
    //   "건강힐링",
    //   "안심돌봄",
    //   "일생활 균형",
    //   "편한외출",
    //   "돌봄센터",
    //   "커리어"
    // ];
    Logger logger = Logger();
    final url = 'http://175.197.122.34:8080/support_info?type=$category';
    // Make the HTTP request
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));

    // Check the status code before decoding the response
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      logger.w(jsonDecode(utf8.decode(response.bodyBytes)));

      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))["supportInfoDtoList"];


      // Map the response to List<Notice>
      List<Notice> notices = body.map((dynamic item) => Notice.fromJson(item)).toList();

      return notices;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load notices');
    }
  }
}
