import 'package:get/get.dart';
import 'package:invoportapp/UI/screens/start-page.dart';
import 'UI/screens/Home.dart';
import 'UI/screens/Interface.dart';
import 'UI/screens/login.dart';
import 'UI/screens/pass-code.dart';

import 'constance/routes.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.start!, page: () => Start()),
  // Auth
  GetPage(name: AppRoute.signIn!, page: () => LogIn()),

  // Home
  GetPage(name: AppRoute.passcode!, page: () => PasswordScreen()),

];
