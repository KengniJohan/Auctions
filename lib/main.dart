import 'package:auctions/configs/routes/app_pages.dart';
import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/firebase_options.dart';
import 'package:auctions/configs/ressources/app_ressources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..progressColor = AppResources.colors.primary
    ..textColor = AppResources.colors.primary
    ..indicatorColor = AppResources.colors.primary
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = AppResources.colors.primary.withOpacity(0.1);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppResources.colors.primary),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.signUp,
      getPages: AppPages.allPages,
      builder: EasyLoading.init(),
    );
  }
}
