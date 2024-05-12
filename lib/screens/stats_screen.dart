import 'package:budget_tracking_app/model/category_total_model.dart';
import 'package:budget_tracking_app/model/daily_model.dart';
import 'package:budget_tracking_app/model/day_month.dart';
import 'package:budget_tracking_app/screens/chart.dart';
import 'package:budget_tracking_app/services/firebase.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class StatsScreens extends StatefulWidget {
  const StatsScreens({super.key});

  @override
  _StatsScreensState createState() => _StatsScreensState();
}

class _StatsScreensState extends State<StatsScreens> {
  int activeDay = 0;
  bool showAvg = false;

  List<CategoryTotalModel> categoryTotal = [];
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    categoryTotal = await FirebaseService.getTotalPriceByCategory();
    print("GET LIST Total ${categoryTotal.toString()}}");
    totalPrice =
        categoryTotal.fold(0, (prev, element) => prev + (element.totalPrice));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grafik Pengeluaran",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: size.height * 0.45,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Pengeluaran",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(totalPrice),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: (size.width - 20),
                          height: size.height * 0.30,
                          child: LineChart(
                            mainData(categoryTotal),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Wrap(
          //   spacing: 20,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => const IncomeScreen()));
          //       },
          //       child: Container(
          //         width: (size.width - 60) / 2,
          //         height: size.height * 0.21,
          //         decoration: BoxDecoration(
          //             color: white,
          //             borderRadius: BorderRadius.circular(12),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: grey.withOpacity(0.01),
          //                 spreadRadius: 10,
          //                 blurRadius: 3,
          //                 // changes position of shadow
          //               ),
          //             ]),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               left: 25, right: 25, top: 20, bottom: 20),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Container(
          //                 width: 40,
          //                 height: 40,
          //                 decoration: const BoxDecoration(
          //                     shape: BoxShape.circle, color: blue),
          //                 child: const Center(
          //                     child: Icon(
          //                   Icons.arrow_back,
          //                   color: white,
          //                 )),
          //               ),
          //               const Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Income",
          //                     style: TextStyle(
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: 13,
          //                         color: Color(0xff67727d)),
          //                   ),
          //                   SizedBox(
          //                     height: 8,
          //                   ),
          //                   Text(
          //                     "Rp 6593.75",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 20,
          //                     ),
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => const ExpenseScreen()));
          //       },
          //       child: Container(
          //         width: (size.width - 60) / 2,
          //         height: size.height * 0.21,
          //         decoration: BoxDecoration(
          //             color: white,
          //             borderRadius: BorderRadius.circular(12),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: grey.withOpacity(0.01),
          //                 spreadRadius: 10,
          //                 blurRadius: 3,
          //                 // changes position of shadow
          //               ),
          //             ]),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               left: 25, right: 25, top: 20, bottom: 20),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Container(
          //                 width: 40,
          //                 height: 40,
          //                 decoration: const BoxDecoration(
          //                     shape: BoxShape.circle, color: red),
          //                 child: const Center(
          //                     child: Icon(
          //                   Icons.arrow_forward,
          //                   color: white,
          //                 )),
          //               ),
          //               const Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Expense",
          //                     style: TextStyle(
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: 13,
          //                         color: Color(0xff67727d)),
          //                   ),
          //                   SizedBox(
          //                     height: 8,
          //                   ),
          //                   Text(
          //                     "Rp 2645.50",
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 20,
          //                     ),
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
