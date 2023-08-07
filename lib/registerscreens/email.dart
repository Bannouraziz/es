import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'code.dart';

class MailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MailScreen(),
    );
  }
}

class MailScreen extends StatefulWidget {
  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String verificationId = ''; // Variable to store the verification ID

  Future<void> _sendCode() async {
    final String phoneNumber = _phoneNumberController.text;

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      // If the verification is completed automatically (e.g., using a test device)
      // you can handle the sign-in directly here.
      // Otherwise, the user should proceed to the CodeScreen to enter the code manually.
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Verification Failed: ${authException.message}');
      // Handle verification failure here (e.g., show an error to the user)
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      // Save the verification ID to be used in the CodeScreen
      setState(() {
        this.verificationId = verificationId;
      });

      // Navigate to the CodeScreen to enter the verification code
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CodeScreen(
            phoneNumber: phoneNumber,
            verificationId: verificationId,
          ),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Timeout for code auto-retrieval, if needed
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 414,
        height: 896,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 28,
              top: 334,
              child: Container(
                width: 359,
                height: 80,
                decoration: ShapeDecoration(
                  color: Color(0xFFC8C8C8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10,
                  ),
                  child: TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 42,
              child: SizedBox(
                width: 337,
                height: 145,
                child: Text(
                  '\nParticipate',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 198,
              child: SizedBox(
                width: 342,
                height: 60,
                child: Text(
                  'Enter your phone number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 125,
              top: 460,
              child: SizedBox(
                width: 167,
                height: 50,
                child: ElevatedButton(
                  onPressed: _sendCode,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Send Code',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
