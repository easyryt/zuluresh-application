import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miladtech_flutter_icons/miladtech_flutter_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/controllers/auth/auth_controller.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/main_home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final MainApplicationController _mainApplicationController = Get.find();
  final AuthController _authController = Get.put(AuthController());
  final _phoneFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _authController.otpTextEditingController.dispose();
    _authController.phoneTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 5.h),
                    Container(
                      height: 35.h,
                      width: 100.w,
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                      child: const Image(
                        image: AssetImage("assets/images/auth_meat_tawa.png"),
                        // fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Login",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Form(
                      key: _phoneFormKey,
                      child: SizedBox(
                        child: TextFormField(
                          controller:
                              _authController.phoneTextEditingController,
                          autofocus: true,
                          readOnly: _authController.sentOtp.value,
                          keyboardType: TextInputType.number,
                          cursorColor: Constants.primaryColor,
                          maxLength: 10,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          style: GoogleFonts.heebo(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 5,
                              fontSize: 17.sp),
                          validator: (value) {
                            if (value!.length != 10) {
                              return "Input Valid Number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 2.w),
                            counterText: "",
                            icon: Icon(
                              Feather.phone_call,
                              color: Constants.primaryColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants.primaryColor,
                              ),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: !_authController.sentOtp.value ? 5.h : 2.h),
                    _authController.sentOtp.value
                        ? Form(
                            key: _otpFormKey,
                            child: TextFormField(
                              controller:
                                  _authController.otpTextEditingController,
                              validator: (value) {
                                if (value!.length != 4) {
                                  return "Enter 4-digit OTP..";
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              autofocus: true,
                              style: GoogleFonts.heebo(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 10,
                                  fontSize: 17.sp),
                              readOnly: !_authController.sentOtp.value,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              cursorColor: Constants.primaryColor,
                              decoration: InputDecoration(
                                counterText: "",
                                icon: Icon(
                                  Feather.message_square,
                                  color: Constants.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                        height: !_authController.sentOtp.value ? 0.h : 5.h),
                    _authController.sentOtp.value
                        ? SizedBox(
                            height: 35,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _authController.sentOtp.value = false;
                                    _authController.otpTextEditingController
                                        .clear();
                                  },
                                  child: Text(
                                    "Edit Phone Number?",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.heebo(
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    _authController.otpTextEditingController
                                        .clear();
                                    if (await _authController.getOtp() ==
                                        false) {
                                      if (mounted) {
                                        CustomToasts.errorToast(
                                            context, "Error Sending OTP");
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Resend OTP",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.heebo(
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    InkWell(
                      onTap: () async {
                        if (_authController.sentOtp.value) {
                          // _authController.sentOtp.value;
                          if (_authController.verifyingOtp.value == false) {
                            if (_otpFormKey.currentState!.validate()) {
                              var token = await _authController.verifyOtp();
                              if (token == false) {
                                if (mounted) {
                                  CustomToasts.errorToast(
                                      context, "Invalid OTP");
                                }
                              } else {
                                Global.storageServices
                                    .setString("x-auth-token", token);
                                Global.apiClient.updateHeader(token);
                                Get.offAll(() => const MainHomeScreen());
                              }
                            }
                          }
                        } else {
                          if (_authController.sendingOtp.value == false) {
                            if (_phoneFormKey.currentState!.validate()) {
                              if (await _authController.getOtp() == false) {
                                if (mounted) {
                                  CustomToasts.errorToast(
                                      context, "Error Sending OTP");
                                }
                              }
                            }
                          }
                        }
                      },
                      child: _authController.sendingOtp.value ||
                              _authController.verifyingOtp.value
                          ? Container(
                              height: 55,
                              width: 90.w,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF941A49),
                                    Color(0xFF941A49),
                                    Color(0xFFEF578A),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            )
                          : PrimaryFilledButton(
                              width: 90.w,
                              buttonText: _authController.sentOtp.value
                                  ? "Verify OTP"
                                  : "Send OTP",
                            ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
