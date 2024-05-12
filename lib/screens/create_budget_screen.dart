import 'package:budget_tracking_app/model/create_budget_model.dart';
import 'package:budget_tracking_app/model/daily_model.dart';
import 'package:budget_tracking_app/screens/dasboard.dart';
import 'package:budget_tracking_app/services/extension.dart';
import 'package:budget_tracking_app/services/firebase.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  _CreateBudgetScreenState createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  bool isLoading = false;
  int activeCategory = 0;
  final TextEditingController _budgetName = TextEditingController();
  final TextEditingController _budgetPrice = TextEditingController();
  final TextEditingController _datePick = TextEditingController();

  void createDailyValidation() async {
    if (_budgetName.text.isEmpty && _budgetPrice.text.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          titleTextStyle: TextStyle(fontSize: 16, color: black),
          title: Center(
              child: Text(
            "Budget dan Price Tidak Boleh Kosong",
          )),
        ),
      );
    } else {
      createDaily();
    }
  }

  void createDaily() async {
    setState(() {
      isLoading = true;
    });

    String icon = "asset/auto.png";
    switch (activeCategory) {
      case 0:
        icon = "asset/auto.png";
      case 1:
        icon = "asset/bank.png";
      case 2:
        icon = "asset/cash.png";
      case 3:
        icon = "asset/charity.png";
      case 4:
        icon = "asset/eating.png";
      case 5:
        icon = "asset/gift.png";
      default:
    }

    String name = _budgetName.text;
    String date = DateTime.now().formatForm();
    String price = _budgetPrice.text;

    DailyModel daily =
        DailyModel(id: "", icon: icon, name: name, date: date, price: price);

    print(daily.toString());

    await FirebaseService.addDaily(daily);

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil menambahkan data"),
        backgroundColor: green,
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: isLoading ? loadingWidget() : getBody(),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: const Padding(
              padding:
                  EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Input Pengeluaran",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Row(
                        children: [Icon(Icons.search)],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              "Pilih Kategori",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: black.withOpacity(0.5)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    print(activeCategory);
                    activeCategory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    width: size.width * 0.22,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? primary
                                : Colors.transparent),
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
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.asset(
                                  categories[index]['icon'],
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Text(
                            categories[index]['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tanggal",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        onChanged: (date) {
                          print('change $date');
                        },
                        onConfirm: (date) {
                          setState(() {
                            _datePick.text = date.formatForm();
                          });
                          print('confirm $date');
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.id,
                      ),
                      child: TextField(
                        enabled: false,
                        controller: _datePick,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: black),
                        decoration: const InputDecoration(
                          hintText:
                              "Pilih Tanggal", /*border: InputBorder.none*/
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Deskripsi Pengeluaran",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: _budgetName,
                  cursorColor: black,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
                  decoration: const InputDecoration(
                    hintText:
                        "Masukkan Deskripsi Pengeluaran", /*border: InputBorder.none*/
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Jumlah Pengeluaran",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            controller: _budgetPrice,
                            cursorColor: black,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: black),
                            decoration: const InputDecoration(
                              hintText:
                                  "Masukkan Jumlah Pengeluaran", /*border: InputBorder.none*/
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: createDailyValidation,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
