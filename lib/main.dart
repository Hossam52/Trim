import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/colors.dart';
import 'package:trim/modules/auth/cubits/activate_cubit.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/cubit/app_states.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/categories_cubit.dart';
import 'package:trim/modules/market/cubit/products_category_cubit.dart';
import 'package:trim/modules/market/cubit/search_bloc.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/Bloc/products_order_bloc.dart';
import 'package:trim/utils/services/sercure_storage_service.dart';
import './constants/app_constant.dart';
import './config/routes/routes_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'appLocale/appLocale.dart';
import 'bloc_observer.dart';
import './modules/auth/cubits/auth_cubit.dart';
import './modules/payment/cubits/payment_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String token = await TrimShared.getDataFromShared('token');
  print('From Main ${TrimShared.token}');
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => BlocProvider<AppCubit>(
          create: (_) => AppCubit(),
          child: BlocBuilder<AppCubit, AppStates>(
              builder: (_, __) => MyApp(token: token))),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String token;

  MyApp({Key key, this.token}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppCubit.getInstance(context).intializeDio(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => AllCategoriesBloc()),
        BlocProvider(create: (_) => ProductsCategoryBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => SalonsCubit()),
        BlocProvider(create: (_) => PersonsCubit()),
        BlocProvider(create: (_) => ProductsCategoryCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ReservationCubit()),
        BlocProvider(create: (_) => PaymentCubit()),
        BlocProvider(create: (_) => ProductsOrderBloc()),
        BlocProvider(create: (_) => ActivateCubit())
      ],
      child: MaterialApp(
          title: 'Trim',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('ar', ''),
          ],
          localeResolutionCallback: (currentLocale, supportedLocales) {
            if (currentLocale != null) {
              print(currentLocale.languageCode);
            }

            for (Locale locale in supportedLocales) {
              if (currentLocale.languageCode == locale.languageCode)
                return currentLocale;
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
              primaryColor: primaryColor,
              accentColor: secondaryColor,
              fontFamily: 'Cairo',
              textTheme: TextTheme(button: TextStyle(fontSize: 20))),
          builder: DevicePreview.appBuilder,
          home: Builder(builder: (ctx) => fetchFirstScreen(ctx)),
          routes: routes),
    );
  }

  Widget fetchFirstScreen(BuildContext ctx) {
    if (widget.token == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
