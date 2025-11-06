import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/screens/elderly/active_volunteers_screen.dart';
import 'package:vinculo/screens/elderly/activities_elderly_screen.dart';
import 'package:vinculo/screens/elderly/home_elderly_screen.dart';
import 'package:vinculo/screens/elderly/profile_elderly_screen.dart';
import 'package:vinculo/screens/elderly/register_elderly_screen.dart';
import 'package:vinculo/screens/elderly/videocall_screen.dart';
import 'package:vinculo/screens/landig_screen.dart';
import 'package:vinculo/screens/login_screen.dart';
import 'package:vinculo/screens/register_screen.dart';
import 'package:vinculo/screens/registration_success_screen.dart';
import 'package:vinculo/screens/role_selection_screen.dart';
import 'package:vinculo/screens/settings_screen.dart';
import 'package:vinculo/screens/volunteer/contact_profile_screen.dart';
import 'package:vinculo/screens/volunteer/history_screen.dart';
import 'package:vinculo/screens/volunteer/matches_screen.dart';
import 'package:vinculo/screens/volunteer/profile_screen.dart';
import 'package:vinculo/screens/volunteer/register_volunteer_screen.dart';
import 'package:vinculo/screens/volunteer/rewards_screen.dart';
import 'package:vinculo/screens/volunteer/volunteer_home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  
  routes: [
    GoRoute(
      path: '/',
      name: 'landing',
      builder: (context, state) => const LandingPage(),
    ),
    
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    GoRoute(
      path: '/registro',
      name: 'register',
      builder: (context, state) => const RegisterGeneralScreen(),
    ),
    
    GoRoute(
      path: '/roles',
      name: 'roles',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    
    GoRoute(
      path: '/volunteer',
      redirect: (context, state) => '/volunteer/home', // Redirect a home por defecto
    ),
    
    GoRoute(
      path: '/volunteer/register',
      name: 'register-volunteer',
      builder: (context, state) => const RegisterVolunteerScreen(),
    ),
    
    GoRoute(
      path: '/volunteer/success',
      name: 'volunteer-success',
      builder: (context, state) => const RegistrationSuccessScreen(
        userType: 'volunteer',
      ),
    ),
    
    GoRoute(
      path: '/volunteer/home',
      name: 'volunteer-home',
      builder: (context, state) => const VolunteerHomeScreen(),
    ),
    
    GoRoute(
      path: '/volunteer/matches',
      name: 'matches',
      builder: (context, state) => const MatchesScreen(),
      routes: [
        GoRoute(
          path: 'profile/:contactId',
          name: 'contact-profile',
          builder: (context, state) {
            final contactId = state.pathParameters['contactId']!;
            
            final contact = {
              'id': contactId,
              'name': state.uri.queryParameters['name'] ?? 'Usuario',
              'bio': state.uri.queryParameters['bio'] ?? 'Sin biografía',
            };
            
            return ContactProfileScreen(contact: contact);
          },
        ),
      ],
    ),
    
    GoRoute(
      path: '/volunteer/rewards',
      name: 'rewards',
      builder: (context, state) => const RewardsScreen(),
    ),
    
    GoRoute(
      path: '/volunteer/profile',
      name: 'volunteer-profile',
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: 'history',
          name: 'history',
          builder: (context, state) => const HistoryScreen(),
        ),
      ],
    ),
    
    GoRoute(
      path: '/elderly',
      redirect: (context, state) => '/elderly/home',
    ),
    
    GoRoute(
      path: '/elderly/register',
      name: 'register-elderly',
      builder: (context, state) => const RegisterElderlyScreen(),
    ),
    
    GoRoute(
      path: '/elderly/success',
      name: 'elderly-success',
      builder: (context, state) => const RegistrationSuccessScreen(
        userType: 'elderly',
      ),
    ),
    
    GoRoute(
      path: '/elderly/home',
      name: 'elderly-home',
      builder: (context, state) => const HomeElderlyScreen(),
    ),
    
    GoRoute(
      path: '/elderly/activities',
      name: 'activities-elderly',
      builder: (context, state) => const ActivitiesScreen(),
      routes: [
        // RUTA ANIDADA: /elderly/activities/volunteers
        GoRoute(
          path: 'volunteers',
          name: 'active-volunteers',
          builder: (context, state) => const VolunteersScreen(),
        ),
      ],
    ),
    
    GoRoute(
      path: '/elderly/profile',
      name: 'elderly-profile',
      builder: (context, state) => const ProfileElderlyScreen(),
    ),
    
    GoRoute(
      path: '/elderly/videocall',
      name: 'videocall',
      builder: (context, state) {
        final contactName = state.uri.queryParameters['contact'] ?? 'Usuario';
        return VideoCallScreen(contactName: contactName);
      },
    ),
  ],
  
  errorBuilder: (context, state) => Scaffold( body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Página no encontrada: ${state.uri}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Ir al inicio'),
          ),
        ],
      ),
    ),
  ),
);