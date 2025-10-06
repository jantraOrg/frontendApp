import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController =
      TextEditingController(text: '+91');
  final TextEditingController otpController = TextEditingController();

  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF9C802), Color(0xFFFFF9E6)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Logo
                  Image.asset(
                    'assets/images/main_logo.png',
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Welcome Back to JANTRA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF6C5C00),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'The Machine That Belongs to Truth',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9C8C40),
                      letterSpacing: 1.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Phone Field Row (with fixed +91)
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: countryCodeController,
                          readOnly: true, // fixed +91
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xFF8C7000),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(
                              color: Color(0xFF8C7000),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // OTP Field (appears after sending OTP)
                  if (otpSent) ...[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Enter OTP',
                          labelStyle: const TextStyle(
                            color: Color(0xFF8C7000),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_open_rounded,
                            color: Color(0xFF8C7000),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Action Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9C802),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFFF9C802).withOpacity(0.4),
                    ),
                    onPressed: () {
                      if (!otpSent) {
                        // Validate phone before sending OTP
                        if (phoneController.text.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please enter a valid 10-digit number')),
                          );
                          return;
                        }
                        setState(() => otpSent = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OTP sent successfully')),
                        );
                      } else {
                        // OTP verification (mock)
                        if (otpController.text.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter the 6-digit OTP')),
                          );
                          return;
                        }
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    child: Text(
                      otpSent ? 'Verify & Login' : 'Send OTP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Sign Up Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7C6C30),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, '/role'),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8C7000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Tagline
                  const Text(
                    'Powered by Citizens. Driven by Truth.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB8A870),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
