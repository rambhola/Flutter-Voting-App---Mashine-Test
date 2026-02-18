import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/idea_controller.dart';
import '../../theme/views model/theme_controller.dart';

class SearchAndSortBar extends StatelessWidget {
  final IdeaController ctrl;
  final ThemeController themeController;
  final bool isLandscape;

  const SearchAndSortBar({
    super.key,
    required this.ctrl,
    required this.themeController,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      child: Row(
        children: [
          ///  Search Bar Widget
          Expanded(
            child: Container(
              height: isLandscape ? 38.h : 48.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: themeController.isDarkModeValue
                    ? Colors.grey[800]
                    : Colors.white,
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      themeController.isDarkModeValue ? 0.25 : 0.08,
                    ),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: isLandscape ? 14.sp : 20.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: isLandscape ? 11.sp : 16.sp,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Search ideas",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onChanged: (v) =>
                      ctrl.searchText.value = v,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 8.w),

          /// Sort Button Widget
          Obx(
                () => GestureDetector(
              onTap: () => ctrl.sortByRating.value =
              !ctrl.sortByRating.value,
              child: Container(
                height: isLandscape ? 36.h : 48.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  color: themeController.isDarkModeValue
                      ? Colors.grey[800]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(22.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        themeController.isDarkModeValue
                            ? 0.25
                            : 0.08,
                      ),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.sort,
                        size: isLandscape ? 16.sp : 18.sp),

                    SizedBox(width: 4.w),

                    Text(
                      ctrl.sortByRating.value
                          ? "Sort By Rating"
                          : "Sort By Votes",
                      style: TextStyle(
                        fontSize:
                        isLandscape ? 12.sp : 14.sp,
                      ),
                    ),

                    const SizedBox(width: 6),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
