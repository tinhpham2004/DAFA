import 'package:dafa/app/routes/app_pages.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1600),
      child: GetMaterialApp(
        initialRoute: initialRoute,
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
