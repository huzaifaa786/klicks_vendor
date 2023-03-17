class Notifications {
  int? id;
  String? user;
  String? title;
  String? body;
  //  DateTime? dateTime;

  Notifications(notification) {
    id = notification['id'];

    title = notification['title'] ;
    user = notification['user']['name'] ?? '';
    body = notification['body'];
  }
}
