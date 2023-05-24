import 'dart:async';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';

class Services {
  //String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId = "ATYPlwZnHnD0Apb9CEASsKh4Ps0yUlCAofJlXjucfj-4d8umXc0bbepyGG033co6fTHjLphtZ9F62_2z";
  String secret = "EHXg8T3F_ytSzGv2nmu9Ve5QXFD8Ykz6dbMrlx-8nurLxzY20zcLJPzFgMNk82HPmH_4OxAHMQcAXD3z";

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(transactions, accessToken) async {
    try {
      var response = await http.post(Uri.https("api.paypal.com", '/v1/payments/payment'),
          body: convert.jsonEncode(transactions), headers: {"content-type": "application/json", 'Authorization': 'Bearer ' + accessToken});

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url", orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute", orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return {};
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}), headers: {"content-type": "application/json", 'Authorization': 'Bearer ' + accessToken});

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(Uri.https("api.paypal.com", '/v1/oauth2/token', {'grant_type': 'client_credentials'}));

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }
}