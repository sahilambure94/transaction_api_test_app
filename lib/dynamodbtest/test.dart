import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> postData(String text) async {
    var apiUrl = Uri.parse(
        'https://lin3jiddaf.execute-api.ap-south-1.amazonaws.com/DynamoDBAPIDeployStage/dynamodblambdatest');

    // Create the request body
    var requestBody = jsonEncode({'text': text});

    try {
      var response = await http.post(
        apiUrl,
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Data stored in DynamoDB successfully');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  TextEditingController textInput = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textInput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 400.0, left: 50, right: 50),
          child: Column(children: [
            TextFormField(
              controller: textInput,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            TextButton(
                onPressed: () async {
                  await postData(textInput.text);
                },
                child: Text("Submit "))
          ]),
        ),
      ),
    );
  }
}
