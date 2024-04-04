import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../resources/AppColors.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 8,
    this.fontSize = 8,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final double fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: 100,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        )
      ],
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(

                pieTouchData: PieTouchData(

                  touchCallback: (FlTouchEvent event, pieTouchResponse) {

                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {


                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse
                          .touchedSection!.touchedSectionIndex;
                      print('touchedIndex: $touchedIndex');
                    });

                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),

                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(),
              ),
            ),
          ),
        ),
         Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Indicator(
              color: AppColors.contentColorBlue,
              text: '모름',
              size: touchedIndex == 0 ? 16 : 12,
              fontSize: touchedIndex == 0 ? 10 : 8,
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: AppColors.contentColorYellow,
              text: '들어는 보았지만 내용은 모름',
              size: touchedIndex == 1 ? 16 : 12,
              fontSize: touchedIndex == 1 ? 10 : 8,
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: AppColors.contentColorPurple,
              text: '내용을 어느정도 알고있음',
              size: touchedIndex == 2 ? 16 : 12,
              fontSize: touchedIndex == 2 ? 10 : 8,
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: AppColors.contentColorGreen,
              text: '비교적 자세히 알고있음',
              isSquare: true,
              size: touchedIndex == 3 ? 16 : 12,
              fontSize: touchedIndex == 3 ? 10 : 8,
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: 40,
            title: '40%',
            radius: radius,
            titlePositionPercentageOffset: 0.5,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: 30,
            title: '30%',
            radius: radius,
            titlePositionPercentageOffset: 0.5,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titlePositionPercentageOffset: 0.5,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titlePositionPercentageOffset: 0.5,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}