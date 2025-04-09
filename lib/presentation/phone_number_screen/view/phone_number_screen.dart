import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';
import '../controller/phone_number_screen_controller.dart';

class PhoneNumberScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PhoneNumberController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorTheme.black,
            size: 24.h,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Enter your phone',
                style: GLTextStyles.poppinsStyle(
                  size: 20.sp,
                  weight: FontWeight.w600,
                  color: ColorTheme.black,
                ),
              ),
              Text(
                'number',
                style: GLTextStyles.poppinsStyle(
                  size: 20.sp,
                  weight: FontWeight.w600,
                  color: ColorTheme.black,
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      child: Icon(
                        Icons.smartphone,
                        size: 20.h,
                        color: ColorTheme.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      height: 24.h,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: GLTextStyles.poppinsStyle(
                          size: 14.sp,
                          color: ColorTheme.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '9745681203',
                          hintStyle: GLTextStyles.poppinsStyle(
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (value) {
                          controller.setPhoneNumber(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Fliq will send you a text with a verification code.',
                style: GLTextStyles.poppinsStyle(
                  size: 12.sp,
                  color: Colors.grey.shade600,
                  weight: FontWeight.normal,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 30.h),
                child: ElevatedButton(
                  onPressed: () {
                    controller.postPhoneNumber(
                      phoneController.text.trim(),
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
                  child: Text(
                    'Next',
                    style: GLTextStyles.poppinsStyle(
                      size: 16.sp,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
