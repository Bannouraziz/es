import 'package:flutter/material.dart';

class Onbordingpage2 extends StatelessWidget {
  const Onbordingpage2({Key? key}) : super(key: key);

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
            left: 61,
            top: 487,
            child: SizedBox(
              width: 294,
              child: Text(
                'We offer a fresh set of 10 thought-provoking questions every month, ensuring engaging and relevant content.',
                style: TextStyle(
                  color: Color(0xFFFF8F51),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: 125,
            top: 792,
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 35,
                    height: 12,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 60,
                    height: 12,
                    decoration: ShapeDecoration(
                      color: Color(0xD6FF9051),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 35,
                    height: 12,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 112,
            top: 690,
            child: Container(
              width: 193,
              height: 54,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 193,
                      height: 54,
                      decoration: ShapeDecoration(
                        color: Color(0xD8FF9051),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 11,
                    child: SizedBox(
                      width: 113,
                      height: 43,
                      child: Text(
                        'Continue',
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
            left: 0,
            top: 0,
            child: Container(
              width: 414,
              height: 395,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('img/2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 47,
            top: 378,
            child: SizedBox(
              width: 294,
              height: 77,
              child: Text(
                'Curated \nWeekly Polls',
                style: TextStyle(
                  color: Color(0xFFFF8F51),
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
