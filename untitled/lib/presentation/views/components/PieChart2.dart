import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class PieChart2 extends StatefulWidget {
  const PieChart2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(

          flex: 2,
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
         Expanded(
           flex: 1,
           child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.contentColorBlue,
                text: '자연분만',
                size: touchedIndex == 0 ? 16 : 12,
                fontSize: touchedIndex == 0 ? 14 : 12,
                isSquare: true,
              ),

              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorYellow,
                text: '제왕절개',
                size: touchedIndex == 1 ? 16 : 12,
                fontSize: touchedIndex == 1 ? 14 : 12,
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
                   ),
         ),

      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: 38,
            title: '38%',
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
            value: 61,
            title: '61%',
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