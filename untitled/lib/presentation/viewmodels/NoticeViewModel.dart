import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/Notice.dart';
import '../../domain/usecases/GetNoticesUseCase.dart';

class NoticeViewModel extends ChangeNotifier {
  final GetNoticesUseCase getNoticesUseCase;
  Logger logger = Logger();
  List<Notice> _notices = [];
  bool _isLoading = false;
  List<Notice> get notices => _notices;
  bool get isLoading => _isLoading;


  NoticeViewModel(this.getNoticesUseCase);

  Future<bool> loadNotices(String category) async {
    logger.w('get notices start');
    _isLoading = true;
    notifyListeners();
    _notices = await getNoticesUseCase(category);
    for (var notice in _notices) {
      logger.i('notice: ${notice.title}');
    }
    _isLoading = false;
    notifyListeners();
    logger.w('get notices end');
    return true;
  }
}
