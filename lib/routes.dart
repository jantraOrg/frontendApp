import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/report/report_screen.dart';
import 'screens/verify/verify_screen.dart';
import 'screens/vote/vote_screen.dart';
import 'screens/leaderboard/leaderboard_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/auth/role_selection_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  
  '/intro': (context) => const IntroSplash(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/home': (context) => const HomeScreen(),
  '/report': (context) => const ReportScreen(),
  '/verify': (context) => const VerifyScreen(),
  '/vote': (context) => const VoteScreen(),
  '/leaderboard': (context) => const LeaderboardScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/role': (context) => const RoleSelectionScreen(),

};
