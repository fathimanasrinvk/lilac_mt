import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_infotech/presentation/all_message_list_screen/controller/all_message_list_controller.dart';
import 'package:lilac_infotech/presentation/chat_details_screen/controller/chat_details-screen_controller.dart';
import 'package:lilac_infotech/presentation/otp_screen/controller/otp_screen_controller.dart';
import 'package:lilac_infotech/presentation/phone_number_screen/controller/phone_number_screen_controller.dart';
import 'package:lilac_infotech/presentation/phone_number_screen/view/phone_number_screen.dart';
import 'package:lilac_infotech/presentation/splash_screen/view/splash_screen.dart';
import 'package:provider/provider.dart';
void main() async {
  runApp(
       MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(395, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [

            ChangeNotifierProvider(
              create: (context) => PhoneNumberController(),
            ) , ChangeNotifierProvider(
              create: (context) => VerificationController(),
            ),
            ChangeNotifierProvider(
              create: (context) => MessageListController(),
            ) ,ChangeNotifierProvider(
              create: (context) => ChatController(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fliq Dating',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
            ),
            home:  SplashScreen(),

          ),
        );
      },
    );
  }
}
