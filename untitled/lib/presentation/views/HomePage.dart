import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/domain/entities/CareCenter.dart';
import 'package:untitled/presentation/views/CareCenterPage.dart';
import 'package:untitled/presentation/views/components/PieChart1.dart';

import 'NoticePage.dart';
import 'components/BarChartSample7.dart';
import 'components/PieChart2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categoryName = [
    "탄생응원",
    "임산부",
    "건강힐링",
    "안심돌봄",
    "일생활 균형",
    "편한외출",
    "돌봄센터",
    "커리어"
  ];
  List<Icon> categoryIcon = [
    Icon(
      Icons.spa,
      size: 40,
    ),
    Icon(
      Icons.pregnant_woman,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        title: Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              )
            ],
          ),
          const SizedBox(height: 20),
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

                            break;
                          default:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoticePage(
                                        categoryName: categoryName[i],
                                        icon: categoryIcon[i])));
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
          const SizedBox(height: 20),
          Text("최근 게시글"),
        ]),
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
            child: PieChartSample2(),
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
            child: BarChartSample7(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "서울시 제왕절개분만 현황은?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("서울시 시민 대상 통계"),
          Expanded(
            child: PieChartSample2(),
          )
        ],
      ),
    ),
  );
}
