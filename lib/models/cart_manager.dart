import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_app/models/cart_product.dart';
import 'package:loja_virtual_app/models/product.dart';
import 'package:loja_virtual_app/models/user_app.dart';
import 'package:loja_virtual_app/models/user_manager.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  UserApp? userApp;
  num productsPrice = 0.0;

  void updateUser(UserManager userManager) {
    if (userManager.userLogged != null) {
      userApp = userManager.userLogged;
      items.clear();
      if (userApp!.id != null) {
        _loadCartItems();
      }
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await userApp!.cartReference.get();
    items = cartSnap.docs
        .map((document) =>
            CartProduct.fromDocument(document)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      userApp!.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }

    debugPrint(product.name);
  }

  void _onItemUpdated() {
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        _removeOfCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
      notifyListeners();
    }

    print(productsPrice);
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      userApp!.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
    }
  }

  void _removeOfCart(CartProduct cartProduct) {
    items.removeWhere((produto) => produto.id == cartProduct.id);
    userApp!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) {
        return false;
      }
    }
    return true;
  }
}
