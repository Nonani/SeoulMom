import '../entities/HealthNotice.dart';
import '../repositories/HealthNoticeRepository.dart';

class GetHealthNoticeUseCase {
  final HealthNoticeRepository repository;

  GetHealthNoticeUseCase(this.repository);

  Future<List<HealthNotice>> call() async {
    return await repository.getHealthNoticeList();
  }
}