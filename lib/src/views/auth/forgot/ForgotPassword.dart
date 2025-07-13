import 'package:flutter/material.dart';
import 'package:test_sm/src/components/Button.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/components/TextField.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/constants/Images.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/auth/forgot/OtpScreen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    await Future.delayed(Duration(seconds: 3));
    setState(() => _isLoading = false);
    NavHelper.addWithAnimation(OtpScreen(email: _emailController.text.trim()));
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
            child: _buildEmailForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(AppImages.logo, fit: BoxFit.contain),
          ),
          Utils.vertS(20),
          AppText('Forgot Password', fontSize: 28, fontWeight: FontWeight.bold),
          Utils.vertS(10),
          AppText(
            'Enter your email, we will send a verification code to email',
            fontSize: 16,
            fontColor: AppColors.placeHolder,
          ),
          Utils.vertS(40),
          AppTextField(
            controller: _emailController,
            label: "Email Address",
            isPassword: false,
            hintText: "e.g. mash@gmail.com",
          ),

          Utils.vertS(30),
          ActionButton(
            isLoading: _isLoading,
            btnText: 'LOG IN',
            btnTap: () => _sendEmail(),
          ),
        ],
      ),
    );
  }
}
