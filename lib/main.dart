import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_app/models/cart_manager.dart';
import 'package:loja_virtual_app/models/product.dart';
import 'package:loja_virtual_app/models/product_manager.dart';
import 'package:loja_virtual_app/models/user_manager.dart';
import 'package:loja_virtual_app/screens/base/base_screen.dart';
import 'package:loja_virtual_app/screens/cart/cart_screen.dart';
import 'package:loja_virtual_app/screens/login/login_screen.dart';
import 'package:loja_virtual_app/screens/product/product_detail_screen.dart';
import 'package:loja_virtual_app/screens/sign_up/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserManager(), lazy: false),
        ChangeNotifierProvider(create: (_) => ProductManager(), lazy: false),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager!..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Loja Virtual',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Color.fromARGB(255, 4, 125, 141),
          ),
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/base':
              return MaterialPageRoute(builder: (_) => BaseScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/cart':
              return MaterialPageRoute(builder: (_) => const CartScreen());
            case '/product_detail':
              return MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                      product: settings.arguments as Product));
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
