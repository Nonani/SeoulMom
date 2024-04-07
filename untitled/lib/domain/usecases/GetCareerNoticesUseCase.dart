import 'package:untitled/domain/entities/CareerNotice.dart';
import 'package:untitled/domain/repositories/CareerNoticesRepository.dart';

class GetCareerNoticesUseCase {
  final CareerNoticesRepository repository;

  GetCareerNoticesUseCase(this.repository);

  Future<List<CareerNotice>> call() async {
    return await repository.getCareerNotices();
  }
}
