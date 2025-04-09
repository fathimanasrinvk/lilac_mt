import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';
import '../controller/otp_screen_controller.dart';

class VerificationScreen extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController otpController = TextEditingController();

  VerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<VerificationController>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Enter your verification code',
                style: GLTextStyles.poppinsStyle(
                  size: 20.sp,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '+91 $phoneNumber',
                    style: GLTextStyles.poppinsStyle(
                      size: 16.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Edit',
                      style: GLTextStyles.poppinsStyle(
                        size: 16.sp,
                        color: ColorTheme.mainColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  controller: otpController,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5.r),
                    fieldHeight: 50.h,
                    fieldWidth: 40.w,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor: ColorTheme.mainColor,
                    inactiveColor: Colors.grey.shade400,
                    selectedColor: ColorTheme.mainColor,
                    selectedFillColor: Colors.white,
                  ),
                  cursorColor: Colors.grey.shade400,
                  cursorHeight: 24.h,
                  cursorWidth: 2.w,
                  keyboardType: TextInputType.number,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    // Will automatically verify when all digits are entered
                    controller.setOtpCode(v);
                  },
                  onChanged: (value) {
                    controller.setOtpCode(value);
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Didn't get anything? No worries, let's try again.",
                      style: GLTextStyles.poppinsStyle(
                        size: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        controller.resendOtp(phoneNumber, context);
                      },
                      child: Text(
                        'Resend',
                        style: GLTextStyles.poppinsStyle(
                          size: 16.sp,
                          color: ColorTheme.mainColor,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () {
                    controller.verifyOtp(
                      phoneNumber,
                      otpController.text,
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.mainColor,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: controller.isLoading
                      ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                      : Text(
                    'Verify',
                    style: GLTextStyles.poppinsStyle(
                      size: 16.sp,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}