import 'package:flutter/material.dart';

class VerifyAddressPopup extends StatefulWidget {
  const VerifyAddressPopup({super.key});

  @override
  State<VerifyAddressPopup> createState() => _VerifyAddressPopupState();
}

class _VerifyAddressPopupState extends State<VerifyAddressPopup> {
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Address Verification",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF6C5C00),
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Enter your full address",
                prefixIcon: const Icon(Icons.home, color: Color(0xFFF9C802)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val) => address = val,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9C802),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (address.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter a valid address")),
                  );
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("✅ Address submitted for verification."),
                      backgroundColor: Colors.orangeAccent,
                    ),
                  );
                }
              },
              child: const Text("Submit for Verification"),
            ),
          ],
        ),
      ),
    );
  }
}
