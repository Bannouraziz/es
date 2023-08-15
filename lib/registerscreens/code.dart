import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:estichara/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:estichara/registerscreens/email.dart';
import 'package:google_fonts/google_fonts.dart'; 


class CodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  CodeScreen({required this.phoneNumber, required this.verificationId});

  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  bool _showErrorMessage = false;
  Future<void> _resendCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {};

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Verification Failed: ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      print('Verification Code Sent');
      print('Verification ID: $verificationId');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print('Auto Retrieval Timeout');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: Duration(seconds: 120),
    );
  }

  Future<void> _confirmCode(String verificationCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: verificationCode,
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('User signed in: ${userCredential.user?.uid}');
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
        (route) => false,
      );
    } catch (e) {
      print('Error signing in: $e');
      setState(() {
        _showErrorMessage = true; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 414,
                height: 896,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 28,
                      top: 80,
                      child: SizedBox(
                        width: 342,
                        child: Text(
                          'Enter Code',
                         style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                          ),
                         ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 7,
                      top: 27,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 150,
                      child: SizedBox(
                        width: 350,
                        height: 70,
                        child: Text(
                          'Enter the code that we had sent to ${widget.phoneNumber}',
                          style: GoogleFonts.poppins( 
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            height: 1,
                            letterSpacing: 0.25,
                          ),
                        ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 28,
                      top: 325,
                      child: Container(
                        width: 359,
                        height: 85,
                        decoration: ShapeDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 45,
                        top: 250,
                        child: SizedBox(
                          width: 300,
                          height: 250,
                          child: Image.asset('img/4.png'),
                        )),
                    Positioned(
                      left: 30,
                      top: 520,
                      child: SizedBox(
                        width: 348,
                        height: 83,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 10),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            onChanged: (value) {
                              if (_showErrorMessage) {
                                setState(() {
                                  _showErrorMessage = false;
                                });
                              }
                            },
                            onCompleted: _confirmCode,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 60,
                              fieldWidth: 48,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Color(0xFFC8C8C8),
                              selectedFillColor: Colors.white,
                            ),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 620,
                      child: _showErrorMessage
                          ? Text(
                              'Invalid code. Please try again.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                    Positioned(
                      left: 90,
                      top: 650,
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Resend code',
                            style: GoogleFonts.poppins( 
                            textStyle: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
