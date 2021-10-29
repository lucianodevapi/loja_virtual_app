import 'package:flutter/material.dart';
import 'package:loja_virtual_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_app/models/page_manager.dart';
import 'package:loja_virtual_app/screens/products/products_screen.dart';
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
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Início'),
            ),
          ),
          const ProductsScreen(),
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
