import 'package:flutter/material.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.black,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // Lottie.asset(
          //   'assets/no_internet.json',
          // ),
          SizedBox(
            width: 200,
            height: 200,
          ),
          SizedBox(width: 10),
          Text(
            'Oops!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      content: Text(
        'Please connect to the internet',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
