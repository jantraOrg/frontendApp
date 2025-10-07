import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ReportDetailScreen extends StatefulWidget {
  final String title;
  final String category;
  final String description;
  final List<String> images;
  final double latitude;
  final double longitude;
  final String status;

  const ReportDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  late GoogleMapController mapController;
  int verificationCount = 1;
  bool isVerifiedByUser = false;
  int _currentPage = 0;

  final List<String> timelineSteps = [
    "Submitted",
    "In Review",
    "Verified",
    "Resolved"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9C802),
        centerTitle: true,
        elevation: 2,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🗺️ Google Map Section
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 220,
               child: Stack(
                alignment: Alignment.center,
                children: [
                    ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                        "assets/images/map.png", // ← Add your static map image here
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                    ),
                    ),
                    Container(
                    color: Colors.black.withOpacity(0.25),
                    child: const Icon(
                        Icons.map,
                        color: Colors.white,
                        size: 50,
                    ),
                    ),
                ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🧾 Report Info Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C5C00),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 🖼️ Image Carousel (Custom PageView)
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            itemCount: widget.images.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  widget.images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(widget.images.length, (i) {
                                bool isActive = i == _currentPage;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  height: 8,
                                  width: isActive ? 18 : 8,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? const Color(0xFFF9C802)
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ✅ Verification Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Community Verification",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF6C5C00),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$verificationCount / 3 verifications",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: verificationCount / 3,
                      backgroundColor: Colors.grey[300],
                      color: const Color(0xFFF9C802),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: isVerifiedByUser
                          ? null
                          : () {
                              setState(() {
                                verificationCount++;
                                isVerifiedByUser = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("✅ You verified this report!"),
                                ),
                              );
                            },
                      icon: const Icon(Icons.verified_outlined),
                      label: Text(
                        isVerifiedByUser
                            ? "Already Verified"
                            : "Verify This Report",
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isVerifiedByUser
                            ? Colors.grey
                            : const Color(0xFFF9C802),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 📦 Progress Timeline Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Progress Timeline",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF6C5C00),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: List.generate(timelineSteps.length, (index) {
                        bool isCompleted =
                            index <= timelineSteps.indexOf(widget.status);
                        return TimelineTile(
                          alignment: TimelineAlign.start,
                          isFirst: index == 0,
                          isLast: index == timelineSteps.length - 1,
                          indicatorStyle: IndicatorStyle(
                            color: isCompleted
                                ? const Color(0xFFF9C802)
                                : Colors.grey[400]!,
                            width: 20,
                          ),
                          beforeLineStyle: LineStyle(
                            color: isCompleted
                                ? const Color(0xFFF9C802)
                                : Colors.grey[300]!,
                            thickness: 3,
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              timelineSteps[index],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: isCompleted
                                    ? const Color(0xFF6C5C00)
                                    : Colors.grey,
                                fontWeight: isCompleted
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
