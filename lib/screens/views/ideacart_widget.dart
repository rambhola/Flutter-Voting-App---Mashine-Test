import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/idea_controller.dart';
import '../../model/idea_model.dart';
import '../../widgets/read_more_text.dart';

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

  final IdeaController ct = Get.find<IdeaController>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final screenWidth = media.size.height;
    final screenHeight = media.size.width;

    final isLandscape = media.orientation == Orientation.landscape;

    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(idea.title))),

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
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
          padding: EdgeInsets.all(isLandscape ? 8 : 16),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Idea Index Widget
              Container(
                width: isLandscape ? 36.w : 48.w,
                height: isLandscape ? 36.h : 48.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: TextStyle(
                    fontSize: isLandscape ? 9.sp : 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(width: isLandscape ? 6 : 12),

              // Idea all contend build here
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isLandscape ? 8.sp : 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: isLandscape ? 2 : 4),

                      Text(
                        idea.tagline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isLandscape ? 7.sp : 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: isLandscape ? 2 : 4),

                      ReadMoreText(
                        text: idea.description,
                        maxLines: isLandscape ? 2 : 4,
                        style: TextStyle(
                          fontSize: isLandscape ? 5.sp : 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      /// VOTES ROW
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _badge(context, '⭐ ${idea.score}/100'),
                          SizedBox(width: isLandscape ? 25.r : 6.5.r),
                          InkWell(
                            onTap: () => ct.upvoteIdea(idea),
                            child: _badge(context, '👍 ${idea.votes}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // here the take a action like make favorites idea / delete the existing idea
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => ct.deleteIdea(idea),
                    child: Container(
                      height: isLandscape
                          ? screenHeight * 0.07
                          : screenHeight * 0.14,
                      width: isLandscape
                          ? screenWidth * 0.12
                          : screenHeight * 0.14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.25),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),

                  SizedBox(height: isLandscape ? 1.h : 25.h),

                  GestureDetector(
                    onTap: onFavorite,
                    child: Container(
                      height: isLandscape
                          ? screenHeight * 0.07
                          : screenHeight * 0.14,
                      width: isLandscape
                          ? screenWidth * 0.12
                          : screenHeight * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: idea.isFavorite
                            ? Colors.red.withValues(alpha: 0.3)
                            : Colors.white.withValues(alpha: 0.25),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Icon(
                        idea.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: idea.isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // here the idea badge widget
  Widget _badge(BuildContext context, String text) {
    // Use MediaQuery to get screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      height: isLandscape ? screenHeight * 0.06 : screenHeight * 0.04,
      width: isLandscape ? screenWidth * 0.11 : screenWidth * 0.23,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.yellow, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isLandscape ? 4.sp : 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
