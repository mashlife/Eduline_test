import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_sm/src/components/Button.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/constants/Images.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/auth/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  final bool _isLoading = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildLoginForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
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
          AppText('Welcome Back!', fontSize: 28, fontWeight: FontWeight.bold),
          Utils.vertS(10),
          AppText(
            'Please login first to start your Theory Test.',
            fontSize: 16,
            fontColor: AppColors.placeHolder,
          ),
          const SizedBox(height: 40),
          AutofillGroup(
            child: Column(
              children: [
                _buildTextField(
                  controller: _emailController,
                  label: "Email Address",
                  isPassword: false,
                  hintText: "e.g. mash@gmail.com",
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: "Password",
                  hintText: "e.g. 123456789",
                  controller: _passwordController,
                  isPassword: true,
                  autofillHints: const [AutofillHints.password],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          _buildRememberForgotRow(),
          const SizedBox(height: 30),
          ActionButton(isLoading: _isLoading, btnText: 'LOG IN', btnTap: () {}),

          _buildSignupPrompt(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required bool isPassword,
    required String label,
    Iterable<String>? autofillHints,
    String? Function(String?)? validator,
    String? hintText,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, fontSize: 16, fontWeight: FontWeight.w700),
        Utils.vertS(10),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? !_isPasswordVisible : false,
          style: const TextStyle(color: AppColors.semiDark),
          autofillHints: autofillHints,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      setState(() => _isPasswordVisible = !_isPasswordVisible);
                    },
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildRememberForgotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) =>
                  setState(() => _rememberMe = value ?? false),
              checkColor: AppColors.creamWhite,
              activeColor: AppColors.brandColor,
            ),
            const SizedBox(width: 8),
            AppText('Remember me'),
          ],
        ),
        TextButton(onPressed: () {}, child: AppText('Forgot Password?')),
      ],
    );
  }

  Widget _buildSignupPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText('Don\'t have an account? '),
        TextButton(
          onPressed: () {
            NavHelper.addWithAnimation(SignupScreen());
          },
          child: AppText(
            'Sign Up',
            fontColor: AppColors.brandColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
