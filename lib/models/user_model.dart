
class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({required this.uid, required this.name, required this.email});



  Map<String, String> userModelToJSON() {
    return {
      'uid':uid,
      'name':name,
      'email':email
    };
  }
}
  UserModel userModelFromJSON(Map<String, dynamic> data) {
    return UserModel(
        uid: data['uid'], name: data['name'], email: data['email']);
  }