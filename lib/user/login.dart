import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/controllers/generic/GreenButtonController.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../LoginController.dart';
import '../components/generic/UIHelper.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  bool rememberMe = false;
  final GreenButtonController controller = Get.put(GreenButtonController());
  final LoginController loginController = Get.put(LoginController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginController.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo, height: 70,),
                SizedBox(height: 30,),
                AppTextLabels.boldTextShort(label: "Welcome Back!", color: AppColors.appGreen, fontSize: 24),
                SizedBox(height: 10,),
                AppTextLabels.regularShortText(label: "Please enter your credentials to login.", color: AppColors.lightTextColor, fontSize: 14),
                SizedBox(height: 40,),
                AppInput(title: "Email", controller: emailController, inputType: TextInputType.text),
                SizedBox(height: 10,),
                AppInput(title: "Password", controller: passwordController, inputType: TextInputType.visiblePassword,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    AppTextLabels.regularShortText(label: "Remember Me", color: AppColors.appBlack)
                  ],
                ),
                GreenButton(
                  title: 'Submit',
                  sendingData: loginController.isLoading,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    loginController.loginRequest(
                      emailController.text,
                      passwordController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginRequest() {

  }
}
