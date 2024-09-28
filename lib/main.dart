import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash.dart';
import 'package:jop_finder_app/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JopFinderApp());
}

class JopFinderApp extends StatelessWidget {
  const JopFinderApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return const MaterialApp(
          // routerConfig: Approuter.router,
          debugShowCheckedModeBanner: false,
          home: Splashscreen(),
        );
      },
    );
  }
}
