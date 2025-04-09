import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_infotech/presentation/chat_details_screen/view/chat_details_screen.dart';
import 'package:lilac_infotech/presentation/chat_screen/controller/chat-screen-controller.dart';
import 'package:lilac_infotech/presentation/chat_screen/view/chat_screen.dart';
import 'package:lilac_infotech/presentation/otp_screen/controller/otp_screen_controller.dart';
import 'package:lilac_infotech/presentation/otp_screen/view/otp-screen.dart';
import 'package:lilac_infotech/presentation/phone_number_screen/controller/phone_number_screen_controller.dart';
import 'package:lilac_infotech/presentation/phone_number_screen/view/phone_number_screen.dart';
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
            // ChangeNotifierProvider(create: (_) => PhoneNumberProvider()),
            // In your main.dart or wherever you set up providers
            ChangeNotifierProvider(
              create: (context) => PhoneNumberController(),
            ) , ChangeNotifierProvider(
              create: (context) => VerificationController(),
            ),
            ChangeNotifierProvider(
              create: (context) => MessagesController(),
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
            home:  PhoneNumberScreen(),

          ),
        );
      },
    );
  }
}
