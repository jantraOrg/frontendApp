import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController =
      TextEditingController(text: '+91');

  // Aadhaar Controllers
  final TextEditingController aadhaar1 = TextEditingController();
  final TextEditingController aadhaar2 = TextEditingController();
  final TextEditingController aadhaar3 = TextEditingController();

  bool useKyc = false;

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  const Text(
                    'Create Your Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C5C00),
                      letterSpacing: 0.5,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    useKyc
                        ? 'Sign up with Aadhaar Verification'
                        : 'Sign up with your Phone Number',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9C8C40),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // PHONE SIGNUP ---------------------------------------------------
                  if (!useKyc) ...[
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: countryCodeController,
                            readOnly: true, // ✅ now fixed
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
                            maxLength: 10, // ✅ limit to 10 digits
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              counterText: '', // ✅ hide the character counter
                              labelText: 'Phone Number',
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF9C802),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                      onPressed: () {
  if (phoneController.text.length != 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
    );
    return;
  }
  // TODO: Send OTP logic here
  Navigator.pushNamed(context, '/otp'); // ✅ open OTP screen
},

                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                  // AADHAAR SIGNUP ------------------------------------------------
                  else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _aadhaarBox(aadhaar1, next: aadhaar2),
                        _aadhaarBox(aadhaar2,
                            next: aadhaar3, previous: aadhaar1),
                        _aadhaarBox(aadhaar3, previous: aadhaar2),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF9C802),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        // TODO: Aadhaar KYC verification logic
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      icon: const Icon(Icons.verified, color: Colors.white),
                      label: const Text(
                        'Verify & Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 25),

                  // Toggle Signup Method
                  TextButton(
                    onPressed: () {
                      setState(() => useKyc = !useKyc);
                    },
                    child: Text(
                      useKyc
                          ? 'Use Phone Signup Instead'
                          : 'Use Aadhaar KYC Signup',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8C7000),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7C6C30),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text(
                          "Login",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for Aadhaar segmented input
  Widget _aadhaarBox(TextEditingController controller,
      {TextEditingController? next, TextEditingController? previous}) {
    return SizedBox(
      width: 90,
      child: TextField(
        controller: controller,
        maxLength: 4,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // ✅ allow digits only
          LengthLimitingTextInputFormatter(4),
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: 'XXXX',
          labelStyle: const TextStyle(
            color: Color(0xFF8C7000),
            fontFamily: 'Poppins',
          ),
        ),
        onChanged: (val) {
          // Move to next box when 4 digits typed
          if (val.length == 4 && next != null) {
            FocusScope.of(context).nextFocus();
          }
          // Move back if field is empty and user pressed backspace
          if (val.isEmpty && previous != null) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
