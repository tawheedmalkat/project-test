import '../main.dart';

final String? storedToken = sharedPref?.getString('token');
final int? tokenTimestamp = sharedPref?.getInt('tokenTimestamp');

final DateTime now = DateTime.now();
final DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(tokenTimestamp!).add(Duration(days: 30));


class AppRoute {
   static String? start = storedToken != null && tokenTimestamp != null? now.isBefore(expirationDate)? "/start":"/":"/";
  // signIn.

  static String? signIn = storedToken != null && tokenTimestamp != null? now.isBefore(expirationDate)? "/login": "/":"/";

  // interface.
  static String? passcode = storedToken != null && tokenTimestamp != null? now.isBefore(expirationDate)? "/": "/passcode":"/";

}
