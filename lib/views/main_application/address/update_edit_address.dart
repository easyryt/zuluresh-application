import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/common/button/primary_filled_button.dart';
import 'package:zuluresh/common/custom_toasts.dart';
import 'package:zuluresh/utils/constants.dart';
import 'package:zuluresh/views/main_application/address/select_address.dart';

import '../../../controllers/address/edit_address_controller.dart';

class EditAddressScreen extends StatefulWidget {
  final String id;
  final bool update;

  const EditAddressScreen({super.key, required this.update, required this.id});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final EditAddressController _editAddressController =
      Get.put(EditAddressController());
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    () async {
      if (widget.update) {
        _editAddressController.loadAddressData(widget.id);
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            SizedBox(
              height: AppBar().preferredSize.height,
              width: 100.w,
              child: Row(
                children: [
                  SizedBox(width: 5.w),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      size: 19.sp,
                      color: const Color(0xFF941A49),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.update ? "Update Address" : "Add Address",
                        style: GoogleFonts.heebo(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: const Color(0xFF941A49),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: _addressFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: .5.h),
                              SizedBox(
                                width: 90.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return "Invalid Name";
                                    }
                                    return null;
                                  },
                                  controller: _editAddressController
                                      .fullNameTextController,
                                  cursorColor: Constants.primaryColor,
                                  decoration: InputDecoration(
                                    labelText: "Full Name",
                                    labelStyle: GoogleFonts.heebo(
                                        color: Constants.lightTextColor),
                                    floatingLabelStyle: GoogleFonts.heebo(
                                        color: Constants.primaryColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.lightTextColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 1.5.h),
                              // SizedBox(
                              //   width: 90.w,
                              //   child: TextFormField(
                              //     validator: (value) {
                              //       if (value!.length < 3) {
                              //         return "Invalid Address";
                              //       }
                              //       return null;
                              //     },
                              //     controller: _editAddressController
                              //         .deliveryAddressTextController,
                              //     cursorColor: Constants.primaryColor,
                              //     decoration: InputDecoration(
                              //       labelText: "Enter Delivery Address",
                              //       labelStyle: GoogleFonts.heebo(
                              //           color: Constants.lightTextColor),
                              //       floatingLabelStyle: GoogleFonts.heebo(
                              //           color: Constants.primaryColor),
                              //       enabledBorder: UnderlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Constants.lightTextColor),
                              //       ),
                              //       focusedBorder: UnderlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Constants.primaryColor),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 1.5.h),
                              SizedBox(
                                width: 90.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return "Invalid Street";
                                    }
                                    return null;
                                  },
                                  controller: _editAddressController
                                      .streetTextController,
                                  cursorColor: Constants.primaryColor,
                                  decoration: InputDecoration(
                                    labelText: "Street",
                                    labelStyle: GoogleFonts.heebo(
                                        color: Constants.lightTextColor),
                                    floatingLabelStyle: GoogleFonts.heebo(
                                        color: Constants.primaryColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.lightTextColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 90.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Invalid House No";
                                          }
                                          return null;
                                        },
                                        controller: _editAddressController
                                            .houseTextController,
                                        cursorColor: Constants.primaryColor,
                                        decoration: InputDecoration(
                                          labelText: "House/Flat No",
                                          labelStyle: GoogleFonts.heebo(
                                              color: Constants.lightTextColor),
                                          floatingLabelStyle: GoogleFonts.heebo(
                                              color: Constants.primaryColor),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Constants.lightTextColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.length < 3) {
                                            return "Invalid Block Name";
                                          }
                                          return null;
                                        },
                                        controller: _editAddressController
                                            .blockTextController,
                                        cursorColor: Constants.primaryColor,
                                        decoration: InputDecoration(
                                          labelText: "Block Name",
                                          labelStyle: GoogleFonts.heebo(
                                              color: Constants.lightTextColor),
                                          floatingLabelStyle: GoogleFonts.heebo(
                                              color: Constants.primaryColor),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Constants.lightTextColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              SizedBox(height: 1.5.h),
                              SizedBox(
                                width: 90.w,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return "Invalid Landmark";
                                    }
                                    return null;
                                  },
                                  controller: _editAddressController
                                      .landmarkTextController,
                                  cursorColor: Constants.primaryColor,
                                  decoration: InputDecoration(
                                    labelText: "Landmark",
                                    labelStyle: GoogleFonts.heebo(
                                        color: Constants.lightTextColor),
                                    floatingLabelStyle: GoogleFonts.heebo(
                                        color: Constants.primaryColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.lightTextColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              SizedBox(
                                width: 90.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _editAddressController
                                            .localityTextController,
                                        cursorColor: Constants.primaryColor,
                                        validator: (value) {
                                          if (value!.length < 3) {
                                            return "Invalid Locality";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Locality",
                                          labelStyle: GoogleFonts.heebo(
                                              color: Constants.lightTextColor),
                                          floatingLabelStyle: GoogleFonts.heebo(
                                              color: Constants.primaryColor),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Constants.lightTextColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _editAddressController
                                            .pinCodeTextController,
                                        cursorColor: Constants.primaryColor,
                                        keyboardType: TextInputType.number,
                                        maxLength: 6,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        validator: (value) {
                                          if (value!.length != 6) {
                                            return "Invalid Pin code";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Pincode",
                                          labelStyle: GoogleFonts.heebo(
                                              color: Constants.lightTextColor),
                                          floatingLabelStyle: GoogleFonts.heebo(
                                              color: Constants.primaryColor),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Constants.lightTextColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              SizedBox(
                                width: 90.w,
                                child: TextFormField(
                                  controller: _editAddressController
                                      .mobileNumberTextController,
                                  validator: (value) {
                                    if (value!.length != 10) {
                                      return "Invalid Mobile Number";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  style: GoogleFonts.heebo(
                                    letterSpacing: 8,
                                  ),
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  cursorColor: Constants.primaryColor,
                                  decoration: InputDecoration(
                                    labelText: "Mobile Number",
                                    counterText: "",
                                    labelStyle: GoogleFonts.heebo(
                                        color: Constants.lightTextColor),
                                    floatingLabelStyle: GoogleFonts.heebo(
                                        color: Constants.primaryColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.lightTextColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.5.h),
                              Text(
                                "Save As",
                                style: GoogleFonts.heebo(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              Obx(() {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _editAddressController
                                              .saveAsNumber.value = 0;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          decoration: BoxDecoration(
                                            color: _editAddressController
                                                        .saveAsNumber.value ==
                                                    0
                                                ? Constants.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: const Offset(-5, -5),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.home,
                                                color: _editAddressController
                                                            .saveAsNumber
                                                            .value ==
                                                        0
                                                    ? Colors.white
                                                    : Constants.primaryColor,
                                                size: 19.sp,
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                "Home",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: _editAddressController
                                                              .saveAsNumber
                                                              .value ==
                                                          0
                                                      ? Colors.white
                                                      : Constants.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.5.w),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _editAddressController
                                              .saveAsNumber.value = 1;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          decoration: BoxDecoration(
                                            color: _editAddressController
                                                        .saveAsNumber.value ==
                                                    1
                                                ? Constants.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: const Offset(-5, -5),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.work,
                                                color: _editAddressController
                                                            .saveAsNumber
                                                            .value ==
                                                        1
                                                    ? Colors.white
                                                    : Constants.primaryColor,
                                                size: 19.sp,
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                "Work",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: _editAddressController
                                                              .saveAsNumber
                                                              .value ==
                                                          1
                                                      ? Colors.white
                                                      : Constants.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2.5.w),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _editAddressController
                                              .saveAsNumber.value = 2;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          decoration: BoxDecoration(
                                            color: _editAddressController
                                                        .saveAsNumber.value ==
                                                    2
                                                ? Constants.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: const Offset(-5, -5),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: _editAddressController
                                                            .saveAsNumber
                                                            .value ==
                                                        2
                                                    ? Colors.white
                                                    : Constants.primaryColor,
                                                size: 19.sp,
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                "Other",
                                                style: GoogleFonts.heebo(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: _editAddressController
                                                              .saveAsNumber
                                                              .value ==
                                                          2
                                                      ? Colors.white
                                                      : Constants.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              SizedBox(height: 2.5.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (_addressFormKey.currentState!.validate()) {
                          if (widget.update) {
                            if (await _editAddressController
                                .updateAddress(widget.id)) {
                              Get.off(() => const SelectAddressScreen());
                              if (mounted) {
                                CustomToasts.successToast(
                                    context, "Address Updated successfully..");
                                setState(() {});
                              }
                            }
                          } else {
                            if (await _editAddressController.addNewAddress()) {
                              if (mounted) {
                                Get.close(2);
                                Get.off(() => const SelectAddressScreen());
                                CustomToasts.successToast(
                                    context, "Address added successfully..");
                              }
                            } else {
                              if (mounted) {
                                CustomToasts.errorToast(
                                    context, "Pincode is not Servable..!!");
                              }
                            }
                          }
                        }
                        // Get.back();
                      },
                      child: PrimaryFilledButton(
                        width: 90.w,
                        buttonText:
                            widget.update ? "Save Address" : "Add Address",
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
