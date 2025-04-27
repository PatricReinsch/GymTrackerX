class User {
  final int? userId;
  final String? username;
  final String? token;

  User({
    this.userId,
    this.username,
    this.token,
  });

  // Factory method to create a User object from a JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as int?,
      username: json['username'] as String?,
      token: json['token'] as String?,
    );
  }

  // Method to convert the User object into a JSON format
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'token': token,
    };
  }
}
