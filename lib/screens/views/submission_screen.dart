import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/idea_controller.dart';
import '../../model/idea_model.dart';
import '../../theme/views%20model/theme_controller.dart';
import '../../screens/views/listing_screen.dart';
import '../../theme/views/setting_page.dart';

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

    // //MediaQuery Initialization Make your submission screen responsive using MediaQuery
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLandscape = constraints.maxWidth > constraints.maxHeight;
        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: 80,
              title: Text(
                "Startup Idea\nEvaluator AI Voting App",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isLandscape ? 12.sp : 22.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              elevation: 0,
              actions: [
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: isLandscape ? 16.sp : 26.sp,
                    ),
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: const Center(child: Text("Setting")),
                      onTap: () => Get.to(() => SettingPages()),
                    ),
                  ],
                ),
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeController.isDarkModeValue
                          ? Colors.black87
                          : const Color(0xFF764BA2),
                      const Color(0xFF667EEA),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: themeController.isDarkModeValue
                      ? const [Color(0xFF1a1a2e), Color(0xFF16213e)]
                      : const [Color(0xFF764BA2), Color(0xFF667EEA)],
                ),
              ),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.07),

                        Container(
                          width: isLandscape
                              ? screenWidth * 0.9
                              : screenWidth * 0.9,
                          height: isLandscape
                              ? screenHeight * 0.6
                              : screenHeight * 0.6,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: themeController.isDarkModeValue
                                ? Colors.grey[900]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(35.r),
                            border: Border.all(
                              color: themeController.isDarkModeValue
                                  ? Colors.white
                                  : Colors.teal,
                              width: 3.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            child: SingleChildScrollView(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Submit Your Idea",
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        labelText: "Startup Name",
                                        prefixIcon: const Icon(
                                          Icons.business_center,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                      ),
                                      validator: (value) =>
                                          value?.isEmpty ?? true
                                          ? 'Name required'
                                          : null,
                                    ),
                                    SizedBox(height: 16.h),
                                    TextFormField(
                                      controller: taglineController,
                                      decoration: InputDecoration(
                                        labelText: "Tagline",
                                        prefixIcon: const Icon(
                                          Icons.format_quote,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                      ),
                                      validator: (value) =>
                                          value?.isEmpty ?? true
                                          ? 'Tagline required'
                                          : null,
                                    ),
                                    SizedBox(height: 16.h),
                                    TextFormField(
                                      controller: descController,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        labelText: "Description",
                                        prefixIcon: const Icon(
                                          Icons.description,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                      ),
                                      validator: (value) =>
                                          value?.isEmpty ?? true
                                          ? 'Description required'
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 18.h),
                          child: SizedBox(
                            width: isLandscape
                                ? screenWidth * 0.85
                                : screenWidth * 0.85,
                            height: isLandscape
                                ? screenHeight * 0.20
                                : screenHeight * 0.07,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6B35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                elevation: 6,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final alreadyExists = ctr.ideas.any(
                                    (e) =>
                                        e.title.toLowerCase() ==
                                        nameController.text
                                            .trim()
                                            .toLowerCase(),
                                  );

                                  if (alreadyExists) {
                                    Get.snackbar(
                                      'Duplicate Idea',
                                      'This startup already exists',
                                    );
                                    return;
                                  }

                                  final random = Random();
                                  int aiRating = random.nextInt(101);

                                  // Create Hive IdeaModel
                                  final idea = IdeaModel(
                                    title: nameController.text.trim(),
                                    tagline: taglineController.text.trim(),
                                    description: descController.text.trim(),
                                    score: aiRating,
                                    votes: 0,
                                    isFavorite: false,
                                    badge: '⭐',
                                    gradientColors: const [
                                      0xff7F00FF,
                                      0xff3F8EFC,
                                    ],
                                  );

                                  // Add using controller (Hive integration)
                                  await ctr.addIdea(idea);

                                  nameController.clear();
                                  taglineController.clear();
                                  descController.clear();

                                  Get.to(() => const ListingScreen());
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Submit Idea",
                                  style: TextStyle(
                                    fontSize: isLandscape ? 18.sp : 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
