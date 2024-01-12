import 'package:http/http.dart' as http;
import 'package:jsondata_ex01/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Repository {
  static const url = 'https://jsonplaceholder.typicode.com/users';
  static Future<List<User>> getInfo() async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List<User> users = userFromJson(res.body); //res.body는 String이다.
        return users;
      } else {
        Fluttertoast.showToast(msg: 'Error occurred. Please try again');
        return []; // <User>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }
}
