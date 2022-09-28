import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/home/screens/home_layout.dart';
import 'package:online_helper/login/cubit/login_cubit.dart';
import 'package:online_helper/login/cubit/login_states.dart';
import 'package:online_helper/shared/component/custom_button.dart';
import 'package:online_helper/shared/component/custom_navigator.dart';
import 'package:online_helper/shared/component/input_field.dart';
import 'package:online_helper/shared/constants/app_constants.dart';

class LoginScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 100),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppConst.curveRadius)),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                inputField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Email',
                                  autoFill: [
                                    AutofillHints.email,
                                  ],
                                  prefixIcon: const Icon(
                                    Icons.person,
                                  ),
                                ),
                                inputField(
                                  controller: passController,
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIcon: const Icon(
                                    Icons.password_rounded,
                                  ),
                                  obscureText: cubit.visible,
                                  hintText: 'Password',
                                  suffix: IconButton(
                                    onPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
                                    icon: cubit.visible
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    customButton(
                                      child: Row(
                                        children: const [
                                          Text(
                                            'login',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          navigatorBackless(
                                              context, HomeLayOut());
                                        }
                                      },
                                    ),
                                  ],
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
            ),
          ),
        );
      },
    );
  }
}
