class CartItem {
  final int rowId;
  final int id;
  final String nameAr;
  final String nameEn;
  final String price;
  final String quantity;
  final String imageName;
  CartItem(
      {
        this.rowId,
        this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.quantity='0',
      this.imageName});
  factory CartItem.fromjson(Map<String, dynamic> data) 
  {
    return CartItem(
      rowId: data['row_id'],
      id: data['id'],
      nameAr: data['name_ar'],
      nameEn: data['name_en'],
      price: data['price'],
      quantity: data['quantity'],
      imageName: data['image'],
    );
  }
}
