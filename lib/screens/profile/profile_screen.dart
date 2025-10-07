import 'package:flutter/material.dart';
import 'edit_profile_popup.dart';
import 'verify_email_popup.dart';
import 'verify_phone_popup.dart';
import 'verify_address_popup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double civilScore = 820; // Example score
  final String userName = "Aarav Patel";
  final String userPhone = "+91 98765 43210";

  bool aadhaarVerified = true;
  bool emailVerified = true;
  bool phoneVerified = false;
  bool addressVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9C802),
        elevation: 3,
        title: const Text(
          '👤 Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            // 🪪 Profile Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9C802), Color(0xFFFFF6B0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C5C00),
                    ),
                  ),
                  Text(
                    userPhone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8C7000),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C5C00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const EditProfilePopup(),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text(
                      "Edit Profile",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 💯 Civil Score
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE978), Color(0xFFF9C802)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      "CIVIL SCORE",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6C5C00),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      civilScore.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      civilScore >= 750
                          ? "Excellent Citizen! 🌟"
                          : "Keep Building Your Civic Impact 💪",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔐 Verification Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Verification Center",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF6C5C00),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildVerificationTile(
                    context: context,
                    icon: Icons.credit_card,
                    title: "Aadhaar Verification",
                    status: aadhaarVerified ? "✅ Verified" : "Pending",
                    points: "+100 pts",
                  ),
                  _buildVerificationTile(
                    context: context,
                    icon: Icons.email,
                    title: "Email Verification",
                    status: emailVerified ? "✅ Verified" : "Pending",
                    points: "+50 pts",
                  ),
                  _buildVerificationTile(
                    context: context,
                    icon: Icons.phone,
                    title: "Phone Verification",
                    status: phoneVerified ? "✅ Verified" : "Pending",
                    points: "+30 pts",
                  ),
                  _buildVerificationTile(
                    context: context,
                    icon: Icons.home,
                    title: "Address Verification",
                    status: addressVerified ? "✅ Verified" : "Not Done",
                    points: "+70 pts",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 📊 Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Contribution",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF6C5C00),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard("Complaints", "36", Icons.report_problem),
                      _buildStatCard("Verified", "22", Icons.verified),
                      _buildStatCard("Votes", "118", Icons.how_to_vote),
                      _buildStatCard("Points", "890", Icons.star),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🏅 Rewards Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Text(
                      "Badges & Rewards",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF6C5C00),
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        _Badge(icon: Icons.emoji_events, label: "Top 20 Hero"),
                        _Badge(icon: Icons.verified_user, label: "Trusted Citizen"),
                        _Badge(icon: Icons.flash_on, label: "Quick Reporter"),
                        _Badge(icon: Icons.handshake, label: "Community Helper"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ⚙️ Settings Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildSettingsTile(Icons.notifications, "Notification Settings"),
                  _buildSettingsTile(Icons.policy, "Privacy Policy"),
                  _buildSettingsTile(Icons.logout, "Logout"),
                  _buildSettingsTile(Icons.delete_forever, "Delete Account"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Helper Widgets
  Widget _buildVerificationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String status,
    required String points,
  }) {
    final bool isVerified = status.contains("✅");

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFF9C802)),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        subtitle: Text(status, style: const TextStyle(color: Colors.grey)),
        trailing: Text(
          points,
          style: TextStyle(
            color: isVerified ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        onTap: () {
          if (!isVerified) {
            if (title == "Email Verification") {
              showDialog(
                context: context,
                builder: (context) => const VerifyEmailPopup(),
              );
            } else if (title == "Phone Verification") {
              showDialog(
                context: context,
                builder: (context) => const VerifyPhonePopup(),
              );
            } else if (title == "Address Verification") {
              showDialog(
                context: context,
                builder: (context) => const VerifyAddressPopup(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFFF9C802).withOpacity(0.9),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6C5C00)),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {},
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Badge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFFF9C802),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Color(0xFF6C5C00),
          ),
        ),
      ],
    );
  }
}
