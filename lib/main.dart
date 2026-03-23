import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/idea_controller.dart';
import 'model/idea_model.dart'; 
import 'navbar/views/bottom_nav.dart';
import 'navbar/views_model/nav_controller.dart';
import 'theme/views model/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Hive
  await Hive.initFlutter();

  /// Register adapter
  Hive.registerAdapter(IdeaModelAdapter());

  /// Open box
  await Hive.openBox<IdeaModel>('ideasBox');

  /// Inject controllers
  Get.put(NavController());
  Get.put(IdeaController());
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
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
