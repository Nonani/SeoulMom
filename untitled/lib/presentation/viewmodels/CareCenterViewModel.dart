import 'package:flutter/cupertino.dart';
import 'package:untitled/domain/usecases/GetCareCenterUseCase.dart';

import '../../domain/entities/CareCenter.dart';

class CareCenterViewModel extends ChangeNotifier{
  final GetCareCenterListUseCase getCareCenterUseCase;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<CareCenter> _careCenterList = [];
  List<CareCenter> get careCenterList => _careCenterList;
  CareCenterViewModel(this.getCareCenterUseCase);

  Future<bool> loadCareCenterList() async {
    _isLoading = true;
    notifyListeners();
    _careCenterList = await getCareCenterUseCase();
    _isLoading = false;
    notifyListeners();
    return true;
  }
}