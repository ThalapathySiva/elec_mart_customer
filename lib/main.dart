import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/login.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("background");
  }

  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final HttpLink httpLink = HttpLink(
    uri: 'http://cezhop.herokuapp.com/graphql',
  );
  bool isAuthenticated = false;
  @override
  void initState() {
    _getPref();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: WHITE_COLOR, statusBarIconBrightness: Brightness.dark));

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: httpLink as Link,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
          child: ChangeNotifierProvider<AppState>(
        builder: (_) => AppState(),
        child: ChangeNotifierProvider<CartState>(
          builder: (_) => CartState(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Quicksand', scaffoldBackgroundColor: WHITE_COLOR),
            home: isAuthenticated ? NavigateScreens() : Login(),
          ),
        ),
      )),
    );
  }

  _getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }
}
