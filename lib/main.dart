import 'package:connectivity/connectivity.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:trim/modules/auth/cubits/activate_cubit.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/cubit/app_states.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/categories_cubit.dart';
import 'package:trim/modules/market/cubit/products_category_cubit.dart';
import 'package:trim/modules/market/cubit/search_bloc.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/Bloc/products_order_bloc.dart';
import 'package:trim/modules/settings/cubits/settings_cubit.dart';
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
  final _connectivity = Connectivity();
  @override
  void initState() {
    super.initState();
    initializeConnectivity();
    AppCubit.getInstance(context).intializeDio(widget.token);
  }

  Future<void> initializeConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {}
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => ProductsOrderBloc()),
        BlocProvider<ActivateCubit>(create: (_) => ActivateCubit())
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
          builder: DevicePreview.appBuilder,
          home: widget.token == null ? LoginScreen() : HomeScreen(),
          routes: routes),
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
