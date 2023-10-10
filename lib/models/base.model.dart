abstract class Model {
  static String modelIDKey = "uID";

  String? uid;

  Model(this.uid);

  Map<String, dynamic> toJson() {
    return {
      modelIDKey: uid,
    };
  }
}