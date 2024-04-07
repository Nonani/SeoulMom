import 'package:untitled/domain/entities/CareerNotice.dart';


abstract class CareerNoticesRepository {
Future<List<CareerNotice>> getCareerNotices();
}

