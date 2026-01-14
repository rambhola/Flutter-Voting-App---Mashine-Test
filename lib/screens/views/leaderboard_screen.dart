import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../views_model/idea_controller.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IdeaController controller = Get.find<IdeaController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B5CF6), Color(0xFF6B46C1), Color(0xFF553C9A)],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            /// Sort ideas by score
            final sortedIdeas = List<IdeaModel>.from(controller.ideas)
              ..sort((a, b) => b.score.compareTo(a.score));

            final top5 = sortedIdeas.take(5).toList();
            final others = sortedIdeas.skip(5).take(10).toList();

            return LayoutBuilder(
              builder: (context, constraints) {
                final bool isLandscape =
                    constraints.maxWidth > constraints.maxHeight;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: isLandscape
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,

                    children: [
                      /// ================= HEADER =================
                      _Header(),

                      SizedBox(height: 24.h),

                      /// ================= PODIUM =================
                      ...top5.asMap().entries.map((entry) {
                        final index = entry.key;
                        final idea = entry.value;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: NeumorphicCard(
                            idea: idea,
                            rank: index + 1,
                            badge: ['🥇', '🥈', '🥉', '🏅', '🎖️'][index],
                            medalColor: [
                              Colors.amber,
                              Colors.orange,
                              Colors.purpleAccent,
                              Colors.blueAccent,
                              Colors.green,
                            ][index],
                          ),
                        );
                      }),

                      SizedBox(height: 24.h),

                      /// ================= OTHER STARTUPS =================
                      Text(
                        'Other Startups',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: others.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: OtherStartupCard(idea: others[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

/// ================= HEADER WIDGET =================
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.leaderboard, color: Colors.white, size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= PODIUM CARD =================
class NeumorphicCard extends StatelessWidget {
  final IdeaModel idea;
  final int rank;
  final String badge;
  final Color medalColor;

  const NeumorphicCard({
    super.key,
    required this.idea,
    required this.rank,
    required this.badge,
    required this.medalColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = screenWidth > screenHeight;
    final cardHeight = isLandscape ? screenHeight * 0.6 : screenHeight * 0.16;

    return GestureDetector(
      onTap: () => Get.find<IdeaController>().voteIdea(idea),
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            const BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10,
              offset: Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(-5, -5),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: medalColor.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Text(badge, style: TextStyle(fontSize: 24.sp)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('#$rank', style: TextStyle(fontSize: 14.sp, color: Colors.white70)),
                  SizedBox(height: 4.h),
                  Text(
                    idea.title,
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.thumb_up, color: Colors.white70, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text('${idea.votes} votes', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16.sp),
          ],
        ),
      ),
    );
  }
}

/// ================= OTHER STARTUP CARD =================
class OtherStartupCard extends StatelessWidget {
  final IdeaModel idea;

  const OtherStartupCard({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<IdeaController>().voteIdea(idea),
      child: Container(
        width: 140.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade400, Colors.purple.shade700],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              idea.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${idea.votes}', style: TextStyle(color: Colors.white70)),
                Text(
                  idea.badge ?? '⭐', // Removed ?? since badge should be non-nullable
                  style: TextStyle(fontSize: 20.sp),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${idea.score}/100',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
