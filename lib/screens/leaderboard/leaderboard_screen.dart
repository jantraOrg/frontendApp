import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topUsers = [
      {"name": "Aarav Patel", "points": 1560, "avatar": "assets/images/avatar.png"},
      {"name": "Priya Sharma", "points": 1420, "avatar": "assets/images/avatar.png"},
      {"name": "Rohit Kumar", "points": 1340, "avatar": "assets/images/avatar.png"},
    ];

    final others = List.generate(17, (i) {
      return {
        "rank": i + 4,
        "name": "User ${i + 4}",
        "points": 1200 - (i * 20),
        "avatar": "assets/images/avatar.png"
      };
    });

    final currentUser = {"rank": 47, "points": 890};

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        title: const Text(
          '🏆 Leaderboard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFF9C802),
        centerTitle: true,
        elevation: 4,
      ),

      // 🌟 Entire page scrollable
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🥇 Top 3 Podium
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9C802), Color(0xFFFFF9E6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Community Heroes 💪",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6C5C00),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildPodiumUser(topUsers[1], 2),
                      _buildPodiumUser(topUsers[0], 1),
                      _buildPodiumUser(topUsers[2], 3),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔢 Leaderboard for ranks 4–20
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: others.map((user) {
                  return _buildLeaderboardTile(
                    rank: user["rank"] as int,
                    name: user["name"] as String,
                    points: user["points"] as int,
                    avatar: user["avatar"] as String,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // 🎁 Reward banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF9C802), Color(0xFFFFE978)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Colors.white, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Top 20 win monthly gifts 🎉 Keep contributing!",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 👤 Current user rank
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9C802),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "Your Rank: #${currentUser['rank']} — ${currentUser['points']} pts 💪",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🏅 Podium user widget
  static Widget _buildPodiumUser(Map<String, dynamic> user, int position) {
    double height;
    Color color;
    String medal;
    switch (position) {
      case 1:
        height = 100;
        color = Colors.amber;
        medal = "🥇";
        break;
      case 2:
        height = 80;
        color = Colors.grey;
        medal = "🥈";
        break;
      case 3:
        height = 60;
        color = Colors.brown;
        medal = "🥉";
        break;
      default:
        height = 60;
        color = Colors.grey;
        medal = "🏅";
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(user["avatar"]),
          backgroundColor: Colors.white,
        ),
        const SizedBox(height: 6),
        Text(
          user["name"],
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "${user["points"]} pts",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          width: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              medal,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔢 Leaderboard user tile
  static Widget _buildLeaderboardTile({
    required int rank,
    required String name,
    required int points,
    required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "#$rank",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C7000),
            ),
          ),
          const SizedBox(width: 14),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            "$points pts",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
