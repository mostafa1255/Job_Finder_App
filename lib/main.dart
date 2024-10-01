import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
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
        return MaterialApp.router(
          theme: ThemeData(
            fontFamily: 'Poppins',
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.blue, // Change the cursor color to blue
              selectionColor: Colors.blue
                  .withOpacity(0.4), // Text selection color (highlight)
              selectionHandleColor: Colors.blue, // The tear drop color
            ),
          ),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
