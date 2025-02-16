import 'package:donatelife/features/authentication/presentation/screens/account_screen.dart';
import 'package:donatelife/features/authentication/presentation/screens/registration_screen.dart';
import 'package:donatelife/features/authentication/presentation/screens/sign_in_Screen.dart';
import 'package:donatelife/features/user_management/presentation/screens/blood_group_selected_screen.dart';
import 'package:donatelife/routes/ro_router_refresh_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Use this for the @riverpod annotation
import 'package:donatelife/features/user_management/presentation/screens/main_screen.dart';
import 'package:donatelife/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../splash/onboarding_screen.dart';

part 'routes.g.dart'; // Generated code will go here

enum AppRoutes {
  splash,
  main,
  signIn,
  register,
  account,
  bloodGroupSelected,
  onboardingscreen,
}

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

// Define the GoRouter provider
@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final isLoggedIn = firebaseAuth.currentUser != null;

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (ctx, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      final location = state.uri.path;

      if (!isLoggedIn) {
        // User is not logged in, navigate through onboarding
        if (location != '/onboardingscreen' &&
            location != '/signIn' &&
            location != '/splash') {
          return '/onboardingscreen';
        }
      } else if (isLoggedIn &&
          (location == '/onboardingscreen' || location == '/signIn')) {
        // If logged in, skip onboarding and sign-in
        return '/main';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboardingscreen',
        name: AppRoutes.onboardingscreen.name,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/main',
        name: AppRoutes.main.name,
        builder: (context, state) => const MainScreen(),
        routes: [
          GoRoute(
            path: '/bloodGroupSelected',
            name: AppRoutes.bloodGroupSelected.name,
            builder: (context, state) {
              final bloodGroup = state.extra as String;
              return BloodGroupSelectedScreen(bloodGroup);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        builder: (context, state) {
          final type = state.extra as String;
          return RegistrationScreen(type);
        },
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/account',
        name: AppRoutes.account.name,
        builder: (context, state) => const AccountScreen(),
      ),
    ],
  );
}
