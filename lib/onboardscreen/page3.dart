import 'package:flutter/material.dart';

class Onbordingpage3 extends StatelessWidget {
  const Onbordingpage3({Key? key}) : super(key: key);

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
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 125,
            top: 792,
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 423,
            child: SizedBox(
              width: 342,
              height: 71,
              child: Text(
                'Make an impact with your opinions!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFF8F51),
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 535,
            child: SizedBox(
              width: 294,
              child: Text(
                'Join our Community',
                textAlign: TextAlign.center,
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
            left: 119,
            top: 672,
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 7),
              decoration: ShapeDecoration(
                color: Color(0xD8FF9051),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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
              width: 404,
              height: 384,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('img/3.png'),
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
