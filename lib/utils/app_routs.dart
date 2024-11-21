import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';
import 'package:spotify/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';
import 'package:spotify/presentation/home/pages/root_page.dart';
import 'package:spotify/presentation/intro/pages/get_started.dart';
import 'package:spotify/presentation/profile/pages/profile_page.dart';
import 'package:spotify/presentation/splash/pages/splash.dart';

class AppRouts {
  static final routes = {
    "/": (context) => const SplashPage(),
    "/GetStartedPage": (context) => const GetStartedPage(),
    "/ChooseModePage": (context) => const ChooseModePage(),
    "/SignupOrSignin": (context) => const SignupOrSignin(),
    "/SignupPage": (context) => SignupPage(),
    "/SigninPage": (context) => SigninPage(),
    "/RootPage": (context) => const RootPage(),
    "/ProfilePage": (context) => const ProfilePage(),
  };
}
