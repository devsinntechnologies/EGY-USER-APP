import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;


class APIManager{
    
  /// Get Play List API
  static getRTCToken(context) async {
    try {
      // debugger();
      var url = Uri.parse( "http://192.168.31.142:5000/rtc/channel/audience/userAccount/2");
      // debugger();
      var response = await http.get(url);
// debugger();
      var res = jsonDecode(response.body);

      
// debugger();
      print(res);
      return res["rtcToken"];
    } catch (e) {
      print(e);
      debugger();
      // showSnackBar(context, e.toString());
    }
  }

}