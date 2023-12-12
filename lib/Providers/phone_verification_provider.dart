import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_registration_api/Models/phone_number_verification_model.dart';
import 'package:flutter_registration_api/Services/api_service.dart';

class PhoneVerificationProvider with ChangeNotifier {
  ApiService apiService = ApiService();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> phoneNumberVerification({
    required PhoneNumberVerificationModel phoneNumberVerificationModel,
    required Function(String) onSucess,
    required Function(String) onError,
  }) async {
    isLoading = true;
    notifyListeners();
    final response = await apiService.phoneNumberVerification(
      phoneNumberVerificationModel,
    );
    log('### 1. response: $response');
    isLoading = false;
    notifyListeners();
    if (response != null) {
      onSucess(response);
    } else {
      onError('Failed to load data!');
    }
  }
}
