import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled/domain/entities/HealthNotice.dart';
import 'package:untitled/presentation/views/CareCenterPage.dart';
import 'package:untitled/presentation/views/CareerNoticePage.dart';
import 'package:untitled/presentation/views/HealthNoticeDetailPage.dart';
import 'package:untitled/presentation/views/components/PieChart1.dart';

import '../viewmodels/HomeViewModel.dart';
import 'NoticePage.dart';
import 'components/BarChart1.dart';
import 'components/PieChart2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel viewModel;
  final categoryName = ["탄생응원", "건강힐링", "안심돌봄", "일생활균형", "편한외출", "돌봄센터", "커리어"];
  List<Icon> categoryIcon = [
    Icon(
      Icons.spa,
      size: 40,
    ),
    Icon(
      Icons.health_and_safety,
      size: 40,
    ),
    Icon(
      Icons.child_friendly,
      size: 40,
    ),
    Icon(
      Icons.maps_home_work,
      size: 40,
    ),
    Icon(
      Icons.deck,
      size: 40,
    ),
    Icon(
      Icons.child_care,
      size: 40,
    ),
    Icon(
      Icons.badge,
      size: 40,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<HomeViewModel>(context, listen: false);
      viewModel.loadHealthNoticeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        title: Icon(Icons.home),
      ),
      body: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, top: 10),
                child: const Text(
                  "서울맘",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [makeCard1(), makeCard2(), makeCard3()],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < categoryIcon.length; i++)
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          switch (categoryName[i]) {
                            case "돌봄센터":
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CareCenterPage(
                                          categoryName: categoryName[i],
                                          icon: categoryIcon[i])));
                              break;
                            case "커리어":
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CareerNoticePage(
                                          categoryName: categoryName[i],
                                          icon: categoryIcon[i])));
                              break;
                            default:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoticePage(
                                          categoryName: categoryName[i],
                                          icon: categoryIcon[i])
                                  )
                              );
                          }
                        },
                        child: Ink(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  categoryIcon[i],
                                  FittedBox(
                                      child: Text(categoryName[i],
                                          style: TextStyle(fontSize: 13))),
                                ],
                              ),
                            )),
                      ),
                    )
                ],
              ),
            ),
          ]),
          Flexible(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("  임산부 건강정보",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ))
                ),
                Container(
                    child: viewModel.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewModel.healthNoticeList.length,
                        itemBuilder: (BuildContext context, int idx) {
                          HealthNotice healthNotice =
                          viewModel.healthNoticeList[idx];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => HealthNoticeDetailPage(
                                          sequence: viewModel.healthNoticeList[idx].detail_url
                                      )
                                  )
                              );
                            },
                              child:Container(
                              margin: EdgeInsets.only(left: 10, right : 10, bottom: 10),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black26,
                                      width: 4
                                  )
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    healthNotice.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )));
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget makeCard1() {
  return Card(
    child: Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "임신과 출산 관련 사업 들어보셨나요?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("서울시 시민 대상 통계"),
          Expanded(
            child: PieChart1(),
          )
        ],
      ),
    ),
  );
}

Widget makeCard2() {
  return Card(
    child: Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "서울시의 출산율은 어떤가요?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text("서울시 연령별 천 명당 신생아 수"),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: BarChart1()),
          )
        ],
      ),
    ),
  );
}

Widget makeCard3() {
  return Card(
    child: Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "서울시 제왕절개분만 현황은?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("서울시 시민 대상 통계"),
          Expanded(
            child: PieChart2(),
          )
        ],
      ),
    ),
  );
}
