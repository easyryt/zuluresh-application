import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zuluresh/controllers/main_application_controller.dart';
import 'package:zuluresh/controllers/set_location_controller.dart';
import 'package:zuluresh/services/global.dart';
import 'package:zuluresh/views/splash.dart';

void main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  SetLocationController setLocationController =
      Get.put(SetLocationController());
  MainApplicationController mainApplicationController =
      Get.put(MainApplicationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, type) {
      return GetMaterialApp(
        title: 'Zuluresh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.heebo().fontFamily,
        ),
        // onGenerateRoute: Routes.generateRoute,
        // initialRoute: RouteName.splashScreen,
        home: const Splash(),
      );
    });
  }
}
