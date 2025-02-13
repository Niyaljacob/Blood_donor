import 'package:donatelife/features/authentication/presentation/screens/sign_in_Screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Use this for the @riverpod annotation
import 'package:donatelife/features/user_management/presentation/screens/main_screen.dart';
import 'package:donatelife/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart'; // Generated code will go here

enum AppRoutes {
  splash,
  main,
  signIn,
  register,
  account,
  bloodGroupSelected,
  emailedUsers,
  notifications,
}

// Define the GoRouter provider
@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/main',
        name: AppRoutes.main.name,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}
