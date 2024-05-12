import 'package:budget_tracking_app/model/category_total_model.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [primary];

LineChartData mainData(List<CategoryTotalModel> model) {
  double i = 0;
  return LineChartData(
    lineTouchData: LineTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => white,
        tooltipBorder: BorderSide(style: BorderStyle.solid, color: red),
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((e) => LineTooltipItem(
                  model[e.x.toInt()].totalPrice.toString(),
                  TextStyle(color: red)))
              .toList();
        },
      ),
    ),
    gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 0.1,
          );
        }),
    titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 0:
                  return Image.asset(model.isNotEmpty
                      ? model[0].category
                      : "asset/auto.png"); // Mengambil kategori pertama dari Firebase
                case 1:
                  return Image.asset(model.isNotEmpty
                      ? model[1].category
                      : "asset/bank.png"); // Mengambil kategori kedua dari Firebase
                case 2:
                  return Image.asset(model.isNotEmpty
                      ? model[2].category
                      : "asset/cash.png"); // Mengambil kategori ketiga dari Firebase
                case 3:
                  return Image.asset(model.isNotEmpty
                      ? model[3].category
                      : "asset/charity.png"); // Mengambil kategori ketiga dari Firebase
                case 4:
                  return Image.asset(model.isNotEmpty
                      ? model[4].category
                      : "asset/eating.png"); // Mengambil kategori ketiga dari Firebase
                case 5:
                  return Image.asset(model.isNotEmpty
                      ? model[5].category
                      : "asset/gift.png"); // Mengambil kategori ketiga dari Firebase
              }
              return const Text("");
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              var style = const TextStyle(
                fontSize: 14,
                color: black,
              );
              String text;
              switch (value.toInt()) {
                case 0:
                  text = '50k';
                  break;
                case 1:
                  text = '100k';
                  break;
                case 2:
                  text = '250k';
                  break;
                case 3:
                  text = '500k';
                  break;
                case 4:
                  text = '1m';
                  break;
                case 5:
                  text = '2m';
                  break;
                case 6:
                  text = '5m';
                  break;
                default:
                  return Container();
              }
              return Text(text, style: style, textAlign: TextAlign.center);
            },
            reservedSize: 40,
          ),
        )),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 6,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: model.map((k) {
          i;

          double getTotal = 0;
          double harga = k.totalPrice;

          if (harga >= 0 && harga <= 100000) {
            getTotal = 0 + (harga / 100000);
          } else if (harga >= 100000 && harga <= 250000) {
            getTotal = 1 + (harga / 250000);
          } else if (harga > 250000 && harga <= 500000) {
            getTotal = 2 + (harga / 500000);
          } else if (harga > 500000 && harga <= 1000000) {
            getTotal = 3 + (harga / 1000000);
          } else if (harga > 1000000 && harga <= 2000000) {
            getTotal = 4 + (harga / 2000000);
          } else if (harga > 2000000 && harga <= 5000000) {
            getTotal = 5 + (harga / 5000000);
          }

          return FlSpot(i++, getTotal);
        }).toList(),
        isCurved: true,
        color: primary,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
      ),
    ],
  );
}
