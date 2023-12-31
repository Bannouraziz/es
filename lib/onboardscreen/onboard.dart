import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:Estichara/registerscreens/phone.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(
      color: Colors.orange,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    );

    final TextStyle descriptionStyle = TextStyle(
      color: Colors.black54,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );

    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MailScreen(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.orange,
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Participate',
        style: TextStyle(
          fontSize: 16,
          color: Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MailScreen(),
          ),
        );
      },
      controllerColor: Colors.orange,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Icon(
          Icons.ballot,
          size: 120,
          color: Colors.orange,
        ),
        Icon(
          Icons.check_circle,
          size: 120,
          color: Colors.orange,
        ),
        Icon(
          Icons.pie_chart,
          size: 120,
          color: Colors.orange,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Estichara',
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
              SizedBox(height: 20),
              Text(
                'Thank you for joining our global community. Your opinion matters.',
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Curated Weekly Polls',
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
              SizedBox(height: 20),
              Text(
                'Explore curated surveys and vote on important global issues.',
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'User-friendly charted statistics.',
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
              SizedBox(height: 20),
              Text(
                'Every weekend, you can access authentic survey statistics.',
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
