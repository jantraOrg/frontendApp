import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  List<File> _images = [];
  File? _video;
  String? _description;
  Position? _position;
  bool _isLoadingLocation = false;

  final List<String> categories = [
    "Open Drain",
    "Potholes",
    "Open Garbage",
    "Street Light Issue",
    "Illegal Parking",
    "Water Leakage",
    "Broken Road",
    "Others"
  ];

  final picker = ImagePicker();

  // 📍 Get Location
  Future<void> _getLocation() async {
    setState(() => _isLoadingLocation = true);
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable location services")),
      );
      setState(() => _isLoadingLocation = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );
        setState(() => _isLoadingLocation = false);
        return;
      }
    }

    _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() => _isLoadingLocation = false);
  }

  // 📸 Capture Photo
  Future<void> _capturePhoto() async {
    if (_images.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can upload max 3 photos")),
      );
      return;
    }

    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _images.add(File(pickedFile.path)));
    }
  }

  // 🎥 Capture Video
  Future<void> _captureVideo() async {
    final pickedVideo = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 10),
    );
    if (pickedVideo != null) {
      setState(() => _video = File(pickedVideo.path));
    }
  }

  // 💾 Submit Report
  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload at least 1 photo")),
        );
        return;
      }
      if (_position == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please capture your location")),
        );
        return;
      }

      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Report Submitted Successfully")),
      );
    }
  }

  bool get _isReadyToSubmit =>
      _selectedCategory != null &&
      _images.isNotEmpty &&
      _description != null &&
      _description!.isNotEmpty &&
      _position != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        title: const Text(
          "Report an Issue",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF9C802),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Submit a Civic Issue",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C5C00),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🗂️ Category Selector
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Select Category",
                        labelStyle: const TextStyle(fontFamily: 'Poppins'),
                        filled: true,
                        fillColor: const Color(0xFFFFFBE6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      value: _selectedCategory,
                      items: categories
                          .map((c) =>
                              DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedCategory = value),
                      validator: (value) =>
                          value == null ? "Please select a category" : null,
                    ),

                    const SizedBox(height: 20),

                    // 📸 Photo Upload
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Upload Photos (1–3)",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        ..._images.map(
                          (file) => Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  file,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _images.remove(file)),
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close,
                                        size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _capturePhoto,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBE6),
                              border: Border.all(color: const Color(0xFFF9C802)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.camera_alt,
                                size: 30, color: Color(0xFFF9C802)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🧭 Location Capture
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            _position == null
                                ? (_isLoadingLocation
                                    ? "Fetching location..."
                                    : "No location captured")
                                : "📍 ${_position!.latitude.toStringAsFixed(4)}, ${_position!.longitude.toStringAsFixed(4)}",
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _getLocation,
                          icon: const Icon(Icons.location_on),
                          label: const Text("Get Location"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF9C802),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 📝 Description
                    TextFormField(
                      maxLines: 3,
                      maxLength: 300,
                      decoration: InputDecoration(
                        hintText: "Describe the issue briefly (max 50 words)",
                        filled: true,
                        fillColor: const Color(0xFFFFFBE6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a short description";
                        }
                        if (value.split(" ").length > 50) {
                          return "Maximum 50 words allowed";
                        }
                        return null;
                      },
                      onChanged: (val) => setState(() => _description = val),
                    ),

                    const SizedBox(height: 30),

                    // 🚀 Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.send_rounded),
                        label: const Text(
                          "Submit Report",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isReadyToSubmit
                              ? const Color(0xFFF9C802)
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isReadyToSubmit ? _submitReport : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
