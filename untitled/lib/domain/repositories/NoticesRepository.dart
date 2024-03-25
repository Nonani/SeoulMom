import '../entities/Notice.dart';

abstract class NoticesRepository {
Future<List<Notice>> getNoticesByCategory(String category);
}

