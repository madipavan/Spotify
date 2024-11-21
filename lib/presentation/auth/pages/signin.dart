import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/auth/widgets/basic_textfield.dart';
import 'package:spotify/presentation/auth/widgets/bottom_text.dart';
import 'package:spotify/presentation/auth/widgets/heading_text.dart';
import 'package:spotify/presentation/auth/widgets/top_sub_text.dart';
import 'package:spotify/viewmodels/userviewmodel/userview_model.dart';

import '../../../common/widgets/snackbar/basic_snackbar.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomText(
          text: "Not A Member?",
          colortext: "Register Now",
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/SignupPage");
          }),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeadingText(text: "Sign In"),
              TopSubText(onPressed: () {}),
              const SizedBox(
                height: 20,
              ),
              BasicTextfield(
                controller: email,
                hint: "Enter Username Or Email",
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
              Consumer<UserviewModel>(
                builder: (context, value, child) => BasicAppButton(
                    onPressed: () async {
                      await value.signin(email.text, password.text);
                      if (value.errormsgsignin != null) {
                        BasicSnackBar.showSnackbar(
                            context, "Check Your Email or Password");
                      } else if (value.user != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/RootPage", (route) => false);
                      }
                    },
                    title: "Sgn In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
