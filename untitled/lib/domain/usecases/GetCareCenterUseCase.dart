import 'package:untitled/domain/entities/CareCenter.dart';
import '../repositories/CareCenterRepository.dart';

class GetCareCenterListUseCase {
  final CareCenterRepository repository;

  GetCareCenterListUseCase(this.repository);

  Future<List<CareCenter>> call() async {
    return await repository.getCareCenterList();
  }
}
