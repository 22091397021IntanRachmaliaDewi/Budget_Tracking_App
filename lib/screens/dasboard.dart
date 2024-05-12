import 'package:budget_tracking_app/screens/budget_screen.dart';
import 'package:budget_tracking_app/screens/create_budget_screen.dart';
import 'package:budget_tracking_app/screens/daily_screen.dart';
import 'package:budget_tracking_app/screens/login_screen.dart';
import 'package:budget_tracking_app/screens/profile_screen.dart';
import 'package:budget_tracking_app/screens/stats_screen.dart';
import 'package:budget_tracking_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;
  List<Widget> pages = [
    const DailyScreen(),
    const StatsScreens(),
    const BudgetScreen(),
    const ProfileScreen(),
    const CreateBudgetScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<AlertDialog>? _showSureToExitDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                }),
          ],
        );
      },
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: getBody(),
          bottomNavigationBar: getFooter(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                selectedTab(4);
              },
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                size: 25,
              )
              //params
              ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked),
      onWillPop: () async {
        _showSureToExitDialog(
          context,
          'Exit',
          'Are you sure want to exit?',
        );
        return false;
      },
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.calendar,
      Ionicons.stats_chart,
      Ionicons.wallet,
      Ionicons.person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
