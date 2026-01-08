import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../theme/views model/theme_controller.dart';
import '../../widgets/read_more_text.dart';
import '../views_model/idea_controller.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IdeaController ctrl = Get.find();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: themeController.isDarkModeValue
            ? Colors.grey[900]!
            : const Color(0xFFF4F6FB),
        body: Column(
          children: [
            Container(
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
              ),
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 18,
                    ),
                    child: Text(
                      'Idea Listing',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Search Widget
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: themeController.isDarkModeValue
                          ? Colors.grey[800]!
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: themeController.isDarkModeValue ? 0.3 : 0.08,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: themeController.isDarkModeValue
                              ? Colors.white70
                              : Colors.grey,
                          size: 22.sp,
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search ideas',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.h,
                              ),
                            ),
                            onChanged: (value) => ctrl.searchText.value = value,
                          ),
                        ),
                        Obx(
                          () => ctrl.searchText.value.isNotEmpty
                              ? GestureDetector(
                                  onTap: () => ctrl.searchText.value = '',
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                    size: 20.sp,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  //Short Container Widest
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            ctrl.sortByRating.value = !ctrl.sortByRating.value,
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: themeController.isDarkModeValue
                                  ? Colors.grey[800]!
                                  : Colors.white,
                              border: Border.all(
                                color: themeController.isDarkModeValue
                                    ? Colors.grey[600]!
                                    : Colors.grey.shade300,
                              ),

                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sort,
                                  size: 16.sp,
                                  color: themeController.isDarkModeValue
                                      ? Colors.white70
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  ctrl.sortByRating.value
                                      ? 'Sort by Rating'
                                      : 'Sort by Votes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16.sp,
                                  color: themeController.isDarkModeValue
                                      ? Colors.white70
                                      : Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final filtered = ctrl.ideas
                    .where(
                      (idea) => idea.title.toLowerCase().contains(
                        ctrl.searchText.value.toLowerCase(),
                      ),
                    )
                    .toList();

                filtered.sort((a, b) {
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
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final idea = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _IdeaCard(
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
  }
}

class _IdeaCard extends StatelessWidget {
  final IdeaModel idea;
  final int index;
  final VoidCallback onFavorite;
  final themeController = Get.find<ThemeController>();

  _IdeaCard({
    required this.idea,
    required this.index,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      if (idea.title.isEmpty) {
        print(" Data Not Passed By Submission Screen");
      } else {
        print("Title : ${idea.title}");
        print("Tagline: ${idea.tagline}");
        print("Description: ${idea.description}");
      }
    }

    return Obx(() {
      return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(idea.title)));
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: idea.gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$index',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: themeController.isDarkModeValue
                            ? Colors.black87
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
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
                        const SizedBox(height: 4),
                        Text(
                          idea.tagline.toString(),
                          maxLines: 200,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: themeController.isDarkModeValue
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ReadMoreText(
                          text: idea.description.toString(),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: themeController.isDarkModeValue
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            _badge('⭐ ${idea.score}/100'),
                            const SizedBox(width: 8),
                            _badge('👍 ${idea.votes} votes'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onFavorite,
                    child: Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: idea.isFavorite
                            ? Colors.red.withValues(alpha: 0.3)
                            : (themeController.isDarkModeValue
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.25)),
                        shape: BoxShape.circle,
                      ),

                      child: Center(
                        child: Icon(
                          idea.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: idea.isFavorite
                              ? Colors.red[300]
                              : Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _badge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: themeController.isDarkModeValue ? Colors.black87 : Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
