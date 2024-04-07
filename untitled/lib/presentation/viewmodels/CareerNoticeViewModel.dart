import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:untitled/domain/usecases/GetCareerNoticesUseCase.dart';

import '../../domain/entities/CareerNotice.dart';
import '../../domain/usecases/GetNoticesUseCase.dart';

class CareerNoticeViewModel extends ChangeNotifier {
  final GetCareerNoticesUseCase getCareerNoticesUseCase;
  Logger logger = Logger();
  List<CareerNotice> _notices = [];
  bool _isLoading = false;
  List<CareerNotice> get notices => _notices;
  bool get isLoading => _isLoading;


  CareerNoticeViewModel(this.getCareerNoticesUseCase);

  Future<bool> loadNotices() async {
    logger.w('get notices start');
    _isLoading = true;
    notifyListeners();
    _notices = await getCareerNoticesUseCase();
    for (var notice in _notices) {
      logger.i('notice: ${notice.title}');
    }
    _isLoading = false;
    notifyListeners();
    logger.w('get notices end');
    return true;
  }
}
