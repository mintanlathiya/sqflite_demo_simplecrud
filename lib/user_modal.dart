class UserDetailModel {
  int? id;
  String fName;
  String mName;
  String lName;

  UserDetailModel(
      {this.id, required this.fName, required this.mName, required this.lName});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        fName: json['fName'],
        mName: json['mName'],
        lName: json['lName'],
      );
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) {
      data['id'] = id;
    }
    data['fName'] = fName;
    data['mName'] = mName;
    data['lName'] = lName;
    return data;
  }
}
