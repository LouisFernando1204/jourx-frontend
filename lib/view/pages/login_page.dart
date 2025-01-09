part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginViewmodel loginViewmodel = LoginViewmodel();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  bool notRegistered = false;

  Future<dynamic> handleGoogleSignIn() async {
    notRegistered = false;
    user = null;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.additionalUserInfo!.isNewUser) {
          notRegistered = true;
        }

        user = userCredential.user;

        return true;
      }

      return false;
    } catch (error) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider<LoginViewmodel>(
        create: (_) => loginViewmodel,
        child: Stack(
          children: [
            // Background gradient
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0284C7),
                    Color(0xFF00B5D4)
                  ], // Ganti dengan gradien cyan
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
            // Main content wrapped inside SingleChildScrollView
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.1), // To provide space from top
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Isi email dan mulai ceritamu!',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            "Password",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Container(
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
                          ),
                          const SizedBox(height: 24.0),
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
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Sedang memproses akun...'),
                                      backgroundColor: Colors.blue,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  await loginViewmodel.loginWithoutGmail(
                                      emailController.text,
                                      passwordController.text);

                                  if (loginViewmodel.loginStatus ==
                                          Status.success &&
                                      loginViewmodel.user != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Berhasil login sebagai ${loginViewmodel.user?.email}!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else if (loginViewmodel.loginStatus ==
                                      Status.error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Login gagal: ${loginViewmodel.loginErrorMessage}'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Email atau password tidak boleh kosong!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: Text(
                              "Atau masuk menggunakan",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                var success = await handleGoogleSignIn();
                                if (success) {
                                  if (notRegistered) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Mengarahkan ke kolom registrasi...'),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ColumnPage(user: user)));
                                  } else {
                                    // if (user != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Sedang memproses akun...'),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );

                                    await loginViewmodel.loginAccountFromGmail(
                                        user!.uid, user!.email!);

                                    if (loginViewmodel.loginFromGmailStatus ==
                                        Status.success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Berhasil login sebagai ${loginViewmodel.user?.email}!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (loginViewmodel
                                            .loginFromGmailStatus ==
                                        Status.error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Login gagal: ${loginViewmodel.loginErrorMessage}'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } 
                                  }
                                  // }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Login gagal! Harap coba lagi!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 10.0,
                                      spreadRadius: 3.0,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/google_icon.png',
                                    width: 48.0,
                                    height: 48.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.black), // Default color
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: "Belum punya akun? ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Daftar di sini.",
                                      style:
                                          TextStyle(color: Color(0xFF0284C7)),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
