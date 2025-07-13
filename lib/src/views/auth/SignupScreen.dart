import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_sm/src/components/Button.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/constants/Regex.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/auth/LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  final bool _isLoading = false;

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
            child: _buildSignupForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.vertS(20),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              'Welcome to Eduline',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Utils.vertS(10),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              'Let’s join to Eduline learning ecosystem & meet our professional mentor. It’s Free!',
              fontSize: 16,
              fontColor: AppColors.placeHolder,
              textAlignment: TextAlign.start,
            ),
          ),
          Utils.vertS(40),
          AutofillGroup(
            child: Column(
              children: [
                _buildTextField(
                  controller: _emailController,
                  label: "Email Address",
                  isPassword: false,
                  hintText: "e.g. mash@gmail.com",
                  autofillHints: const [AutofillHints.email],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Please type your email correctly';
                    }
                    return null;
                  },
                ),
                Utils.vertS(20),
                _buildTextField(
                  controller: _nameController,
                  label: "Full Name",
                  isPassword: false,
                  hintText: "e.g. Mushfiq Rahaman",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                Utils.vertS(20),
                _buildTextField(
                  label: "Password",
                  hintText: "e.g. 123456789",
                  controller: _passwordController,
                  isPassword: true,
                  autofillHints: const [AutofillHints.password],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Utils.vertS(10),
                ValueListenableBuilder(
                  valueListenable: _passwordController,
                  builder: (context, value, _) {
                    return Row(
                      children: [
                        passwordRegex.hasMatch(value.text.trim())
                            ? Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(Icons.remove_circle_outline_rounded),

                        AppText(
                          "At least 8 characters with a combination of letters and numbers",
                          fontColor: passwordRegex.hasMatch(value.text.trim())
                              ? Colors.green
                              : AppColors.semiDark,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          Utils.vertS(30),
          ActionButton(
            isLoading: _isLoading,
            btnText: 'SIGN UP',
            btnTap: () {},
          ),

          _buildLoginPrompt(),
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

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText('Already have an account? '),
        TextButton(
          onPressed: () {
            NavHelper.removeAllAndOpen(LoginScreen());
          },
          child: AppText(
            'Login',
            fontColor: AppColors.brandColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
