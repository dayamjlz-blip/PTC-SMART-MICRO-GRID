import 'package:flutter/material.dart';
import 'package:smart_mikro_grid/models/user.dart';
import 'package:smart_mikro_grid/utils/validators.dart';

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

  // Proses pendaftaran
  void submitRegistration() {
    if (!formKey.currentState!.validate()) return;

    final user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      role: 'Pengguna',
    );

    Navigator.pop(context, user);
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
          fillColor: const Color.fromARGB(255, 255, 255, 255),
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
                        width: 230 * scale,
                        height: 230 * scale,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Judul
                      const Text(
                        'Welcome back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        'Create your account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 35 * scale),

                      // Formulir
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
                                controller: nameController,
                                validator: validateNameInput,
                              ),

                              SizedBox(height: 23 * scale),

                              // Email
                              buildInput(
                                hint: 'Email',
                                icon: Icons.email_outlined,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmailInput,
                              ),

                              SizedBox(height: 23 * scale),

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

                              SizedBox(height: 23 * scale),

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

                              SizedBox(height: 35 * scale),

                              // Tombol Daftar
                              SizedBox(
                                width: 219 * scale,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: submitRegistration,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF192338),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Daftar'),
                                ),
                              ),

                              SizedBox(height: 20 * scale),

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

                              // Tombol Google
                              SizedBox(
                                width: 259 * scale,
                                height: 42,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Pendaftaran Google belum diaktifkan.',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.g_mobiledata,
                                    size: 25,
                                    color: Colors.blue,
                                  ),
                                  label: const Text(
                                    'Daftar dengan Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 255, 255),
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 35 * scale),

                              // Reset Form
                              TextButton(
                                onPressed: resetRegistration,
                                child: const Text(
                                  'Reset Form',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                              SizedBox(height: 15 * scale),

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