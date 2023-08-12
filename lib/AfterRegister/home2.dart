import 'package:flutter/material.dart';
import 'package:estichara/AfterRegister/statistics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estichara/surveys/surveysscreen.dart';

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int days = 0;
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to orange

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 600,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image.asset('img/2.jpg'),
                    ),
                  ),
                  Positioned(
                    top: 450,
                    left: MediaQuery.of(context).size.width / 3.5,
                    child: SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SurveyScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Participate',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 530,
                    left: 60,
                    child: Container(
                      width: 300,
                      height: 150,
                      child: Text(
                        "RM : Still $days days before changing surveys",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Home2(),
  ));
}
