enum UserRole { admin, user }

class UserSession {
  static UserRole currentRole =
      UserRole.admin; // Ubah ke UserRole.user untuk tes tampilan pengguna
}
