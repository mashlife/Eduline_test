import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_sm/src/components/Button.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/constants/Images.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/language/LanguageScreen.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  _locationPermission() async {
    final permission = await [
      Permission.location,
      Permission.locationWhenInUse,
    ].request();

    if (permission.entries.every((element) => element.value.isGranted)) {
      NavHelper.addWithAnimation(LanguageScreen());
    } else {
      Utils.snackBarErrorMessage("Permission Not Granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 175,
                width: 175,
                child: Image.asset(AppImages.location, fit: BoxFit.contain),
              ),
              Utils.vertS(20),
              AppText(
                'Enable Location',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              Utils.vertS(10),
              AppText(
                'Kindly allow us to access your location to provide you with suggestions for nearby salons',
                fontSize: 16,
                fontColor: AppColors.placeHolder,
              ),

              Utils.vertS(30),
              ActionButton(
                isLoading: false,
                btnText: 'Continue',
                btnTap: () => _locationPermission(),
              ),
              TextButton(
                onPressed: () => NavHelper.addWithAnimation(LanguageScreen()),
                child: AppText(
                  'Skip for now',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
