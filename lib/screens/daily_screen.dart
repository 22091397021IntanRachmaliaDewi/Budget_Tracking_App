import 'package:budget_tracking_app/model/daily_model.dart';
import 'package:budget_tracking_app/screens/calender_page.dart';
import 'package:budget_tracking_app/screens/dasboard.dart';
import 'package:budget_tracking_app/services/firebase.dart';
import 'package:budget_tracking_app/services/extension.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  List<DailyModel> listDaily = [];
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    listDaily = await FirebaseService.get() ?? [];
    totalPrice = listDaily.fold(
        0, (prev, element) => prev + double.parse(element.price));
    setState(() {});
  }

  void deleteDailyValidation(String id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titleTextStyle: TextStyle(fontSize: 16, color: black),
        title: Center(
            child: Text(
          "Apakah Anda yakin menghapus data ini?",
        )),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: red),
              onPressed: () => Navigator.pop(context),
              child: Text("Tidak")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
              ),
              onPressed: () => deleteDaily(id),
              child: Text("Ya"))
        ],
      ),
    );
  }

  void deleteDaily(String id) async {
    await FirebaseService.deleteDaily(id);

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil menghapus data"),
        backgroundColor: green,
      ),
    );
  }

  int activeDay = 3;
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
            height: size.height * 0.33,
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: const Padding(
              padding:
                  EdgeInsets.only(top: 40, right: 15, left: 15, bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Laporan Pengeluaran",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: CalenderPage()),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: listDaily.isEmpty
                  ? Text("")
                  : Column(
                      children: List.generate(listDaily.length, (index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (size.width - 40) * 0.7,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: grey.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          listDaily[index].icon,
                                          width: 30,
                                          height: 30,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    SizedBox(
                                      width: (size.width - 90) * 0.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listDaily[index].name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: black,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            listDaily[index].date,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: black.withOpacity(0.5),
                                                fontWeight: FontWeight.w400),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: (size.width - 40) * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id_ID',
                                              symbol: 'Rp ',
                                              decimalDigits: 0)
                                          .format(double.parse(
                                              listDaily[index].price)),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.green),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () => deleteDailyValidation(
                                            listDaily[index].id),
                                        icon: Icon(
                                          Ionicons.trash,
                                          color: red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 65, top: 8),
                            child: Divider(
                              thickness: 0.8,
                            ),
                          )
                        ],
                      );
                    })),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          listDaily.isEmpty
              ? SizedBox.expand()
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 80),
                        child: Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 16,
                              color: black.withOpacity(0.4),
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'Rp ',
                                  decimalDigits: 0)
                              .format(totalPrice),
                          style: TextStyle(
                              fontSize: 20,
                              color: black,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
