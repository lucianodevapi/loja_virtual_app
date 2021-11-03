import 'package:flutter/material.dart';
import 'package:loja_virtual_app/common/price_card.dart';
import 'package:loja_virtual_app/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          print(cartManager.isCartValid);
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct: cartProduct))
                    .toList(),
              ),
              PriceCard(
                text: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid ? () {} : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
