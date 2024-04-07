import 'package:untitled/domain/entities/HealthNotice.dart';

abstract class HealthNoticeRepository{
  Future<List<HealthNotice>> getHealthNoticeList();
}