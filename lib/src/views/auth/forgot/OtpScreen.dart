import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_sm/src/components/Text.dart';
import 'package:test_sm/src/constants/Colors.dart';
import 'package:test_sm/src/constants/Images.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/utils/utils.dart';
import 'package:test_sm/src/views/auth/forgot/ResetPassword.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _resendSeconds = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _resendOTP() {
    if (_resendSeconds > 0) return;

    Utils.snackBarDefaultMessage("OTP resent successfully");

    for (final controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendSeconds = 60;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  _verifyOTP() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    await Future.delayed(Duration(seconds: 3));
    setState(() => _isLoading = false);

    NavHelper.addWithAnimation(ResetPassword());
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
            child: _buildOTPForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildOTPForm() {
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
          AppText('Verify Code', fontSize: 28, fontWeight: FontWeight.bold),
          Utils.vertS(10),
          AppText(
            'Please enter the code we just sent to email ${widget.email}',
            fontSize: 16,
            fontColor: AppColors.placeHolder,
          ),
          Utils.vertS(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildOTPField(index)),
          ),
          Utils.vertS(40),

          // Resend code
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            child: _isLoading
                ? CircularProgressIndicator(color: AppColors.brandColor)
                : SizedBox.shrink(),
          ),

          Center(
            child: Column(
              children: [
                Text(
                  'Didn\'t receive the code?',
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                ),
                Utils.vertS(12),
                TextButton(
                  onPressed: _resendSeconds > 0 ? null : _resendOTP,
                  child: AppText(
                    _resendSeconds > 0
                        ? 'Resend Code in 00:$_resendSeconds'
                        : 'Resend Code',

                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 60,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.placeHolder),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.brandColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          counter: Offstage(),
        ),
        onChanged: (value) async {
          if (value.isNotEmpty) {
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
              await _verifyOTP();
            }
          }
        },
        onTap: () {
          _focusNodes.last.requestFocus();
          _controllers[index].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controllers[index].text.length,
          );
        },
      ),
    );
  }
}
