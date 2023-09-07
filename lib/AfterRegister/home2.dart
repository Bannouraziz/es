import 'package:flutter/material.dart';
import 'package:Estichara/surveys/surveysscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  bool _canVote =
      true; // Initialize as true, or fetch initial value from your Firestore

  Future<void> checkCanVote() async {
    DocumentSnapshot canVoteDoc = await FirebaseFirestore.instance
        .collection('can_survey')
        .doc('can_vote')
        .get();
    bool canVote = canVoteDoc.get('voting');
    setState(() {
      _canVote = canVote;
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch the canVote status when the widget is first created
    checkCanVote();
  }

  @override
  Widget build(BuildContext context) {
    int days = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: MediaQuery.of(context).size.height * 0.0001,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.asset('img/2.jpg', fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.60,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_canVote) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SurveyScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.grey,
                                content: Text(
                                    'Voting has ended , you can check statistics '),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _canVote ? Colors.orange : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _canVote ? 'Participate' : 'Voting Ended ',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: MediaQuery.of(context).size.height * 0.63,
                  //   left: MediaQuery.of(context).size.width * 0.15,
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     height: MediaQuery.of(context).size.height * 0.15,
                  //     child: Text(
                  //       "RM : Still $days days before changing surveys",
                  //       style: GoogleFonts.lato(
                  //         textStyle: TextStyle(
                  //           color: Colors.red,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
