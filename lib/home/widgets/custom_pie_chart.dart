import 'package:cs_ui/cs_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({
    Key? key,
    required this.title,
    required this.labels,
    required this.data,
  }) : super(key: key);

  final String title;
  final List<Widget> labels;
  final List<PieChartSectionData> data;

  @override
  State<StatefulWidget> createState() => CustomPieChartState();
}

class CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: CsTextStyle.headline4.copyWith(),
                ),
              ),
              Expanded(
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
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    startDegreeOffset: 250,
                    sectionsSpace: 5,
                    centerSpaceRadius: 0,
                    sections: widget.data,
                    //showingSections(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.labels,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;

        const color0 = Color(0xff0293ee);
        const color1 = Color(0xfff8b250);
        const color2 = Color(0xff845bef);
        const color3 = Color(0xff13d38e);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 80,
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff044d7c),
              ),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color0.darken(), width: 6)
                  : BorderSide(color: color0.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 65,
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff90672d),
              ),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color1.darken(), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 60,
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff4c3788),
              ),
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(color: color2.darken(), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3.withOpacity(opacity),
              value: 25,
              title: '',
              radius: 70,
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff0c7f55),
              ),
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: color3.darken(), width: 6)
                  : BorderSide(color: color2.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = Colors.black,
  }) : super(key: key);

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }
}
