class UserDetailModel {
  int? id;
  String fName, mName, lName;
  String gender;
  double age;
  //List hobby;

  UserDetailModel({
    this.id,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.gender,
    required this.age,
    //required this.hobby,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        id: json['id'],
        fName: json['fName'],
        mName: json['mName'],
        lName: json['lName'],
        gender: json['gender'],
        age: json['age'],
        // hobby: List.from(json['hobby'].map((e) => e)).toList(),
      );
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) {
      data['id'] = id;
    }
    data['fName'] = fName;
    data['mName'] = mName;
    data['lName'] = lName;
    data['gender'] = gender;
    // data['hobby'] = List.from(hobby.map((e) => e)).toList();
    data['age'] = age;
    return data;
  }
}
