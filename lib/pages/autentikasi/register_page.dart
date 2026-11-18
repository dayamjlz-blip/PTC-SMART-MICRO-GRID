import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';
import 'package:smart_mikro_grid/navigation/main_navigation.dart';
import 'package:smart_mikro_grid/utils/validators.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Proses pendaftaran -> Otomatis role Pengguna & langsung masuk ke Dashboard
  void submitRegistration() {
    if (!formKey.currentState!.validate()) return;

    final user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      role: 'Pengguna',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pendaftaran berhasil! Selamat datang, ${user.name}.'),
        backgroundColor: Colors.green,
      ),
    );

    // Hapus tumpukan layar autentikasi & langsung arahkan ke MainNavigation
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigation(account: user),
      ),
      (route) => false,
    );
  }

  // Reset formulir
  void resetRegistration() {
    formKey.currentState?.reset();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    setState(() {
      obscurePassword = true;
      obscureConfirmPassword = true;
    });
  }

  // Membuat kolom input
  Widget buildInput({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF554D4D),
            fontSize: 13,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF31487A)),
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color(0xFF31487A),
            ),
          ),
          errorStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD9E1F1),
              Color(0xFF4566AD),
              Color(0xFF31487A),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final scale = constraints.maxWidth / 412;

              return SingleChildScrollView(
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 8 * scale),

                      // Tombol kembali
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF192338),
                          ),
                        ),
                      ),

                      // Logo
                      SizedBox(
                        width: 190 * scale,
                        height: 190 * scale,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.bolt_rounded,
                            size: 90,
                            color: Color(0xFF0066FF),
                          ),
                        ),
                      ),

                      // Judul
                      const Text(
                        'Buat Akun Pengguna',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Daftar untuk langsung memantau sistem',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 28 * scale),

                      // Formulir
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40 * scale,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Username
                              buildInput(
                                hint: 'Username',
                                icon: Icons.person_outline,
                                controller: nameController,
                                validator: validateNameInput,
                              ),

                              SizedBox(height: 18 * scale),

                              // Email
                              buildInput(
                                hint: 'Email',
                                icon: Icons.email_outlined,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmailInput,
                              ),

                              SizedBox(height: 18 * scale),

                              // Password
                              buildInput(
                                hint: 'Password',
                                icon: Icons.lock_outline,
                                controller: passwordController,
                                obscure: obscurePassword,
                                validator: validatePasswordInput,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(height: 18 * scale),

                              // Konfirmasi Password
                              buildInput(
                                hint: 'Konfirmasi Password',
                                icon: Icons.lock_outline,
                                controller: confirmPasswordController,
                                obscure: obscureConfirmPassword,
                                validator: (value) {
                                  return validateConfirmPassword(
                                    value,
                                    passwordController.text,
                                  );
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmPassword =
                                          !obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(height: 28 * scale),

                              // Tombol Daftar
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: submitRegistration,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF192338),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: const Text(
                                    'Daftar & Masuk',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16 * scale),

                              // Tautan ke Login (khusus yang sudah punya akun / Admin)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sudah punya akun? ',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Masuk di sini',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8 * scale),

                              // Reset Form
                              TextButton(
                                onPressed: resetRegistration,
                                child: const Text(
                                  'Reset Form',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),

                              SizedBox(height: 16 * scale),

                              // Footer
                              const Text(
                                'Sistem Smart Micro-Grid ITH 2026',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),

                              SizedBox(height: 16 * scale),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
