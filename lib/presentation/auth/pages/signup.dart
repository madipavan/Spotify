import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/presentation/auth/widgets/basic_textfield.dart';
import 'package:spotify/presentation/auth/widgets/bottom_text.dart';
import 'package:spotify/presentation/auth/widgets/heading_text.dart';
import 'package:spotify/presentation/auth/widgets/top_sub_text.dart';
import 'package:spotify/viewmodels/userviewmodel/userview_model.dart';

import '../../../common/widgets/snackbar/basic_snackbar.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserviewModel>(
      builder: (context, value, child) => Stack(
        children: [
          Scaffold(
            bottomNavigationBar: BottomText(
              text: "Do You Have An Account?",
              colortext: " Sign In",
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/SigninPage");
              },
            ),
            appBar: BasicAppBar(
              title: SvgPicture.asset(
                AppVectors.logo,
                height: 40,
                width: 40,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeadingText(text: "Register"),
                    TopSubText(onPressed: () {}),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicTextfield(
                      controller: name,
                      hint: "Full Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicTextfield(
                      controller: email,
                      hint: "Enter Email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicTextfield(
                      controller: password,
                      hint: "Password",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BasicAppButton(
                        onPressed: () {
                          value.signup(email.text, password.text, name.text);

                          if (value.errormsgsignup != null) {
                            BasicSnackBar.showSnackbar(
                                context, "Check Your Email or Password");
                          } else {
                            BasicSnackBar.showSnackbar(context, "Successfull");
                            Navigator.pop(context);
                          }
                        },
                        title: "Create Account"),
                  ],
                ),
              ),
            ),
          ),
          value.isloading
              ? Center(child: _showprgressindicator())
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _showprgressindicator() {
    return const CircularProgressIndicator(
      color: AppColors.primary,
    );
  }
}
