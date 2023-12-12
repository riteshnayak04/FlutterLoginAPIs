import 'package:flutter/material.dart';
import 'package:flutter_registration_api/Models/otp_verification_model.dart';
import 'package:flutter_registration_api/Pages/HomePages/home_page.dart';
import 'package:flutter_registration_api/Providers/otp_verification_provider.dart';
import 'package:provider/provider.dart';

class OTPVerificatinPage extends StatelessWidget {
  final String userId;
  const OTPVerificatinPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'OTP Verification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          Consumer<OTPVerificationProvider>(builder: (context, value, child) {
            return Form(
              key: value.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Enter your OTP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We have sent you a verification code',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter OTP!';
                      }
                      return null;
                    },
                    controller: value.otpController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter OTP',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 1.0,
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        if (value.formKey.currentState!.validate()) {
                          OTPVerificationModel otpVerificationModel =
                              OTPVerificationModel(
                            userId: int.parse(userId),
                            otp: value.otpController.text,
                            adminId: '2',
                          );
                          value.otpVerification(
                            otpVerificationModel: otpVerificationModel,
                            onSuccess: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('OTP verified successfully!'),
                                ),
                              );
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(error),
                                ),
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Please enter OTP!'),
                            ),
                          );
                        }
                      },
                      child: value.isLoading == true
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}



//  Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         width: 45,
//                         height: 50,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           controller: value.otpController1,
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: 45,
//                         height: 50,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           controller: value.otpController2,
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: 45,
//                         height: 50,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           controller: value.otpController3,
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: 45,
//                         height: 50,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           controller: value.otpController4,
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: 45,
//                         height: 50,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           controller: value.otpController4,
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: 45,
//                         height: 50,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           controller: value.otpController4,
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.blueAccent,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),