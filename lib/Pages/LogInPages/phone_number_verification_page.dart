import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_registration_api/Models/phone_number_verification_model.dart';
import 'package:flutter_registration_api/Pages/LogInPages/otp_verification_page.dart';
import 'package:flutter_registration_api/Providers/phone_verification_provider.dart';
import 'package:provider/provider.dart';

class PhoneNumberVerificationPage extends StatelessWidget {
  const PhoneNumberVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          Consumer<PhoneVerificationProvider>(
            builder: (context, value, child) {
              return Form(
                key: value.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Enter your phone number',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We will send you a verification code',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: value.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your phone number',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
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
                          PhoneNumberVerificationModel
                              phoneNumberVerificationModel =
                              PhoneNumberVerificationModel(
                            deviceId: '1234567890',
                            deviceType: 'android',
                            deviceToken: 'sdfsdf',
                            mobile: value.phoneNumberController.text.trim(),
                            adminId: '2',
                          );
                          value.phoneNumberVerification(
                            phoneNumberVerificationModel:
                                phoneNumberVerificationModel,
                            onSucess: (response) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPVerificatinPage(
                                    userId: response,
                                  ),
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
                        }
                      },
                      child: value.isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
