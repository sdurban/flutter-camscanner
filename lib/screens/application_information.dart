import 'package:flutter/material.dart';

class ApplicationInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PAC 5",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "Sergio Durban Belmonte",
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: "This application is part of the ",
                children: [
                  const TextSpan(text: "PAC5", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: " - "),
                  const TextSpan(text: "Activity 5", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: " - "),
                  const TextSpan(text: "Exercise 3", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: " - "),
                  const TextSpan(text: "Capstone Project", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ". \n\nThis application implements"),
                  const TextSpan(text: " multiple flutter plugins ", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: "for making a CamScanner "),
                  const TextSpan(text: "app-like", style: TextStyle(fontStyle: FontStyle.italic)),
                  const TextSpan(text: " with three basic functions: "),
                  const TextSpan(text: "Scanning documents (to PDF)", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ","),
                  const TextSpan(text: " printing", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ","),
                  const TextSpan(text: " sharing file", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: " and"),
                  const TextSpan(text: " image-to-text", style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: "."),
                ],
                style: Theme.of(context).textTheme.bodyText2,
              )
            )
          ],
        ),
      ),
    );
  }
}
