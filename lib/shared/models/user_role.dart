/// User role enum for the application.
enum UserRole {
  seeker('seeker'),
  employer('employer'),
  admin('admin');

  final String value;
  const UserRole(this.value);

  /// Creates a [UserRole] from a string value.
  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.seeker,
    );
  }
}
