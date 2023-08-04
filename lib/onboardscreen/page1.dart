import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            left: 20,
            top: 83,
            child: SizedBox(
              width: 310,
              height: 69,
              child: Text(
                'Welcome',
                style: TextStyle(
                  color: Color(0xFFFF8F51),
                  fontSize: 64,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 87,
            top: 690,
            child: Container(
              width: 254,
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 254,
                      height: 60,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFA06B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    top: 12,
                    child: SizedBox(
                      width: 198,
                      height: 48,
                      child: Text(
                        'Let\'s get started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 109,
            top: 792,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 12,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 60,
                            height: 12,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF8F51),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 0,
                          child: Container(
                            width: 35,
                            height: 12,
                            decoration: ShapeDecoration(
                              color: Color(0xFFE0E0E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 115,
                          top: 0,
                          child: Container(
                            width: 35,
                            height: 12,
                            decoration: ShapeDecoration(
                              color: Color(0xFFE0E0E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
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
          Positioned(
            left: 20,
            top: 198,
            child: SizedBox(
              width: 235,
              height: 220,
              child: Text(
                'We’re glad that you are here',
                style: TextStyle(
                  color: Color(0xFFFF8F51),
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: -8,
            top: 268,
            child: Container(
              width: 431,
              height: 408,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage("img/1.png"), // Replace with actual asset path
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
