import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_consts.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/api_service.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_listener_service.dart';
import 'package:dafa/app/services/firebase_messaging_service.dart';
import 'package:dafa/app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';

String initialRoute = AppRoutes.auth;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'dafa',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phoneNumber = prefs.getString("phoneNumber");
  if (phoneNumber != null) {
    final signInController = Get.put(SignInController());
    signInController.phoneNumberController.text = phoneNumber;
    DatabaseService databaseService = DatabaseService();
    // LocationService locationService = LocationService();
    FirebaseListenerService firebaseListenerService = FirebaseListenerService();
    FirebaseMessagingService firebaseMessagingService =
        FirebaseMessagingService();
    final bool isFirstTimeUpdate = await databaseService.FirstTimeUpdate();
    await firebaseMessagingService.InitNotifications();
    firebaseMessagingService.FirebaseNotification();
    if (isFirstTimeUpdate) {
      initialRoute = AppRoutes.complete_name;
    } else {
      signInController.UpdateUser(await databaseService.LoadUserData());
      // Position coordinate = await locationService.GetCoordinate();
      // signInController.user.coordinate =
      //     GeoPoint(coordinate.latitude, coordinate.longitude);
      // signInController.user.address = await locationService.GetAddress();
      signInController.user.isOnline = true;
      signInController.user.lastActive = DateTime.now();
      await databaseService.UpdateUserData(signInController.user);
      await databaseService.LoadMatchedList();
      signInController.matchList =
          await databaseService.LoadMatchList(signInController.user);
      firebaseListenerService.LoadAllUsersOnlineState();
      firebaseListenerService.LoadAllUsersSearchingState();
      firebaseListenerService.LoadGraphMatchList();
      signInController.matchList.add(
        MatchUser(
          user: null,
          distance: 0,
        ),
      );
      initialRoute = AppRoutes.swipe;
    }
  }
  final apiService = APIService();
  AppConsts.openAI_API_Key = await apiService.FetchApi();

  runApp(MyApp(navigatorKey: navigatorKey));
  // runApp(MaterialApp(home: AddFields()));
}
