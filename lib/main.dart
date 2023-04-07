import 'package:firebase_core/firebase_core.dart';
import 'package:myinsta/providers/user_provider.dart';
import 'package:myinsta/resources/auth_methods.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
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
        apiKey: "AIzaSyAZ7g2BuxHXi0Pn7S_IQpNEJVG8Kih65JQ",
        authDomain: "myinsta-b4476.firebaseapp.com",
        projectId: "myinsta-b4476",
        storageBucket: "myinsta-b4476.appspot.com",
        messagingSenderId: "579029137093",
        appId: "1:579029137093:web:52ea948027df3e97b762ac",
        measurementId: "G-YC8P2ZB5CD",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Insta',
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
