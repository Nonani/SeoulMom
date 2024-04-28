import 'package:flutter/material.dart';
import 'package:untitled/domain/entities/HealthNotice.dart';
import 'package:untitled/domain/usecases/GetHealthNoticeUseCase.dart';

class HomeViewModel extends ChangeNotifier{
  final GetHealthNoticeUseCase getHealthNoticeUseCase;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<HealthNotice> _healthNoticeList = [];
  List<HealthNotice> get healthNoticeList => _healthNoticeList;
  HomeViewModel(this.getHealthNoticeUseCase);

  Future<bool> loadHealthNoticeList() async {
    _isLoading = true;
    notifyListeners();
    _healthNoticeList = await getHealthNoticeUseCase();
    _isLoading = false;
    notifyListeners();
    return true;
  }
}