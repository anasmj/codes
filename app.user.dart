class AppUser {
  String? userId, email, name, iamgeUrl, password;

  AppUser({
    this.userId,
    this.email,
    this.name,
    this.password,
    this.iamgeUrl,
  });

  //returns a map
  static Map<String, dynamic> toJson() => {};

  //convert to AppUser object
  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
        userId: json['id'],
        name: json['name'],
        email: json['email'],
      );
}
