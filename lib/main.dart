import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';
import 'package:jop_finder_app/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => JobSearchCubit(),
    child: BlocProvider(
      create: (context) => AuthCubit(),
      child: const JopFinderApp(),
    ),
  ));
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
          theme: appTheme,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
