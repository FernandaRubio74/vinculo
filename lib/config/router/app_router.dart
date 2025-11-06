import 'package:flutter/material.dart';
import 'package:vinculo/screens/elderly/active_volunteers_screen.dart';
import 'package:vinculo/screens/elderly/activities_elderly_screen.dart';
import 'package:vinculo/screens/elderly/home_elderly_screen.dart';
import 'package:vinculo/screens/elderly/profile_elderly_screen.dart';
import 'package:vinculo/screens/elderly/videocall_screen.dart';
import 'package:vinculo/screens/landig_screen.dart';
import 'package:vinculo/screens/login_screen.dart';
import 'package:vinculo/screens/register_screen.dart';
import 'package:vinculo/screens/role_selection_screen.dart';
import 'package:vinculo/screens/elderly/register_elderly_screen.dart';
import 'package:vinculo/screens/settings_screen.dart';
import 'package:vinculo/screens/volunteer/register_volunteer_screen.dart';
import 'package:vinculo/screens/volunteer/volunteer_home_screen.dart';
import 'package:vinculo/screens/volunteer/matches_screen.dart';
import 'package:vinculo/screens/volunteer/rewards_screen.dart';
import 'package:vinculo/screens/volunteer/profile_screen.dart';
import 'package:vinculo/screens/volunteer/history_screen.dart';
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
  static const String homeElderly = '/home_elderly';
  static const String activitiesElderly = '/activities_elderly';
  static const String profileElderly = '/profile_elderly';
  static const String settingsElderly = '/settings_elderly';
  static const String videoCall = '/video_call';
  static const String settings = '/settings';
  static const String volunteers = '/active_volunteers';


  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterGeneralScreen(),
    roles: (context) => const RoleSelectionScreen(),
    videoCall: (context) => const VideoCallScreen(),
    settings: (context) => const SettingsScreen(),

    // Rutas para voluntarios
    registerVolunteer: (context) => const RegisterVolunteerScreen(),
    registrationSuccess: (context) => const RegistrationSuccessScreen(userType: 'volunteer'),
    volunteerHome: (context) => const VolunteerHomeScreen(),
    matches: (context) => const MatchesScreen(),
    rewards: (context) => const RewardsScreen(),
    profile: (context) => const ProfileScreen(),
    history: (context) => const HistoryScreen(),

    //Rutas para adultos mayores
    registerElderly: (context) => const RegisterElderlyScreen(),
    homeElderly: (context) => const HomeElderlyScreen(),
    activitiesElderly: (context) => const ActivitiesScreen(),
    profileElderly: (context) => const ProfileElderlyScreen(),
    volunteers: (context) => const VolunteersScreen(),
  };
}