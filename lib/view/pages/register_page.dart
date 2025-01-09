part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  LoginViewmodel loginViewmodel = LoginViewmodel();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  String? selectedGender;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      birthdateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<LoginViewmodel>(
        create: (_) => loginViewmodel,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0284C7), Color(0xFF00B5D4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.white,
              ),
            ),
            SingleChildScrollView(
              // Wrap entire content inside SingleChildScrollView
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang!",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Yuk, mulai catatan kecil untuk perjalanan besar.",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // Name Field
                        Text(
                          "Name",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildTextField(
                            nameController, 'Bisa kenalan? Siapa namamu?'),

                        const SizedBox(height: 16.0),

                        // Email Field
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildTextField(
                            emailController, 'Isi emailmu juga yaa'),

                        const SizedBox(height: 16.0),

                        // Password Field
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildPasswordField(),

                        const SizedBox(height: 16.0),

                        // Birthdate Picker
                        Text(
                          "Tanggal Lahir",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: _buildTextField(
                                birthdateController, 'Pilih tanggal lahir'),
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Gender Dropdown
                        Text(
                          "Gender",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          items: const [
                            DropdownMenuItem(
                                child: Text("Laki-laki"), value: "male"),
                            DropdownMenuItem(
                                child: Text("Perempuan"), value: "female"),
                            DropdownMenuItem(
                                child: Text("Lainnya"), value: "other"),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0284C7),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () async {
                              if (nameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  birthdateController.text.isNotEmpty &&
                                  selectedGender != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Sedang memproses registrasi...'),
                                    backgroundColor: Colors.blue,
                                    duration: Duration(
                                        seconds:
                                            3), // Durasi menampilkan SnackBar
                                  ),
                                );
                                await loginViewmodel.registerAccount(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  birthdateController.text,
                                  selectedGender!,
                                );
                                if (loginViewmodel.registerStatus ==
                                    Status.success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Akun ${loginViewmodel.user!.email} berhasil terdaftar!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else if (loginViewmodel.registerStatus ==
                                    Status.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Registrasi gagal! ${loginViewmodel.registerErrorMessage}'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Semua kolom harus diisi!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Daftar',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black), // Default color
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: "Sudah punya akun? ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Masuk di sini.",
                                    style: TextStyle(color: Color(0xFF0284C7)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  // Password field with obscure text
  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
          hintText: 'Kata sandi aman disini!',
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
