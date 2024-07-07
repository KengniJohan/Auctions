import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/controllers/controllers.dart';
import 'package:auctions/models/account.dart';
import 'package:auctions/models/user.dart';
import 'package:auctions/views/widgets/auction_auth_squeleton.dart';
import 'package:auctions/views/widgets/auction_submit_btn.dart';
import 'package:auctions/views/widgets/auction_textform_field.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();

  void _clearFields() {
    setState(() {
      nameController.text = "";
      surnameController.text = "";
      emailController.text = "";
      pwdController.text = "";
      confirmPwdController.text = "";
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
              AuctionTitle(
                title: "Inscrivez - vous !",
                color: AppResources.colors.secondary,
              ),
              SizedBox(
                height: AppResources.sizes.size032,
              ),
              AuctionTextformField(
                hint: "Entrer votre nom",
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: AppResources.sizes.size024,
              ),
              AuctionTextformField(
                hint: "Entrer votre prenom",
                controller: surnameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: AppResources.sizes.size024,
              ),
              AuctionTextformField(
                hint: "Entrer votre email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppResources.sizes.size024,
              ),
              AuctionTextformField(
                hint: "Entrer un mot de passe",
                controller: pwdController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: AppResources.sizes.size024,
              ),
              AuctionTextformField(
                hint: "Confirmer le mot de passe !",
                controller: confirmPwdController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                sndPwdController: pwdController,
              ),
              SizedBox(
                height: AppResources.sizes.size036,
              ),
              AuctionSubmitBtn(
                onPressed: () async {
                  EasyLoading.show(status: "Inscription...");
                  if (formKey.currentState!.validate()) {
                    final users = await userController
                        .findByEmail(emailController.value.text);
                    if (users.isEmpty) {
                      final user = await userController.insert(User(
                        name: nameController.value.text,
                        surname: surnameController.value.text,
                        email: emailController.value.text,
                        password: pwdController.value.text,
                      ));

                      if (user != null) {
                        final account = await accountController
                            .insert(Account(ownerId: user.id));
                        if (account != null) {
                          EasyLoading.dismiss();
                          EasyLoading.showSuccess("Compte créé avec succès !");
                          _clearFields();
                          return;
                        }
                      }
                    } else {
                      EasyLoading.dismiss();
                      EasyLoading.showToast("Cette adresse existe déjà !");
                      return;
                    }
                    EasyLoading.dismiss();
                    EasyLoading.showError("Une erreur s'est produite !");
                    return;
                  }
                  EasyLoading.dismiss();
                },
                text: "Inscription",
              ),
              SizedBox(
                height: AppResources.sizes.size016,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous avez déja un compte ?",
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.signIn);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                        AppResources.colors.secondary,
                      ),
                    ),
                    child: const Text("Connectez - vous !"),
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
