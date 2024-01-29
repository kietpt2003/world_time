import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_time/features/app/splash_screen/splash_screen.dart';
import 'package:world_time/features/user_auth/presentation/pages/home_page.dart';
import 'package:world_time/features/user_auth/presentation/pages/login_page.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDp0Ow8CzrWTMy0Dndd8Lng_6dNs78aYSA",
      projectId: "flutterfirebase-faed4",
      messagingSenderId: "1032027946166",
      appId: "1:1032027946166:android:dd091144615b671471fa17",
    ),
  );
  // final providers = [EmailAuthProvider()];
  // runApp(MaterialApp(
  //   initialRoute: '/',
  //   routes: {
  //     '/': (context) => Loading(),
  //     '/home': (context) => Home(),
  //     '/location': (context) => ChooseLocation(),
  //     '/sign-in': (context) {
  //       return SignInScreen(
  //         providers: providers,
  //         actions: [
  //           AuthStateChangeAction<SignedIn>((context, state) {
  //             Navigator.pushReplacementNamed(context, '/profile');
  //           }),
  //         ],
  //       );
  //     },
  //     '/profile': (context) {
  //       return ProfileScreen(
  //         providers: providers,
  //         actions: [
  //           SignedOutAction((context) {
  //             Navigator.pushReplacementNamed(context, '/sign-in');
  //           }),
  //         ],
  //       );
  //     },
  //   },
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      },
      title: 'Flutter Firebase',
      home: const SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}
