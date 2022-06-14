import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orquideas_chilpancingo/pages/Auth/user_login.dart';
import 'package:orquideas_chilpancingo/pages/cart.dart';
import 'package:orquideas_chilpancingo/pages/home/home.dart';
import 'package:orquideas_chilpancingo/providers/badge_provider.dart';
import 'package:orquideas_chilpancingo/providers/carrito_provider.dart';
import 'package:orquideas_chilpancingo/providers/enviroment.dart';
import 'package:orquideas_chilpancingo/providers/models/orquideas_model.dart';
import 'package:orquideas_chilpancingo/providers/models/user_model.dart';
import 'package:orquideas_chilpancingo/theme/theme_orquideas.dart';
import 'package:orquideas_chilpancingo/widgets/bottom_navigation_bar/bottom_bar.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(
    fileName: Enviroment.fileName,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BadgeProvider()),
        ChangeNotifierProvider(create: (_) => OrquideasProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CarritoProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orquideas Chilpancingo',
        theme: orquideasChilpoTheme(),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool user = false;
  bool home = true;
  bool cart = false;
  late Widget body;

  @override
  Widget build(BuildContext context) {
    body = (user)
        ? const Login()
        : (home)
            ? const Home()
            : const ShoppingCart();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      //val = home
      //val1 = user
      //val2 = cart
      bottomNavigationBar: BottomBar(
        user: user,
        home: home,
        cart: cart,
        change: (bool val, bool val1, bool val2) => setState(() {
          home = val;
          user = val1;
          cart = val2;
        }),
      ),
      body: body,
    );
  }
}
