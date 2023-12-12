class OTPVerificationModel {
  int userId;
  String otp;
  String adminId;

  OTPVerificationModel({
    required this.userId,
    required this.otp,
    required this.adminId,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "otp": otp,
      "admin_id": adminId,
    };
  }

  factory OTPVerificationModel.fromJson(Map<String, dynamic> json) {
    return OTPVerificationModel(
      userId: json['user_id'],
      otp: json['otp'],
      adminId: json['admin_id'],
    );
  }
}
