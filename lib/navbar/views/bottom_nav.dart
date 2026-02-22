import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/views/leaderboard_screen.dart';
import '../../screens/views/listing_screen.dart';
import '../../screens/views/submission_screen.dart';
import '../views_model/nav_controller.dart';


class BottomNavScreen extends StatelessWidget {
  final int? navIndex;
  const BottomNavScreen({super.key, this.navIndex});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.find<NavController>();
    if (navIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navController.selectedIndex(navIndex!.clamp(0, 2));
      });
    }

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: navController.selectedIndex.value.clamp(0, 2),
          children: [SubmissionScreen(), ListingScreen(), LeaderboardScreen()],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
            ),
            child: SizedBox(
              height: isLandscape ? 52 : 65,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: navController.selectedIndex.value.clamp(0, 2),
                selectedFontSize: isLandscape ? 10 : 12,
                unselectedFontSize: isLandscape ? 10 : 12,
                selectedItemColor: Color(0xFF667EEA),
                unselectedItemColor: Color(0xFF94A3B8),
                selectedLabelStyle: TextStyle(
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(color: Color(0xFF64748B)),
                elevation: 8.0,
                backgroundColor: Colors.grey[900],
                showSelectedLabels: true,
                showUnselectedLabels: true,
                onTap: (index) => navController.selectedIndex(index),
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      height: isLandscape ? 22 : 28,
                      width: isLandscape ? 22 : 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: navController.selectedIndex.value == 0
                            ? Color(0xff3c8c52)
                            : Colors.transparent,
                      ),
                      child: Center(child: Icon(Icons.home)),
                    ),
                    activeIcon: Container(
                      height: isLandscape ? 26 : 32,
                      width: isLandscape ? 26 : 32,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(child: Icon(Icons.home)),
                    ),
                    label: 'Submission',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: isLandscape ? 22 : 28,
                      width: isLandscape ? 22 : 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: navController.selectedIndex.value == 1
                            ? Color(0xff3c8c52)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Icon(CupertinoIcons.square_list_fill),
                      ),
                    ),
                    activeIcon: Container(
                      height: isLandscape ? 26 : 32,
                      width: isLandscape ? 26 : 32,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(CupertinoIcons.square_list_fill),
                      ),
                    ),
                    label: 'Listing',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: isLandscape ? 22 : 28,
                      width: isLandscape ? 22 : 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: navController.selectedIndex.value == 2
                            ? Color(0xff3c8c52)
                            : Colors.transparent,
                      ),
                      child: Center(child: Icon(CupertinoIcons.person)),
                    ),
                    activeIcon: Container(
                      height: isLandscape ? 26 : 32,
                      width: isLandscape ? 26 : 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(child: Icon(CupertinoIcons.person)),
                    ),
                    label: 'Leaderboard',
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
