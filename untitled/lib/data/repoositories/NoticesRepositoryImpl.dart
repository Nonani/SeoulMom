import '../../domain/entities/Notice.dart';
import '../../domain/repositories/NoticesRepository.dart';

class NoticesRepositoryImpl implements NoticesRepository {


  NoticesRepositoryImpl();

  @override
  Future<List<Notice>> getNoticesByCategory(String category) async {
// Fetch data from API and convert to List<Notice>
    return Future(() => List.generate(10, (index) => Notice(
      id: index,
      title: 'Notice $index',
      content: 'Content $index',
      detail_url: 'https://example.com',
      category: category,
      date: DateTime.now(),
    )));
    }
}
