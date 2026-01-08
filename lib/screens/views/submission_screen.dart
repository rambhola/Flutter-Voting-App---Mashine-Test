import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/screens/views/listing_screen.dart';
import 'package:get/get.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/theme/views%20model/theme_controller.dart';
import 'dart:math';

import '../../theme/views/setting_page.dart';
import '../views_model/idea_controller.dart';

class SubmissionScreen extends StatefulWidget {
  const SubmissionScreen({super.key});

  @override
  State<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  final IdeaController ctr = Get.find<IdeaController>();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final taglineController = TextEditingController();
  final descController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    taglineController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Startup Idea \nEvaluator AI Voting App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  color: Colors.black26,
                ),
              ],
            ),
          ),

          elevation: 0,
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white,
                popupMenuTheme: PopupMenuThemeData(
                  color: Colors.white,
                  textStyle: TextStyle(color: Colors.black87),
                  iconColor: Colors.black87,
                ),
              ),
              child: PopupMenuButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 8,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 28.sp,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Center(child: Text("Setting")),
                    onTap: () => Get.to(() => SettingPages()),
                  ),
                ],
              ),
            ),
          ],

          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeController.isDarkModeValue
                      ? Colors.black87
                      : Color(0xFF764BA2),
                  Color(0xFF667EEA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeController.isDarkModeValue
                  ? [
                      Color(0xFF1a1a2e),
                      Color(0xFF16213e),
                    ] // Dark purple gradients
                  : [
                      Color(0xFF764BA2),
                      Color(0xFF667EEA),
                    ], // Original light gradients
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [0.0, 0.6],
            ),
          ),

          child: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),

                    //Submit Your Data Form Container
                    Container(
                      height: 600.h,
                      width: 355.w,

                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: themeController.isDarkModeValue
                            ? Colors.grey[900]
                            : Colors.white,
                        border: Border.all(
                          color: themeController.isDarkModeValue
                              ? Colors.white
                              : Colors.teal,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(35.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 25,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Submit Your Idea",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: themeController.isDarkModeValue
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // Form fields
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Startup Name",
                                labelStyle: TextStyle(
                                  color: themeController.isDarkModeValue
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                                prefixIcon: Icon(
                                  Icons.business_center,
                                  color: Color(0xFF667EEA),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF667EEA),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                              ),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Name required'
                                  : null,
                            ),
                            SizedBox(height: 20.h),

                            TextFormField(
                              controller: taglineController,
                              decoration: InputDecoration(
                                labelText: "Tagline",
                                prefixIcon: Icon(
                                  Icons.format_quote,
                                  color: Color(0xFF667EEA),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF667EEA),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                              ),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Tagline required'
                                  : null,
                            ),
                            SizedBox(height: 20.h),

                            TextFormField(
                              controller: descController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: "Description",
                                prefixIcon: Icon(
                                  Icons.description,
                                  color: Color(0xFF667EEA),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF667EEA),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                              ),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Description required'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    //Form Submission Button
                    Container(
                      height: 55.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.sp),
                        color: themeController.isDarkModeValue
                            ? Colors.transparent
                            : Color(0xFFFF6B35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrange,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final random = Random();
                                      int aiRating = random.nextInt(101);

                                      // Show Ai rating snack bar
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            padding: EdgeInsets.all(16.w),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF764BA2),
                                                  Color(0xFF667EEA),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.sp),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                                SizedBox(width: 16.w),
                                                Text(
                                                  'AI Rating: $aiRating/100',
                                                ),
                                              ],
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );

                                      final newIdea = IdeaModel(
                                        tagline: taglineController.text.trim(),
                                        title: nameController.text.trim(),
                                        description:  descController.text.trim(),
                                        score: aiRating,
                                        totalVotes: 0,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff7F00FF),
                                            Color(0xff3F8EFC),
                                          ],
                                        ),
                                      );
                                      ctr.addIdea(newIdea);

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 12.w),
                                              Text(
                                                "Idea submitted successfully!",
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Color(0xFF00D284),
                                        ),
                                      );


                                      // Clear form
                                      nameController.clear();
                                      taglineController.clear();
                                      descController.clear();

                                      // Navigate AFTER submit
                                      Get.to(() => const ListingScreen());

                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      "Submit Idea",
                                      style: TextStyle(
                                        color: themeController.isDarkModeValue
                                            ? Colors.white
                                            : Colors.white,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
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
              ),
            ),
          ),
        ),
      );
    });
  }
}
