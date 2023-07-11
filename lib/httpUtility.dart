import 'package:http/http.dart' as http;

class HttpUtility {
  Future<String> httpGet(
      {required String server,
      required String path,
      required Map<String, dynamic> queryParams,
      required Map<String, String> headers}) async {
    var url = Uri.https(server, path);
    return http.get(url, headers: headers).then((value) {
      if (value.statusCode != 200) {
        print("Value Body:+${value.body}");

        print("Value from Get,statusCode,body: ");
        print(value.statusCode);
        print(value.body);
        throw Exception(
            "Received Bad Request from the endpoint for Get request:${value.statusCode}");
      }
      return value.body;
    }, onError: (value) {
      print("http exception");
      print(value);
      return "";
    });
  }
}

// class HttpUtility {
//   Future<String> httpGet(
//       {required String server,
//       required String path,
//       required Map<String, dynamic> queryParams,
//       required Map<String, String> headers}) async {
//     var url = Uri.https(server, path, queryParams);
//     return http.get(url, headers: headers).then((value) {
//       if (value.statusCode != 200) {
//         print("Value Body:+${value.body}");

//         print("Value from Get,statusCode,body: ");
//         print(value.statusCode);
//         print(value.body);
//         throw Exception(
//             "Received Bad Request from the endpoint for Get request:${value.statusCode}");
//       }
//       return value.body;
//     }, onError: (value) {
//       print("http exception");
//       print(value);
//       return "";
//     });
//   }
//   var headers = {

//   'Content-Type': 'application/json'

// };

// var request = http.Request('GET', Uri.parse('https://7eddyv0ckk.execute-api.ap-south-1.amazonaws.com/transactionDeployTest/transactions?transactionId=udayan1&type=SELL&amount=400'));




// request.headers.addAll(headers);




// http.StreamedResponse response = await request.send();




// if (response.statusCode == 200) {

//   print(await response.stream.bytesToString());

// }

// else {

//   print(response.reasonPhrase);

// }
// }