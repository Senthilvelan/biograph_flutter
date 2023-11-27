
import 'dart:convert';

class AnswerDetails {
  String? optionId;
  String? option;
  bool? none;
  bool? selected;
  int? weightage;

  AnswerDetails({
    this.optionId,
    this.option,
    this.none,
    this.selected,
    this.weightage,
  });

  factory AnswerDetails.fromJson(Map<dynamic, dynamic> jsonData) {
    return AnswerDetails(
      optionId: jsonData['optionId'],
      option: jsonData['option'],
      none: jsonData['none'],
      selected: jsonData['selected'],
      weightage: jsonData['weightage'],
    );
  }


  getJson() {
    var data = {
      'optionId': optionId,
      'option': option,
      'none': none,
      'selected': selected,
      'weightage': weightage
    };

    return json.encode(data);
  }
}
