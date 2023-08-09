abstract class Model {
  static String modelIDKey = "userID";

  String? uid;

  Model(this.uid);

  Map<String, dynamic> toJson() {
    return {
      modelIDKey: uid,
    };
  }
}

class UserModel extends Model {
  static String nameKey = "name";
  static String surnameKey = "surname";
  static String usernameKey = "username";
  static String phoneNumberKey = "phone_number";
  static String emailKey = "email";

  String? name;
  String? surname;
  String? username;
  String? phoneNumber;
  String? email;

  UserModel({
    String? uid,
    this.name,
    this.surname,
    this.username,
    this.phoneNumber,
    this.email,
  }) : super(uid);

  String get fullName => "${name ?? ""} ${surname ?? ""}";

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        uid: map[Model.modelIDKey],
        name: map[nameKey],
        surname: map[surnameKey],
        username: map[usernameKey],
        phoneNumber: map[phoneNumberKey],
        email: map[emailKey]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      nameKey: name,
      surnameKey: surname,
      usernameKey: username,
      phoneNumberKey: phoneNumber,
      emailKey: email,
    }
      ..addAll(super.toJson());
  }

  UserModel copyWith({
    String? name,
    String? surname,
    String? username,
    String? phoneNumber,
    String? email,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }
}
