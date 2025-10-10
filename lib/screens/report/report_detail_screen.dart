import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  int verificationCount = 1;
  bool isVerifiedByUser = false;
  int _currentPage = 0;
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> timelineSteps = [
    "Reported",
    "Assigned",
    "Inspection",
    "In Review",
    "Work Started",
    "Halfway Done",
    "Verification",
    "Resolved"
  ];
// this function , will open the camera and capture photo
Future<void> _captureVerificationPhoto() async {
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  if (photo != null) {
    setState(() {
      _capturedImage = File(photo.path);
    });
  }
}

  // ✅ Bottom sheet for verification
  void _showVerificationSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Text(
                  "Capture Verification Photo",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF6C5C00),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Click a photo at the issue location.\nYour GPS will be verified automatically.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),

                // 📸 Camera Capture Button
                ElevatedButton.icon(
                  onPressed: () async {
                    await _captureVerificationPhoto();
                    setModalState(() {}); // Refresh bottom sheet UI
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text("Open Camera"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9C802),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🖼️ Image Preview (if captured)
                if (_capturedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _capturedImage!,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),

                const SizedBox(height: 20),

                // ✅ Submit Button
                ElevatedButton.icon(
                  onPressed: _capturedImage == null
                      ? null
                      : () {
                          Navigator.pop(context);
                          setState(() {
                            verificationCount++;
                            isVerifiedByUser = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("✅ Verification submitted!"),
                            ),
                          );
                        },
                  icon: const Icon(Icons.send_rounded),
                  label: const Text(
                    "Submit Verification",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9C802),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    },
  );
}


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
            // 🗺️ Map Section
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "assets/images/map.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black54,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.close,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 220,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.25),
                      height: 220,
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

            const SizedBox(height: 16),

            // 📍 Address Card
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: Color(0xFFF9C802), size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "MG Road, Sector 12, Gurugram, Haryana - 122001",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.black87,
                        ),
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

                    // 🖼️ Image Carousel
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
                                  duration:
                                      const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4),
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
                              _showVerificationSheet(context);
                            },
                      icon: const Icon(Icons.verified_outlined),
                      label: Text(
                        isVerifiedByUser
                            ? "Already Verified"
                            : "Verify This Report",
                        style:
                            const TextStyle(fontFamily: 'Poppins'),
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

            // 📦 Progress Timeline (Zigzag)
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
            _buildZigzagTimeline(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 🟡 Custom Zigzag Timeline
 // 🟡 Improved Zigzag Timeline with connecting arrows/lines
// 🟢 Elegant Vertical Progress Timeline
Widget _buildZigzagTimeline() {
  final List<Map<String, String>> stepDetails = [
    {"title": "Reported", "desc": "Issue has been submitted successfully."},
    {"title": "Assigned", "desc": "Task assigned to the responsible team."},
    {"title": "Inspection", "desc": "Team visited the site for review."},
    {"title": "In Review", "desc": "Details verified by authorities."},
    {"title": "Work Started", "desc": "Repair or cleanup work initiated."},
    {"title": "Halfway Done", "desc": "Progress reached midway completion."},
    {"title": "Verification", "desc": "Final checks by community members."},
    {"title": "Resolved", "desc": "Issue fixed and marked as resolved."},
  ];

  return Column(
    children: List.generate(stepDetails.length, (index) {
      final isCompleted = index <= stepDetails.indexWhere(
          (e) => e["title"] == widget.status,
        ) ||
        widget.status == "Resolved"; // mark all done if resolved
      final isLast = index == stepDetails.length - 1;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🟡 Left side - line & circle
          Column(
            children: [
              // Circle with check or index
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFFF9C802) : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  color: isCompleted ? Colors.white : Colors.grey[500],
                  size: isCompleted ? 16 : 10,
                ),
              ),
              // Connecting line
              if (!isLast)
                Container(
                  width: 2,
                  height: 50,
                  color: isCompleted ? const Color(0xFFF9C802) : Colors.grey[300],
                ),
            ],
          ),

          const SizedBox(width: 12),

          // 📝 Right side - text content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepDetails[index]["title"]!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? const Color(0xFF6C5C00)
                          : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stepDetails[index]["desc"]!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: isCompleted
                          ? Colors.black87
                          : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      );
    }),
  );
}


}
