String? validateNameInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Nama tidak boleh kosong';
  }
  return null;
}

String? validateNimInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'NIM tidak boleh kosong';
  }
  // Validasi khusus form pendaftaran: HANYA boleh diisi angka
  final isNumeric = RegExp(r'^[0-9]+$').hasMatch(value);
  if (!isNumeric) {
    return 'NIM hanya boleh berisi angka';
  }
  // Validasi panjang NIM minimal 9 digit
  if (value.length < 9) {
    return 'NIM harus memiliki minimal 9 digit angka';
  }
  return null;
}

String? validateEmailInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email tidak boleh kosong';
  }
  if (!value.contains('@')) {
    return 'Format email tidak valid';
  }
  return null;
}

String? validatePasswordInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Kata sandi tidak boleh kosong';
  }
  if (value.length < 6) {
    return 'Kata sandi minimal 6 karakter';
  }
  return null;
}

// Validator khusus untuk halaman Login (bisa menerima Email ATAU NIM)
String? validateEmailOrNimInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email atau NIM tidak boleh kosong';
  }

  // Mengecek apakah inputan HANYA berisi angka (berarti user mencoba login pakai NIM)
  final isNumeric = RegExp(r'^[0-9]+$').hasMatch(value);

  if (isNumeric) {
    // Logika jika inputan adalah NIM (kurang dari 9 angka)
    if (value.length < 9) {
      return 'NIM harus memiliki minimal 9 digit angka';
    }
  } else {
    // Logika jika inputan bukan angka murni (dianggap Email)
    if (!value.contains('@')) {
      return 'Format Email tidak valid atau NIM kurang angka';
    }
  }

  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.trim().isEmpty) {
    return 'Konfirmasi kata sandi tidak boleh kosong';
  }
  if (value != password) {
    return 'Kata sandi tidak cocok';
  }
  return null;
}