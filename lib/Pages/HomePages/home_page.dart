// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_registration_api/Pages/LogInPages/phone_number_verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // show access token on home page in a text widget
  // get access token from shared preferences
  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  }

  @override
  void initState() {
    super.initState();
    getAccessToken();
    print('token: ${getAccessToken()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          TextButton(
            onPressed: () async {
              // remove access token from shared preferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('accessToken');
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhoneNumberVerificationPage(),
                ),
              );
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: FutureBuilder(
              future: getAccessToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return const Text('Loading...');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
