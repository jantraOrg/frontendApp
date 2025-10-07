import 'package:flutter/material.dart';

class VerifyEmailPopup extends StatefulWidget {
  const VerifyEmailPopup({super.key});

  @override
  State<VerifyEmailPopup> createState() => _VerifyEmailPopupState();
}

class _VerifyEmailPopupState extends State<VerifyEmailPopup> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool otpSent = false;

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
              "Email Verification",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF6C5C00),
              ),
            ),
            const SizedBox(height: 20),

            if (!otpSent)
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Color(0xFFF9C802)),
                    labelText: "Enter your email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (val) => val!.contains('@') ? null : 'Enter a valid email',
                  onSaved: (val) => email = val!,
                ),
              )
            else
              _buildOtpField(),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9C802),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (!otpSent) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() => otpSent = true);
                  }
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("✅ Email verified successfully!"),
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
          "Enter the 6-digit OTP sent to your email",
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
