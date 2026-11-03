import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/validators.dart';

class LoginPage extends StatefulWidget {
  final User account;

  const LoginPage({
    super.key,
    required this.account,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool loginSuccess = false;
  String message = '';
  int failedAttempts = 0;

  // Proses Login
  void submitLogin() {
    if (!formKey.currentState!.validate()) return;

    final inputUsername = usernameController.text.trim();

    final success =
        inputUsername == widget.account.name &&
        passwordController.text == widget.account.password;

    setState(() {
      loginSuccess = success;

      if (success) {
        failedAttempts = 0;
        message = 'Login berhasil. Selamat datang, ${widget.account.name}!';
      } else {
        failedAttempts++;
        message = failedAttempts >= 3
            ? 'Login gagal 3 kali. Periksa kembali Username dan Password.'
            : 'Username atau Password salah.';
      }
    });
  }

  // Reset Form
  void resetLogin() {
    formKey.currentState?.reset();
    usernameController.clear();
    passwordController.clear();

    setState(() {
      message = '';
      loginSuccess = false;
      failedAttempts = 0;
      obscurePassword = true;
    });
  }

  // Kolom Input
  Widget buildInput({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
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
            child: Icon(
              icon,
              color: const Color(0xFF31487A),
            ),
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
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
                      // Tombol Kembali
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
                        width: 230 * scale,
                        height: 230 * scale,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Judul
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        'Login to your account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 45 * scale),

                      // Form Login
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 57 * scale,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Username
                              buildInput(
                                hint: 'Username',
                                icon: Icons.person_outline,
                                controller: usernameController,
                                validator: validateNameInput,
                              ),

                              SizedBox(height: 25 * scale),

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

                              SizedBox(height: 40 * scale),

                              // Tombol Masuk
                              SizedBox(
                                width: 219 * scale,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: submitLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF192338),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Masuk'),
                                ),
                              ),

                              // Pesan Login
                              if (message.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: loginSuccess
                                          ? Colors.green
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              if (failedAttempts > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Percobaan gagal: $failedAttempts',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              SizedBox(height: 30 * scale),

                              // Pembatas Google
                              const Row(
                                children: [
                                  Expanded(
                                    child: Divider(color: Colors.white),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      'Or sign up with',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(color: Colors.white),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20 * scale),

                              // Google
                              SizedBox(
                                width: 259 * scale,
                                height: 42,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Login Google belum diaktifkan.',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  label: const Text(
                                    'Daftar dengan Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 35 * scale),

                              // Kembali ke Welcome
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  "Don't have an account? Sign up here",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),

                              SizedBox(height: 50 * scale),

                              // Footer
                              const Text(
                                'Sistem Smart Mikro-Grid ITH 2026',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),

                              SizedBox(height: 15 * scale),
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