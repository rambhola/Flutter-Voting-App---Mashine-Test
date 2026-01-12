import 'package:flutter/material.dart';
import 'package:get/get.dart'; //
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
            colors: [
              Color(0xFF8B5CF6),
              Color(0xFF6B46C1),
              Color(0xFF553C9A),
            ],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            // Sort by score
            final sortedIdeas = List<IdeaModel>.from(controller.ideas);
            sortedIdeas.sort((a, b) => b.score.compareTo(a.score));
            final top5 = sortedIdeas.take(5).toList();
            final others = sortedIdeas.skip(5).take(10).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.leaderboard,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Leaderboard',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top 3 Podium Cards
                  ...top5.asMap().entries.map((entry) {
                    final index = entry.key;
                    final idea = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
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

                  const SizedBox(height: 24),

                  // Other Startups Horizontal
                  const Row(
                    children: [
                      Text(
                        'Other Startups',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: others.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: OtherStartupCard(idea: others[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

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
    return GestureDetector(
      onTap: () {
        Get.find<IdeaController>().voteIdea(idea);
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            const BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10,
              offset: Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(-5, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Medal
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: medalColor.withOpacity(0.3),

                  shape: BoxShape.circle,
                ),
                child: Text(badge, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#$rank',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    Text(
                      idea.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${idea.votes} votes',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherStartupCard extends StatelessWidget {
  final IdeaModel idea;
  const OtherStartupCard({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<IdeaController>().voteIdea(idea);
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade400, Colors.purple.shade700],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                idea.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${idea.votes}',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(idea.badge ?? '⭐', style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${idea.score}/100',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
