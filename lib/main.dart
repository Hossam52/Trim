import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/cities_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/categories_cubit.dart';
import 'package:trim/modules/market/cubit/products_category_cubit.dart';
import 'package:trim/modules/market/cubit/search_bloc.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/Bloc/products_order_bloc.dart';
import 'package:trim/modules/settings/cubits/settings_cubit.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/services/sercure_storage_service.dart';
import './constants/app_constant.dart';
import './config/routes/routes_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'appLocale/appLocale.dart';
import 'bloc_observer.dart';
import './modules/auth/cubits/auth_cubit.dart';
import './modules/home/cubit/cities_cubit.dart';
import './modules/payment/screens/payment_methods_screen.dart';
import './modules/payment/cubits/payment_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TrimShared.getDataFromShared('token');
  print('From Main${TrimShared.token}');
  Bloc.observer = MyBlocObserver();

  DioHelper.init(
      accessToken:
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMGFlY2Q2N2JlMmE5Y2RkZTUyMTUxYTlhYWM3NGM4MDU3ZWNjOTVkY2FjNzhiZTRlOTY0MDQzYzEwN2M1OWJhNGMxNTA4ZTZhNzMyOGZkOWIiLCJpYXQiOjE2MjEwODg2MTUsIm5iZiI6MTYyMTA4ODYxNSwiZXhwIjoxNjUyNjI0NjE1LCJzdWIiOiI0NyIsInNjb3BlcyI6W119.H9f6p4Je9JJUiWBe3AOXA1oKebL0EQRXsi7vsQaJy1joXW1jn2xuuwMalrjOeNbWyw9bNJj-EZDJ9wJc62SUUUUj7vyn8OIcSz2c6ezt-wshGtRv5U7rhEhFmTuThTfXaUorrHr4iDtA3Nq8bR9uiYmLuThOrAB-ewnrmXXnS6J9OTSUp4Z_qyfESA83j99uWlQX5s_E9TX_bkObJaHBThn1OidUqi40qBtdnUBJFF7XJki-kMFDyVC27uiK35wcBD1LttbJiXC0qV9pVd9Xu7dGDLTVhqHFe_2HQ5Dnvwd6QEAlTbkrfHeo3d9mL7lLUP9XGyf1CMgpz0Ef52wGKRKjsEeWAu8t34X7eax9nz6za2j49s5qdNrPGD-0ug6L3uL1ZOkEVOVaI_8sLKLSOwQJ9CBxy-SXU2UGWORoAsUykwE9Qr9NGmdLW_ZDSApCOLI0HFvCd6n5FyHbgEvdwpT8e3E8EXbnN1xoKSh-uEHjZUmueglorN-4HOtMImm0OF_NLmk7h99lyUn51VuuubUpBVAwGABd0faxmxjfeatnuCOUmca1-iZJYu_21ehRheNxDziw8QWZHW5ptFyf0JSyq0tnslW5DOIvRgNpeHBufJY9s6R9gp666WtVEf2Bp_SAX-ki1oIOnGI7tL5UQoqus64J7tFM8z0wCH6ujlg');
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TrimShared.saveDataToShared('token', 'hossam');
    // TrimShared.removeFromShared('token');

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => AllCategoriesBloc()),
        BlocProvider(create: (_) => ProductsCategoryBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (_) => SalonsCubit()),
        BlocProvider(create: (_) => PersonsCubit()),
        BlocProvider(create: (_) => ProductsCategoryCubit()),
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ReservationCubit()),
        BlocProvider(create: (context) => CitiesCubit()),
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => ProductsOrderBloc()),
      ],
      child: MaterialApp(
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
              // isArabic = currentLocale.languageCode == 'en' ? false : true;
              print(currentLocale.languageCode);
            }

            for (Locale locale in supportedLocales) {
              if (currentLocale.languageCode == locale.languageCode)
                return currentLocale;
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
              textTheme:
                  TextTheme(button: TextStyle(fontSize: defaultFontSize))),
          // home: SplashScreen(alpha: 100, color: Color(0xff2B73A8)),
          builder: DevicePreview.appBuilder,
          home: HomeScreen(),
          routes: routes),
    );
  }
}

class TestApi extends StatefulWidget {
  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final response = await DioHelper.postData(url: 'allSalons');
            try {
              (response.data['data'] as List<dynamic>).forEach((element) {
                // print(element);
                print('-------------------------------------------------');
                element.forEach((key, value) {
                  print('$key =>  $value');
                });
                print('-------------------------------------------------');
                print('\n');
              });
            } catch (e) {
              print(response.data);
            }
          }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BlocBuilder<OffersCubit, HomeStates>(
          //   builder: (_, state) => Conditional.single(
          //     context: context,
          //     conditionBuilder: (_) {
          //       return state is LoadingOffersState;
          //     },
          //     widgetBuilder: (_) => CircularProgressIndicator(),
          //     fallbackBuilder: (_) => Container(child: Text('Offers')),
          //   ),
          // ),
          // BlocBuilder<MostSearchCubit, HomeStates>(
          //   builder: (_, state) => Conditional.single(
          //     context: context,
          //     conditionBuilder: (_) => state is LoadingMostSearchState,
          //     widgetBuilder: (_) => CircularProgressIndicator(),
          //     fallbackBuilder: (_) => Container(child: Text('MostSearch')),
          //   ),
          // ),
          // BlocBuilder<TrimStarsCubit, HomeStates>(
          //   builder: (_, state) => Conditional.single(
          //     context: context,
          //     conditionBuilder: (_) => state is LoadingTrimStarsState,
          //     widgetBuilder: (_) => CircularProgressIndicator(),
          //     fallbackBuilder: (_) => Container(child: Text('Stars')),
          //   ),
          // )
        ],
      ),
    );
  }
}

class PaymentGateway extends StatefulWidget {
  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  String _isInit = "false";

  String cardNumber = '';
  String expiryDate = '';
  String cardNameHolder = '';
  String cvv = '';
  bool cvvFocused = false;

  @override
  void initState() {
    super.initState();
    initPaymentSDK();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPaymentSDK() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool isSuccess = await FlutterCheckoutPayment.init(
          key: "pk_test_e0f594e7-277b-468b-9f73-c94ebe312278");
      //bool isSuccess =  await FlutterCheckoutPayment.init(key: "${Keys.TEST_KEY}", environment: Environment.LIVE);
      print(isSuccess);
      if (mounted) setState(() => _isInit = "true");
    } on PlatformException {
      if (mounted) setState(() => _isInit = "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout Payment Plugin'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Checkout Init: $_isInit", style: TextStyle(fontSize: 18)),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardNameHolder,
                cvvCode: cvv,
                showBackView: cvvFocused,
                height: 180,
                width: 305,
                animationDuration: Duration(milliseconds: 1000),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: _onModelChange,
                    cardHolderName: '',
                    cardNumber: '',
                    cvvCode: '',
                    expiryDate: '',
                    formKey: null,
                    themeColor: Colors.red,
                  ),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "Generate Token",
                                  style: TextStyle(fontSize: 14),
                                )),
                            onPressed: _generateToken,
                          ),
                          ElevatedButton(
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "Card Validation",
                                  style: TextStyle(fontSize: 14),
                                )),
                            onPressed: _cardValidation,
                          )
                        ]),
                    ElevatedButton(
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Generate Token with Address",
                            style: TextStyle(fontSize: 14),
                          )),
                      onPressed: _generateTokenWithAddress,
                    )
                  ]),
              SizedBox(height: 10)
            ],
          ),
        ));
  }

  void _onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardNameHolder = model.cardHolderName;
      cvv = model.cvvCode;
      cvvFocused = model.isCvvFocused;
    });
  }

  Future<void> _generateToken() async {
    try {
      // Show loading dialog
      showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future<bool>.value(false),
              child: AlertDialog(
                title: Text("Loading..."),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[CircularProgressIndicator()]),
              ));
        },
      );

      String number = cardNumber.replaceAll(" ", "");
      String expiryMonth = expiryDate.substring(0, 2);
      String expiryYear = expiryDate.substring(3);

      print("$cardNumber, $cardNameHolder, $expiryMonth, $expiryYear, $cvv");

      CardTokenisationResponse response =
          await FlutterCheckoutPayment.generateToken(
              number: number,
              name: cardNameHolder,
              expiryMonth: expiryMonth,
              expiryYear: expiryYear,
              cvv: cvv);

      // Hide loading dialog
      Navigator.pop(context);

      // Show result dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Token"),
            content: Text("${response.token}"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        },
      );
    } catch (ex) {
      // Hide loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        },
      );
    }
  }

  Future<void> _generateTokenWithAddress() async {
    try {
      // Show loading dialog
      showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future<bool>.value(false),
              child: AlertDialog(
                title: Text("Loading..."),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[CircularProgressIndicator()]),
              ));
        },
      );

      String number = cardNumber.replaceAll(" ", "");
      String expiryMonth = expiryDate.substring(0, 2);
      String expiryYear = expiryDate.substring(3);

      print("$cardNumber, $cardNameHolder, $expiryMonth, $expiryYear, $cvv");

      CardTokenisationResponse response =
          await FlutterCheckoutPayment.generateToken(
              number: number,
              name: cardNameHolder,
              expiryMonth: expiryMonth,
              expiryYear: expiryYear,
              cvv: cvv,
              billingModel: BillingModel(
                  addressLine1: "address line 1",
                  addressLine2: "address line 2",
                  postcode: "postcode",
                  country: "UK",
                  city: "city",
                  state: "state",
                  phoneModel:
                      PhoneModel(countryCode: "+44", number: "07123456789")));

      // Hide loading dialog
      Navigator.pop(context);

      // Show result dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Token"),
            content: Text("${response.token}"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        },
      );
    } catch (ex) {
      // Hide loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        },
      );
    }
  }

  Future<void> _cardValidation() async {
    try {
      // Show loading dialog
      showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future<bool>.value(false),
              child: AlertDialog(
                title: Text("Loading..."),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[CircularProgressIndicator()]),
              ));
        },
      );

      String number = cardNumber.replaceAll(" ", "");

      print("$cardNumber");

      bool isValid = await FlutterCheckoutPayment.isCardValid(number: number);

      // Hide loading dialog
      Navigator.pop(context);

      // Show result dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Validation? "),
            content: Text("$isValid"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        },
      );
    } catch (ex) {
      // Hide loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        },
      );
    }
  }
}
