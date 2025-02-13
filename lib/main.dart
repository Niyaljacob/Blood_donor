import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
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

