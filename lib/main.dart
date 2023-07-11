import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:transaction_api_test_app/httpUtility.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final imageUrlProvider = StateProvider((ref) {
  String image = '';
  return image;
});

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  HttpUtility hp = HttpUtility();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Image from S3',
            ),
            Image.network(
              ref.read(imageUrlProvider) == ''
                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Insignia_of_ARVN_II_Corps.svg/1200px-Insignia_of_ARVN_II_Corps.svg.png'
                  : ref.read(imageUrlProvider),
              height: 200,
              width: 200,
            ),
            FloatingActionButton(
                onPressed: () async {
                  var server =
                      "xurj2qrgd3.execute-api.ap-south-1.amazonaws.com";
                  var path = "/s3FlutterDeployStageTest/s3flutterapir";
                  // var queryParams = {};
                  var headers = {
                    "Content-Type": "application/json",
                  };
                  try {
                    var uri = Uri.https(server, path);
                    var response = await http.get(uri, headers: headers);

                    if (response.statusCode == 200) {
                      final responseBody = response.body;
                      dynamic json = jsonDecode(responseBody);
                      debugPrint(json["body"]);
                      // Handle successful response
                      debugPrint("Response: ${response.body}");
                      setState(() {
                        ref.read(imageUrlProvider.notifier).state =
                            json["body"];
                      });
                      print("hwllo+${ref.read(imageUrlProvider)}}");
                    } else {
                      // Handle error response
                      print("Error: ${response.statusCode}");
                    }
                  } catch (error) {
                    // Handle exceptions
                    print("Exception: $error");
                  }
                  // var request = http.Request(
                  //     'GET',
                  //     Uri.parse(
                  //         'https://7eddyv0ckk.execute-api.ap-south-1.amazonaws.com/transactionDeployTest/transactions?transactionId=sahilwonder&type=SELL&amount=333'));
                  // Future<http.StreamedResponse> response = request.send();
                },
                child: const Text("Get")),
          ],
        ),
      ),
    );
  }
}
