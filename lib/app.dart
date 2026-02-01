import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/admin/admin_home_screen.dart';
import 'screens/public/public_home_screen.dart';
import 'screens/select_role.dart';
import 'screens/splash_screen.dart';
import 'screens/volunteer/volunteer_home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rapid Incident Response",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/role': (context) => const SelectRole(),
        '/public': (context) => const PublicHomeScreen(),
        '/volunteer': (context) => const VolunteerHomeScreen(),
        '/admin': (context) => const AdminSuggestionScreen(),
      },
    );
  }
}
