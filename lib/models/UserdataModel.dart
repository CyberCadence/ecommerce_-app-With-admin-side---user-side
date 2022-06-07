class UserDataModel {
  String useremail;
  String useruid;

  UserDataModel({required this.useremail, required this.useruid});

  UserDataModel.fromMap(Map<String, dynamic> map)
      : useremail = map['useremail'] ?? "",
        useruid = map['useruid'] ?? "";

  Map<String, dynamic> toMap() {
    return {'useremail': useremail, 'useruid': useruid};
  }
}
