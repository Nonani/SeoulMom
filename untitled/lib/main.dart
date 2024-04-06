import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:untitled/domain/usecases/GetNoticesUseCase.dart';
import 'package:untitled/presentation/viewmodels/CareCenterViewModel.dart';
import 'package:untitled/presentation/viewmodels/NoticeViewModel.dart';
import 'package:untitled/presentation/views/HomePage.dart';

import 'data/repoositories/CareCenterRepositoryImpl.dart';
import 'data/repoositories/NoticesRepositoryImpl.dart';
import 'domain/usecases/GetCareCenterUseCase.dart';

void main() async{
  await dotenv.load(fileName: "assets/env/.env");
  AuthRepository.initialize(appKey: dotenv.env['API_KEY'] ?? '');
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoticeViewModel(GetNoticesUseCase(NoticesRepositoryImpl()))),
      ChangeNotifierProvider(create: (_) => CareCenterViewModel(GetCareCenterListUseCase(CareCenterRepositoryImpl()))),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


