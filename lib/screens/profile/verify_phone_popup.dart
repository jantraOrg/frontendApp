import 'package:flutter/material.dart';

class VerifyPhonePopup extends StatefulWidget {
  const VerifyPhonePopup({super.key});

  @override
  State<VerifyPhonePopup> createState() => _VerifyPhonePopupState();
}

class _VerifyPhonePopupState extends State<VerifyPhonePopup> {
  bool otpSent = false;
  String phone = "";

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
              "Phone Verification",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF6C5C00),
              ),
            ),
            const SizedBox(height: 20),

            if (!otpSent)
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixText: "+91 ",
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFFF9C802)),
                  labelText: "Enter phone number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (val) => phone = val,
              )
            else
              _buildOtpField(),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9C802),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (!otpSent) {
                  if (phone.length == 10) {
                    setState(() => otpSent = true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter a valid 10-digit phone number")),
                    );
                  }
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("✅ Phone verified successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text(otpSent ? "Verify OTP" : "Send OTP"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField() {
    return Column(
      children: [
        const Text(
          "Enter the 6-digit OTP sent to your phone",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLength: 6,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: "------",
          ),
        ),
      ],
    );
  }
}
