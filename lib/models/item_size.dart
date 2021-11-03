class ItemSize {
  String name = '';
  num price = 0;
  int stock = 0;

  ItemSize({this.name = '', this.price = 0.0, this.stock = 0});

  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock';
  }
}
