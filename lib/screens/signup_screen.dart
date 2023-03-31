import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myinsta/resources/auth_methods.dart';
import 'package:myinsta/utils/utils.dart';

import '../utils/colors.dart';
import '../widgets/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _bioTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  bool isLoading = false;

  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();

    _bioTextController.dispose();
    _userNameTextController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signupUser(
      file: _image!,
      userName: _userNameTextController.text,
      bio: _bioTextController.text,
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (res != "Success") {
      // show warnings
      if (!mounted) return;
      showSnackBar(res, context);
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 120),
              Flexible(
                flex: 2,
                child: Container(),
              ),

              // Logo
              SvgPicture.asset(
                'assets/instagram.svg',
                height: 64,
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              const SizedBox(height: 48),

              // Circular Avatar
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 76,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 76,
                          backgroundImage: NetworkImage(
                            'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg',
                          ),
                        ),
                  Positioned(
                    bottom: -0,
                    left: 90,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: blueColor, //<-- SEE HERE
                      child: IconButton(
                        onPressed: selectImage,
                        highlightColor: Colors.blue[900],
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Text Field for User Name Input
              InputField(
                textEditingController: _userNameTextController,
                hintText: 'Type Your User Name',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),

              // Text Field for BIO Input
              InputField(
                textEditingController: _bioTextController,
                hintText: 'Discribe Your Bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),

              // Text Field for Email Input
              InputField(
                textEditingController: _emailTextController,
                hintText: 'Type Your Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Text Field for Password Input
              InputField(
                textEditingController: _passwordTextController,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 24),

              // CTA - Signup
              InkWell(
                onTap: signupUser,
                // print(res);
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Signup'),
                ),
              ),

              const SizedBox(height: 32),

              // Sugnup or Password Recovery
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account?"),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
