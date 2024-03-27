import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/domain/usecases/GetNoticesUseCase.dart';
import 'package:untitled/presentation/viewmodels/NoticeViewModel.dart';
import 'package:untitled/presentation/views/HomePage.dart';

import 'data/repoositories/NoticesRepositoryImpl.dart';

void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoticeViewModel(GetNoticesUseCase(NoticesRepositoryImpl()))),
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


