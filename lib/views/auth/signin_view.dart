import 'package:auctions/configs/ressources/app_ressources.dart';
import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/views/widgets/auction_auth_squeleton.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_textform_field.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuctionAuthSqueleton(
      form: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuctionTitle(title: "Connectez - vous !"),
              SizedBox(height: AppResources.sizes.size032),
              AuctionTextformField(
                hint: "Entrer votre Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppResources.sizes.size024),
              AuctionTextformField(
                hint: "Entrer votre mot de passe",
                controller: pwdController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(height: AppResources.sizes.size036),
              AuctionSubmitBtn(
                text: "Connexion",
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
              SizedBox(
                height: AppResources.sizes.size016,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous n’avez pas encore de compte ?",
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.signUp);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                        AppResources.colors.secondary,
                      ),
                    ),
                    child: const Text("Créez - en un !"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
