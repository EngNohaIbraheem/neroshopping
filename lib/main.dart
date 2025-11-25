import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/config/api_sevice.dart';
import 'core/config/shered_perferences.dart';
import 'core/routes_manager/route_generator.dart';
import 'core/routes_manager/routes.dart';
import 'features/auth/presentation/manger/auth_cubit.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
 await  CashHelper.initCashHeLper();
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          BlocProvider(
            create: (context) => AuthCubit(ApiService(Dio())),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: child,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: CashHelper.getData(key: MyCashKey.token) == null
                  ? Routes.signInRoute
              :Routes.mainRoute
            ),
          ),
    );
  }
}
