import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/navbar/views_model/nav_controller.dart';
import 'package:get/get.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/screens/views/leaderboard_screen.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/screens/views/listing_screen.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/screens/views/submission_screen.dart';

import '../../theme/views/setting_page.dart';

class BottomNav extends StatelessWidget {
  int? navIndex;
  BottomNav({super.key, this.navIndex});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.find<NavController>();
    if (navIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navController.selectedIndex(navIndex!.clamp(0, 2));
      });
    }
    return Scaffold(

      body: Obx(
        () => IndexedStack(
          index: navController.selectedIndex.value.clamp(0, 2),
          children: [SubmissionScreen(), ListingScreen(), LeaderboardScreen()],
        ),
      ),
      bottomNavigationBar:


      Obx(() {
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
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: navController.selectedIndex.value.clamp(0, 2),
              selectedFontSize: 12,
              unselectedFontSize: 12,
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
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: navController.selectedIndex.value == 0
                          ? Color(0xff3c8c52)
                          : Colors.transparent,
                    ),
                    child: Center(child: Icon(Icons.home)),
                  ),
                  activeIcon: Container(
                    height: 32,
                    width: 32,
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
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: navController.selectedIndex.value == 1
                          ? Color(0xff3c8c52)
                          : Colors.transparent,
                    ),
                    child: Center(child: Icon(CupertinoIcons.square_list_fill)),
                  ),
                  activeIcon: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(child: Icon(CupertinoIcons.square_list_fill)),
                  ),
                  label: 'Listing',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: navController.selectedIndex.value == 2
                          ? Color(0xff3c8c52)
                          : Colors.transparent,
                    ),
                    child: Center(child: Icon(CupertinoIcons.person)),
                  ),
                  activeIcon: Container(
                    height: 32,
                    width: 32,
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
        );
      }),
    );
  }
}
