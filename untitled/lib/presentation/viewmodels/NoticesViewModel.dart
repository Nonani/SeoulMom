import 'package:flutter/cupertino.dart';

import '../../domain/entities/Notice.dart';
import '../../domain/usecases/GetNoticesUseCase.dart';

class NoticesViewModel extends ChangeNotifier {
  final GetNoticesUseCase getNoticesUseCase;

  List<Notice> _notices = [];

  List<Notice> get notices => _notices;

  NoticesViewModel(this.getNoticesUseCase);

  Future<void> loadNotices(String category) async {
    _notices = await getNoticesUseCase(category);
    notifyListeners();
  }
}
