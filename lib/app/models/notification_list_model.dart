
class NotificationList {
  String? title;
  String? message;
  String? body;
  String? page;
  int? notificationId;

  NotificationList({
    this.title,
    this.message,
    this.body,
    this.page,
    this.notificationId,
  });

  factory NotificationList.fromJson(Map<dynamic, dynamic> jsonData) {
    return NotificationList(
      title: jsonData['title'],
      message: jsonData['message'],
      body: jsonData['body'],
      page: jsonData['page'],
      notificationId: jsonData['notificationId'],
    );
  }
}
