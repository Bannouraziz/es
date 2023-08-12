import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');
  String verificationId = '';

  Future<void> _sendCode() async {
    if (await InternetConnectionChecker().hasConnection) {
      final String phoneNumber = _phoneNumber.phoneNumber!;

      final PhoneVerificationCompleted verified = (AuthCredential authResult) {
        // If the verification is completed automatically, handle sign-in directly
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        print('Verification Failed: ${authException.message}');
        // Handle verification failure here (e.g., show an error to the user)
      };

      final PhoneCodeSent codeSent =
          (String verificationId, int? resendToken) async {
        setState(() {
          this.verificationId = verificationId;
        });

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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
              left: 45,
              top: 250,
              child: SizedBox(
                width: 300,
                height: 250,
                child: Image.asset('img/5.png'),
              ),
            ),
            Positioned(
              left: 28,
              top: 520,
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
                    vertical: 14,
                  ),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      _phoneNumber = number;
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: InputBorder.none,
                    ),
                    textStyle: TextStyle(
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
                  '\nJoin Us',
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
              top: 640,
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

void main() {
  runApp(MailApp());
}
