import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../resources/AppColors.dart';

class BarChart1 extends StatefulWidget {
  BarChart1({super.key});

  final shadowColor = const Color(0xFFCCCCCC);
  final labelList = [
    '15-19세',
    '20-24세',
    '25-29세',
    '30-34세',
    '35-39세',
    '40-44세',
    '45-49세'
  ];
  final dataList = [
    const _BarData(AppColors.contentColorYellow, 0.2),
    const _BarData(AppColors.contentColorGreen, 1.4),
    const _BarData(AppColors.contentColorOrange, 9.9),
    const _BarData(AppColors.contentColorPink, 53.5),
    const _BarData(AppColors.contentColorBlue, 43.4),
    const _BarData(AppColors.contentColorRed, 8.7),
    const _BarData(AppColors.contentColorPurple, 0.2),
  ];

  @override
  State<BarChart1> createState() => _BarChart1State();
}

class _BarChart1State extends State<BarChart1> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 12,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Expanded(

          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              borderData: FlBorderData(
                show: true,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColors.borderColor.withOpacity(0.2),
                  ),
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  drawBelowEverything: true,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: _IconWidget(
                          color: widget.dataList[index].color,
                          isSelected: touchedGroupIndex == index,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColors.borderColor.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              barGroups: widget.dataList.asMap().entries.map((e) {
                final index = e.key;
                final data = e.value;
                return generateBarGroup(
                  index,
                  data.color,
                  data.value,
                );
              }).toList(),
              maxY: 54,
              barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: const EdgeInsets.all(0),
                  getTooltipColor: (group) => Colors.transparent,
                  tooltipMargin: 0,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      widget.labelList[group.x.toInt()] +
                          "\n"
                      +rod.toY.toString() + " 명",
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        color: rod.color,
                        fontSize: 12,
                        shadows: const [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 12,
                          )
                        ],
                      ),
                    );
                  },
                ),
                touchCallback: (event, response) {
                  if (event.isInterestedForInteractions &&
                      response != null &&
                      response.spot != null) {
                    setState(() {
                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                    });
                  } else {
                    setState(() {
                      touchedGroupIndex = -1;
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value);

  final Color color;
  final double value;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}
