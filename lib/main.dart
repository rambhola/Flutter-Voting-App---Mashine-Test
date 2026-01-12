import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/navbar/views/bottom_nav.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/navbar/views_model/nav_controller.dart';
import 'package:get/get.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/screens/views_model/idea_controller.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/shared_prefrences/views_model/form_controller.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/theme/views%20model/theme_controller.dart';

void main() {
  //This ensures the controller is created globally before any screen loads.
  Get.put(NavController());
  Get.put(IdeaController());
  Get.put(ThemeController());
  Get.lazyPut<FormController>(() => FormController(),fenix: true,);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {






    // Dynamically adjust design size for portrait & landscape

    return ScreenUtilInit(
      designSize: Size(393, 852), // Standard modern mobile reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {


        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: Colors.grey[50],
            cardTheme: CardThemeData(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: ThemeMode.system,
          home: BottomNavScreen(),
        );
      },
    );
  }
}
