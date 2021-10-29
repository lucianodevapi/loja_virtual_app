import 'package:flutter/material.dart';
import 'package:loja_virtual_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_app/models/page_manager.dart';
import 'package:loja_virtual_app/screens/login/login_screen.dart';
import 'package:loja_virtual_app/screens/sign_up/signup_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pagecontroller = PageController();

  BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Pagemanager(pagecontroller),
      child: PageView(
        controller: pagecontroller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //SignUpScreen(),
          //LoginScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Início'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Produtos'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Meus Produtos'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Lojas'),
            ),
          ),
        ],
      ),
    );
  }
}
