import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            // Reduced from 20.w
            child: Column(
              children: [
                const Spacer(flex: 1),
                Image.asset(
                  "assets/images/logo.png",
                  height: 60.h,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Connect. Meet. Love.',
                  style: GLTextStyles.poppinsStyle()
                ),
                SizedBox(height: 5.h),
                Text(
                  'With Fliq Dating',
                    style: GLTextStyles.poppinsStyle()
                ),
                const Spacer(flex: 6),
                // Google Sign In Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.white,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google_logo.png',
                          height: 24.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Sign in with Google',
                            style: GLTextStyles.poppinsStyle(size: 12.sp,color: ColorTheme.black,weight: FontWeight.normal)

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                // Facebook Sign In Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.blue,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: ColorTheme.white,
                          size: 24.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Sign in with Facebook',
                            style: GLTextStyles.poppinsStyle(size: 12.sp,weight: FontWeight.normal)

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                // Phone Number Sign In Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.mainColor,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: ColorTheme.white,
                          size: 24.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Sign in with phone number',
                            style: GLTextStyles.poppinsStyle(size: 12.sp,weight: FontWeight.normal)

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Terms and Privacy Policy Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: ColorTheme.white,
                        fontSize: 11.sp, // Reduced from 12.sp
                      ),
                      children: [
                        const TextSpan(
                            text: 'By signing up, you agree to our '),
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(
                            text: '. See how we use your data in our '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
