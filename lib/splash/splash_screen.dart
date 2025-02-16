import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset>_logoAnimation;
  late Animation<Offset>_textAnimation;

  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoAnimation=Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut) );
   _textAnimation=Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut) );
  
  _controller.forward();

  Future.delayed(const Duration(seconds: 3), () {
  final isLoggedIn = FirebaseAuth.instance.currentUser != null;
  final route = isLoggedIn ? AppRoutes.main.name : AppRoutes.onboardingscreen.name;
  context.goNamed(route);
});

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyles.mainColor,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SlideTransition(position: _logoAnimation, child: Image.asset('assets/unnamed.png', width: 150,),),
        const SizedBox(height:20),
        SlideTransition(position: _textAnimation, child: Text("Blood Donation App",style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600
  ),),),
        SlideTransition(position: _textAnimation, child: Text("Donate And Save Lives!",style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600
  ),),),

      ],),),
    );
  }
}