class SaleModal {
  int? id;

  String? user;
  String? cartype;
  String? price;
  DateTime? dateTime;

  SaleModal(order) {
    id = order['id'];

    dateTime = DateTime.parse(order['created_at']);
    price = order['totalpayment'] ?? '';
    user = order['user']['name'] ?? '';
    cartype = order['cartype'];
  }
}
