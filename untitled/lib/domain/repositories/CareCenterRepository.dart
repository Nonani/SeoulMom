import 'package:untitled/domain/entities/CareCenter.dart';

abstract class CareCenterRepository{
  Future<List<CareCenter>> getCareCenterList();
}