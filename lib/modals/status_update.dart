class OrderStatusModel {
  int? id;
  int? status;

  OrderStatusModel(order) {
    id = order['id'];
    status = order['status'];
  }
}
