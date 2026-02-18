import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/idea_controller.dart';
import '../../theme/views model/theme_controller.dart';
import '../../theme/views/setting_page.dart';
import 'ideacart_widget.dart';
import '../../screens/views/search_and_shortbar_widget.dart';

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
                width: isLandscape ? 100.sw : 0.65.sw,
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
                SearchAndSortBar(
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
                      scrollDirection: isLandscape ? Axis.horizontal : Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final idea = filtered[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 7.h),
                          child: SizedBox(
                            width: isLandscape ? 500 : double.infinity,
                            child: IdeaCard(
                              idea: idea,
                              index: index + 1,
                              onFavorite: () => ctrl.toggleFavorite(idea),
                            ),
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
