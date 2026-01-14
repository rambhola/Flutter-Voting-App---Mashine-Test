import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/views model/theme_controller.dart';
import '../../theme/views/setting_page.dart';
import '../../widgets/read_more_text.dart';
import '../views_model/idea_controller.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IdeaController ctrl = Get.find<IdeaController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLandscape = constraints.maxWidth > constraints.maxHeight;

        return Obx(() {
          return Scaffold(
            backgroundColor: themeController.isDarkModeValue
                ? Colors.grey[900]!
                : const Color(0xFFF4F6FB),

            appBar: AppBar(
              title: SizedBox(
                width: isLandscape ? 0.45.sw : 0.65.sw,
                height: 0.2.sh,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Idea Listing",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLandscape ? 18.sp : 22.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                  ),
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
                      size: 26.sp,
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

            body: Column(
              children: [
                _SearchAndSortBar(
                  ctrl: ctrl,
                  themeController: themeController,
                  isLandscape: isLandscape,
                ),

                Expanded(
                  child: Obx(() {
                    final filtered =
                        ctrl.ideas
                            .where(
                              (idea) => idea.title.toLowerCase().contains(
                                ctrl.searchText.value.toLowerCase(),
                              ),
                            )
                            .toList()
                          ..sort((a, b) {
                            if (ctrl.sortByVotes.value) {
                              return b.votes.compareTo(a.votes);
                            }
                            return ctrl.sortByRating.value
                                ? b.score.compareTo(a.score)
                                : a.title.compareTo(b.title);
                          });

                    if (filtered.isEmpty) {
                      return Center(
                        child: Text(
                          'No ideas found',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkModeValue
                                ? Colors.white70
                                : Colors.grey.shade600,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final idea = filtered[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: IdeaCard(
                            idea: idea,
                            index: index + 1,
                            onFavorite: () => ctrl.toggleFavorite(idea),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

// SEARCH + SORT BAR

class _SearchAndSortBar extends StatelessWidget {
  final IdeaController ctrl;
  final ThemeController themeController;
  final bool isLandscape;

  const _SearchAndSortBar({
    required this.ctrl,
    required this.themeController,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       //  Search Bar Widget
        SizedBox(height: 12.h,),

        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: isLandscape ? 0.70.sw : 0.90.sw,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: themeController.isDarkModeValue
                    ? Colors.grey[800]!
                    : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: themeController.isDarkModeValue ? 0.3 : 0.10,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 24.sp,
                    color: themeController.isDarkModeValue
                        ? Colors.white70
                        : Colors.grey.shade700,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search ideas',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => ctrl.searchText.value = value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),


         //Sort Button Widge
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: isLandscape ? 0.45.sw : 0.50.sw,
            height: isLandscape ? 0.20.sh : 60.h,
            child: GestureDetector(
              onTap: () => ctrl.sortByRating.value = !ctrl.sortByRating.value,
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: themeController.isDarkModeValue
                          ? Colors.grey[800]!
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: themeController.isDarkModeValue ? 0.3 : 0.10,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sort, size: 18.sp),
                        const SizedBox(width: 8),
                        Text(
                          ctrl.sortByRating.value
                              ? 'Sort by Rating'
                              : 'Sort by Votes',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ================= IDEA CARD =================

class IdeaCard extends StatelessWidget {
  final IdeaModel idea;
  final int index;
  final VoidCallback onFavorite;

  IdeaCard({
    super.key,
    required this.idea,
    required this.index,
    required this.onFavorite,
  });

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint("Idea: ${idea.title}");
    }

    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(idea.title))),
      child: Container(
        constraints: BoxConstraints(minHeight: 120.h),
        decoration: BoxDecoration(
          gradient: idea.gradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Index Circle
              Container(
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idea.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      idea.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ReadMoreText(
                      text: idea.description.toString(),
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _badge('⭐ ${idea.score}/100'),
                        SizedBox(width: 8.w),
                        _badge('👍 ${idea.votes}'),
                      ],
                    ),
                  ],
                ),
              ),

              // Favorite Button
              GestureDetector(
                onTap: onFavorite,
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: idea.isFavorite
                        ? Colors.red.withValues(alpha: 0.30)
                        : Colors.white.withValues(alpha: 0.25),
                  ),
                  child: Center(
                    child: Icon(
                      idea.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: idea.isFavorite ? Colors.red : Colors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
