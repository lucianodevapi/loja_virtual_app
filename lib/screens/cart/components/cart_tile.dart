import 'package:flutter/material.dart';
import 'package:loja_virtual_app/common/custom_icom_button.dart';
import 'package:loja_virtual_app/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.images.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(
                        builder: (_, cartProduct, __) {
                          return Text(
                            cartProduct.hasStock
                                ? 'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}'
                                : 'Estoque indisponível',
                            style: TextStyle(
                              color: cartProduct.hasStock ? _color : Colors.red,
                              fontSize: cartProduct.hasStock ? 16 : 14,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                builder: (_, cartProduct, __) {
                  return Column(
                    children: [
                      CustomIconButtom(
                        iconData: Icons.add,
                        color: _color,
                        onTap: cartProduct.increment,
                      ),
                      Text(
                        '${cartProduct.quantity}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      CustomIconButtom(
                        iconData: Icons.remove,
                        color: cartProduct.quantity <= 1 ? Colors.red : _color,
                        onTap: cartProduct.decrement,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
