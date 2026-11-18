enum UserRole { admin, Pengguna }

class UserSession {
  static UserRole currentRole =
      UserRole.Pengguna; // Ubah ke UserRole.Pengguna untuk tes tampilan pengguna
}
