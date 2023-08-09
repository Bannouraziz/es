import 'package:flutter/material.dart';

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set the background color to orange
      appBar: AppBar(
        title: Text('Estichara'),
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove app bar shadow
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Handle the "Take Survey" button's onPressed event
                // Navigate to the survey page or perform appropriate action
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Button color
                onPrimary: Colors.orange, // Text color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text('Take Survey'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the "View Results" button's onPressed event
                // Navigate to the results page or perform appropriate action
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Button color
                onPrimary: Colors.orange, // Text color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text('View Results'),
            ),
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
