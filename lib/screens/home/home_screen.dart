import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // Start from the main feed (center tab)

  final List<Widget> _pages = [
    const Center(child: Text("🏆 Leaderboard Page")),
    const FeedScreen(), // main feed
    const Center(child: Text("👤 Profile Page")),
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  void _goHome() {
    setState(() => _currentIndex = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9C802),
        elevation: 3,
        centerTitle: true,

        // 👇 Change leading icon based on current tab
        leading: _currentIndex == 1
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white),
                onPressed: _goHome,
              ),

        // 👇 Make the JANTRA title tappable
        title: GestureDetector(
          onTap: _goHome,
          child: const Text(
            'JANTRA',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),

      // Drawer
      drawer: Drawer(
        backgroundColor: const Color(0xFFFFFDF2),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9C802), Color(0xFFFFF6C2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 36, color: Color(0xFFF9C802)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome, User!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF8C7000)),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6C5C00),
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.delete_forever, color: Colors.redAccent),
              title: const Text(
                'Delete Account',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Account deletion coming soon."),
                ));
              },
            ),
          ],
        ),
      ),

      // Animated body
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _pages[_currentIndex],
      ),

      // Floating central "+" button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report'),
        backgroundColor: const Color(0xFFF9C802),
        elevation: 6,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.leaderboard,
                  color:
                      _currentIndex == 0 ? const Color(0xFFF9C802) : Colors.grey,
                ),
                onPressed: () => _onTabTapped(0),
              ),
              const SizedBox(width: 40), // space for FAB
              IconButton(
                icon: Icon(
                  Icons.person,
                  color:
                      _currentIndex == 2 ? const Color(0xFFF9C802) : Colors.grey,
                ),
                onPressed: () => _onTabTapped(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------
/// FEED SCREEN (Main Page Content)
/// ----------------------------------------------------------
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final complaints = [
      {
        "title": "Potholes on MG Road",
        "desc": "Large potholes making traffic unsafe near sector 12.",
        "status": "Verified",
        "progress": "Work in Progress",
        "images": [
          "assets/images/pothole1.webp",
          "assets/images/pothole2.webp",
          "assets/images/pothole3.webp",
        ],
      },
      {
        "title": "Open Drain Problem",
        "desc": "Open drains causing bad odor and health risk.",
        "status": "Non-Verified",
        "progress": "Not Started",
        "images": [
          "assets/images/openDrain1.webp",
          "assets/images/openDrain2.webp",
          "assets/images/openDrain3.webp",
        ],
      },
      {
        "title": "Garbage Overflow",
        "desc": "Overflowing garbage bins for last 3 days in Market area.",
        "status": "Verified",
        "progress": "Completed",
        "images": [
          "assets/images/openDustbin1.webp",
          "assets/images/openDustbin2.webp",
          "assets/images/openDustbin3.webp",
        ],
      },
    ];

    return Container(
      color: const Color(0xFFFFFDF5),
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final item = complaints[index];
          return ComplaintCard(
            title: item["title"] as String,
            description: item["desc"] as String,
            status: item["status"] as String,
            progress: item["progress"] as String,
            images: List<String>.from(item["images"] as List),
          );
        },
      ),
    );
  }
}

/// ----------------------------------------------------------
/// COMPLAINT CARD WIDGET
/// ----------------------------------------------------------
class ComplaintCard extends StatefulWidget {
  final String title;
  final String description;
  final String status;
  final String progress;
  final List<String> images;

  const ComplaintCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.progress,
    required this.images,
  });

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  int _currentPage = 0;

  Color _statusColor(String status) {
    switch (status) {
      case "Verified":
        return Colors.green;
      case "Non-Verified":
        return Colors.redAccent;
      default:
        return Colors.orange;
    }
  }

  Color _progressColor(String progress) {
    switch (progress) {
      case "Completed":
        return Colors.blueAccent;
      case "Work in Progress":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening "${widget.title}" details...')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷️ Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6C5C00),
                ),
              ),
            ),

            // 🖼️ Image carousel with overlay
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    itemCount: widget.images.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              widget.images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          // “1/3” overlay
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${index + 1}/${widget.images.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // 🔵 Dots indicator
                Positioned(
                  bottom: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.images.length, (dotIndex) {
                      bool isActive = dotIndex == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin:
                            const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isActive ? 18 : 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFF9C802)
                              : Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),

            // 🧾 Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.description,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),

            // 🏷️ Tags
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildTag(widget.status, _statusColor(widget.status)),
                  const SizedBox(width: 8),
                  _buildTag(widget.progress, _progressColor(widget.progress)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
