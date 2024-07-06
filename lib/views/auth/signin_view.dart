import 'package:auctions/configs/ressources/app_ressources.dart';
import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/views/widgets/auction_auth_squeleton.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_textform_field.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  void _clearFields() {
    setState(() {
      emailController.text = "";
      pwdController.text = "";
    });
  }

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
                onPressed: () async {
                  EasyLoading.show(status: "Connexion...");
                  if (formKey.currentState!.validate()) {
                    final user = await userController.signIn(
                      emailController.value.text,
                      pwdController.value.text,
                    );

                    if (user == null) {
                      EasyLoading.dismiss();
                      EasyLoading.showError("Echec de connexion !");
                      return;
                    }

                    EasyLoading.dismiss();
                    EasyLoading.showSuccess("Connexion réussie !");
                    _clearFields();
                    return;
                  }
                  EasyLoading.dismiss();
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
