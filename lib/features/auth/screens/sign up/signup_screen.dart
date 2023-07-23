import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/features/auth/models/user.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/constants/utils.dart';
import '../../controllers/auth_controller.dart';
import '../log in/screens/login_screen.dart';
import '../log in/widgets/custom_signup_button.dart';
import '../log in/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUp(BuildContext context) {
    UserModel model = UserModel(
        name: _nameController.text,
        uid: '',
        coins: '0',
        email: _emailController.text,
        profilePicture: '',
        password: _passwordController.text);

    AuthController controller = AuthController();

    controller.signUp(context, model);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('resources/images/bg_banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 68.0, top: 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sign up to make a \nbrand new Account",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          "Sign up , and make a brand new Account",
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade200,
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  imageFile != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(imageFile!),
                          radius: 40,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/021/548/095/original/default-profile-picture-avatar-user-avatar-icon-person-icon-head-icon-profile-picture-icons-default-anonymous-user-male-and-female-businessman-photo-placeholder-social-network-avatar-portrait-free-vector.jpg'),
                          radius: 40,
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        pickImage(context);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.green,
                      ),
                    ),
                    top: 40,
                    left: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Name',
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                isObscure: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  signUp(context);
                },
                child: const CustomSignUpButton(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Already have an account!!",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      moveScreen(context, const LoginScreen());
                    },
                    child: Text(
                      "\tLog in",
                      style: GoogleFonts.roboto(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
