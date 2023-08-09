import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miladtech_flutter_icons/miladtech_flutter_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/models/single_time_slot_model.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/views/main_application/account/faq/faq_screen.dart';
import 'package:zuluresh/views/main_application/account/notifications/notifications.dart';
import 'package:zuluresh/views/main_application/account/orders/orders_screen.dart';
import 'package:zuluresh/views/main_application/address/select_address.dart';
import 'package:zuluresh/views/set_location.dart';
import 'package:zuluresh/views/update_profile.dart';

import '../cart/cart_screen.dart';
import 'contacts/contact_us.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: AppBar().preferredSize.height + 5.h),
            Container(
              width: 90.w,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const UpdateProfileScreen());
                    },
                    child: singleTile(FontAwesome5.user_circle, "My Profile"),
                  ),
                  Divider(
                    endIndent: 5.w,
                    indent: 5.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const OrdersScreen());
                    },
                    child: singleTile(Feather.shopping_cart, "Orders"),
                  ),
                  Divider(
                    endIndent: 5.w,
                    indent: 5.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SelectAddressScreen());
                    },
                    child: singleTile(Feather.map_pin, "Address"),
                  ),
                  Divider(
                    endIndent: 5.w,
                    indent: 5.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Notifications());
                    },
                    child: singleTile(Feather.bell, "Notifications"),
                  ),
                  Divider(
                    endIndent: 5.w,
                    indent: 5.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const ContactUsScreen());
                    },
                    child: singleTile(Feather.phone, "Contacts"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.5.h),
            Container(
              width: 90.w,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  singleTile(FontAwesome.print, "Terms and Conditions"),
                  Divider(
                    endIndent: 5.w,
                    indent: 5.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const FaqScreen());
                    },
                    child: singleTile(FontAwesome.question_circle_o, "Faqs"),
                  ),
                  Divider(
                    endIndent: 5.w,
                    indent: 5.w,
                  ),
                  InkWell(
                    onTap: () {},
                    child: singleTile(Feather.shield_off, "Privacy Policy"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.5.h),
            Container(
              width: 90.w,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Global.storageServices.removeAllData();
                      _mainApplicationController.selectedDeliveryTime =
                          SingleTimeSlotModel();
                      _mainApplicationController.cartItems.value = [];
                      _mainApplicationController.pageIdx.value = 0;
                      _mainApplicationController.selectedAddress.value = 0;
                      _mainApplicationController.selectedDeliveryDate.value = 0;
                      Get.offAll(() => const SetLocation());
                    },
                    child: singleTile(Feather.log_out, "Log Out"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget singleTile(IconData icon, String title) {
    return Container(
      height: 57.5,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.black.withOpacity(0.7),
                size: 20.sp,
              ),
              SizedBox(width: 2.5.w),
              Text(
                title,
                style: GoogleFonts.heebo(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 17.sp,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
            size: 18.sp,
          )
        ],
      ),
    );
  }
}
