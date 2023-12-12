import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_registration_api/Pages/splash_page.dart';
import 'package:flutter_registration_api/Providers/otp_verification_provider.dart';
import 'package:flutter_registration_api/Providers/phone_verification_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PhoneVerificationProvider()),
        ChangeNotifierProvider(create: (context) => OTPVerificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterLogInAPI',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        // home: const PhoneNumberVerificationPage(),
        home: const SplashPage(),
      ),
    );
  }
}
