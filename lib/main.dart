import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myinsta/responsive/mobile_screen_layout.dart';
import 'package:myinsta/responsive/responsive_layout.dart';
import 'package:myinsta/responsive/web_screen_layout.dart';
import 'package:myinsta/screens/login_screen.dart';
import 'package:myinsta/screens/signup_screen.dart';
import 'package:myinsta/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      // only for web
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAZ7g2BuxHXi0Pn7S_IQpNEJVG8Kih65JQ',
        appId: "1:579029137093:web:52ea948027df3e97b762ac",
        messagingSenderId: "579029137093",
        projectId: "myinsta-b4476",
        storageBucket: "myinsta-b4476.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Insta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      home: const SignupScreen(),
    );
  }
}
