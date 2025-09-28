import 'package:flutter/material.dart';
import 'package:vinculo/screens/landig_screen.dart';
import 'package:vinculo/screens/login_screen.dart';
import 'package:vinculo/screens/register_screen.dart';
import 'package:vinculo/screens/role_selection_screen.dart';
import 'package:vinculo/screens/elderly/register_elderly_screen.dart';
import 'package:vinculo/screens/volunteer/register_volunteer_screen.dart';
import 'package:vinculo/screens/volunteer/volunteer_home_screen.dart';
import 'package:vinculo/screens/volunteer/matches_screen.dart';
import 'package:vinculo/screens/volunteer/rewards_screen.dart';
import 'package:vinculo/screens/volunteer/profile_screen.dart';
import 'package:vinculo/screens/volunteer/history_screen.dart';
import 'package:vinculo/screens/volunteer/contact_profile_screen.dart';
import 'package:vinculo/screens/registration_success_screen.dart';

class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/registro';
  static const String roles = '/roles';
  static const String registerElderly = '/register_elderly';
  static const String registerVolunteer = '/register_volunteer';
  static const String registrationSuccess = '/registration_success';
  static const String volunteerHome = '/volunteer_home';
  static const String matches = '/matches';
  static const String rewards = '/rewards';
  static const String profile = '/profile';
  static const String history = '/history';
  static const String contactProfile = '/contact_profile';

  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterGeneralScreen(),
    roles: (context) => const RoleSelectionScreen(),
    registerElderly: (context) => const RegisterElderlyScreen(),
    registerVolunteer: (context) => const RegisterVolunteerScreen(),
    registrationSuccess: (context) => const RegistrationSuccessScreen(userType: 'volunteer'),
    volunteerHome: (context) => const VolunteerHomeScreen(),
    matches: (context) => const MatchesScreen(),
    rewards: (context) => const RewardsScreen(),
    profile: (context) => const ProfileScreen(),
    history: (context) => const HistoryScreen(),
  };
}