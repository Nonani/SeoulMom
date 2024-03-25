import '../entities/Notice.dart';
import '../repositories/NoticesRepository.dart';

class GetNoticesUseCase {
  final NoticesRepository repository;

  GetNoticesUseCase(this.repository);

  Future<List<Notice>> call(String category) async {
    return await repository.getNoticesByCategory(category);
  }
}
