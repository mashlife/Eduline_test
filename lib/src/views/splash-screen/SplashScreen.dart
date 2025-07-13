import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/constants/Animations.dart';
import 'package:test_sm/src/constants/colors.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/repository/shared_pref_repository.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/auth/LoginScreen.dart';
import 'package:test_sm/src/views/onboarding-screen/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      NavHelper.removeAllAndOpen(OnboardingScreen());
    });
  }

  _navigate() async {
    bool isFirstTime = await SharedPrefRepository.readFirstTime();

    if (isFirstTime) {
      NavHelper.removeAllAndOpen(OnboardingScreen());
    } else {
      NavHelper.removeAllAndOpen(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Utils.vertS(40),
              Center(
                child: SizedBox(
                  height: 150,
                  width: 300,
                  child: RiveAnimation.asset(
                    AppAnims.splash,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              AppText(
                "Theory test in my language",
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              Utils.vertS(15),
              AppText(
                "I must write the real test will be in English language and this app just helps you to understand the materials in your language",

                fontColor: AppColors.semiDark.withOpacity(0.75),
              ),

              Spacer(),
              SizedBox(
                height: 60,
                width: 60,
                child: RiveAnimation.asset(
                  AppAnims.loading,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Utils.vertS(20),
            ],
          ),
        ),
      ),
    );
  }
}
