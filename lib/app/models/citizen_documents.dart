
class CitizenDocuments {
  String? docName;
  String? actualFileName;
  String? newFileName;
  String? fileExtension;
  String? docNotes;
  String? docRecordDate;
  String? docRecordType;
  String? status;

  CitizenDocuments({
    this.docName,
    this.actualFileName,
    this.newFileName,
    this.fileExtension,
    this.docNotes,
    this.docRecordDate,
    this.docRecordType,
    this.status,
  });

  factory CitizenDocuments.fromJson(Map<dynamic, dynamic> jsonData) {
    return CitizenDocuments(
      docName: jsonData['docName'] == null ? "" : jsonData['docName'],
      actualFileName: jsonData['actualFileName'] == null ? "" : jsonData['actualFileName'],
      newFileName: jsonData['newFileName'] == null ? "" : jsonData['newFileName'],
      fileExtension: jsonData['fileExtension'] == null ? "" : jsonData['fileExtension'],
      docNotes: jsonData['docNotes'] == null ? "" : jsonData['docNotes'],
      docRecordDate: jsonData['docRecordDate'] == null ? "" : jsonData['docRecordDate'],
      docRecordType: jsonData['docRecordType'] == null ? "" : jsonData['docRecordType'],
      status: jsonData['status'] == null ? "" : jsonData['status'],
    );
  }
}
