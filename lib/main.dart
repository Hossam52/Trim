import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNTFhMTM4NDJjN2Y0ZDA5NTU0ZjhlNzc2NmNjMWFmYjdkOWFmZDkxYjYwZjQ1YjExZDMzY2E0NzkzZjY3MDgzMzJlZDIwZjBkODEyMGNjYjUiLCJpYXQiOjE2MTk0NzU1MzMsIm5iZiI6MTYxOTQ3NTUzMywiZXhwIjoxNjUxMDExNTMzLCJzdWIiOiI2OCIsInNjb3BlcyI6W119.JS0xpgKHtNTRNdF5fgWq8dj5ILn-GIVTsQZzd_HlDXZkyWmi9j_c216vVT4nqRsBHqrpICI7ctqT9xFIDoeUYubNiKVjEJXZA8BEx7bSqsEVo6z76tfzTorX3iT9f7Naiz6egr7ZOmoseh8mmLS9O3PUHWcgH4CsGZvaYhtNykxwY-4LaRNkfeJbUhZf2KIkGnLfDx7-ne47u_VWc7_s0bO03aADD1LN-6t-5ydk-rVZ18mr4L2Asp49emU8GS5LNSXFo0aSMaMaLNLiGx5qYCp2d97LVSwb-etKaeQslCahPR8KYRMKGIlJn4XhBOBpZBtoEuG1fU4DrJuSbeURDDrzlrDYkgH5k9Tk8NtweXR_0vr-wU5S9--YOcpMJOdavCkQ2veADpgFW9Y6G_DlLSPyHEdILfDHKBzdkTqyBia6vr9JtVXBwrB1LtilM-je8kwzEOBFVp07Fm0oHk6sh6dWjP8AumY09cJzPl7Cx2LfZ5bl8vp0a1wzUiF8MCqzAGfQuj7a-8TDtz56WAphubjLMGpdmZpGHSSeS9P7ecUfHna4OPCqsBuxFWi652nOYPC0qq8z3eU2QqF0l1j7bq01-3ImBl6fPcZjmoh3KjHO5dsuva_Bpy3FrY71bKWBtPD2pv92__cDLMAsinz-ag_0jSm53Re6SuG73XOtIUw');
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
            if (currentLocale != null) print(currentLocale.languageCode);
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
