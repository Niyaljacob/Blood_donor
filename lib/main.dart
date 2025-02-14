import 'package:donatelife/firebase_options.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Donate Life',
      routerConfig: ref.watch(goRouterProvider),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Appstyles.mainColor),
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          color: Appstyles.mainColor,
          centerTitle: true,
          iconTheme: const IconThemeData().copyWith(color: Colors.white)
        )
      ),
    );
  }
}

