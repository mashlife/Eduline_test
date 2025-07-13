import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:test_sm/src/components/AnimatedDialogs.dart';
import 'package:test_sm/src/components/Button.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/components/TextField.dart';
import 'package:test_sm/src/constants/Animations.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/constants/Regex.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/auth/LoginScreen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPassVisible = false;
  bool _isLoading = false;

  _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    await Future.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);
    _showSuccess();
  }

  _showSuccess() async {
    await AnimatedDialogs.showTransitionDialog(
      dismissible: false,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 300,
                child: RiveAnimation.asset(
                  AppAnims.successResetPass,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Utils.vertS(20),

            AppText('Success', fontSize: 28, fontWeight: FontWeight.bold),
            Utils.vertS(10),
            AppText(
              'Your password is successfully created',
              fontSize: 16,
              fontColor: AppColors.placeHolder,
            ),
            Utils.vertS(25),
            ActionButton(
              isLoading: _isLoading,
              btnText: 'Continue',
              btnTap: () => NavHelper.removeAllAndOpen(LoginScreen()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 45,

        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            NavHelper.remove();
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.placeHolder, width: 2),
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildResetPasswordForm(),
          ),
        ),
      ),
    );
  }

  _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Reset Password",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Utils.vertS(10),
          Text(
            "Your password must be at least 8 characters long and include a combination of letters, numbers",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Utils.vertS(40),
          AppTextField(
            label: "New Password",
            hintText: "e.g. 123456789",
            controller: _passwordController,
            isPassword: _isPasswordVisible,
            onSuffixTap: () {
              setState(() => _isPasswordVisible = !_isPasswordVisible);
            },
            visibility: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your current password';
              } else if (!passwordRegex.hasMatch(value)) {
                return 'Password must be at least 8 characters long and include a combination of letters, numbers';
              }
              return null;
            },
          ),
          Utils.vertS(20),
          AppTextField(
            label: "Confirm New Password",
            hintText: "e.g. 123456789",
            controller: _confirmPassController,
            isPassword: _isConfirmPassVisible,
            onSuffixTap: () {
              setState(() => _isConfirmPassVisible = !_isConfirmPassVisible);
            },
            visibility: true,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your current password';
              } else if (!passwordRegex.hasMatch(value)) {
                return 'Password must be at least 8 characters long and include a combination of letters, numbers';
              } else if (_passwordController.text != value) {
                return 'Password must match';
              }
              return null;
            },
          ),

          Utils.vertS(30),
          ActionButton(
            isLoading: _isLoading,
            btnText: 'Submit',
            btnTap: () => _resetPassword(),
          ),
        ],
      ),
    );
  }
}
