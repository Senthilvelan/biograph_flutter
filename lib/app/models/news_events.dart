
class NewsEvents {
  String? document_id;
  String? published_by;
  String? events_title;
  String? events_image_path;
  String? events_description;
  String? published_date;
  String? status;

  NewsEvents({
    this.document_id,
    this.published_by,
    this.events_title,
    this.events_image_path,
    this.events_description,
    this.published_date,
    this.status,
  });

  factory NewsEvents.fromJson(Map<dynamic, dynamic> jsonData) {
    return NewsEvents(
      document_id: jsonData['document_id'] == null ? "" : jsonData['document_id'],
      published_by: jsonData['published_by'] == null ? "" : jsonData['published_by'],
      events_title: jsonData['events_title'] == null ? "" : jsonData['events_title'],
      events_image_path: jsonData['events_image_path'] == null ? "" : jsonData['events_image_path'],
      events_description: jsonData['events_description'] == null ? "" : jsonData['events_description'],
      published_date: jsonData['published_date'] == null ? "" : jsonData['published_date'],
      status: jsonData['status'] == null ? "" : jsonData['status'],
    );
  }
}
