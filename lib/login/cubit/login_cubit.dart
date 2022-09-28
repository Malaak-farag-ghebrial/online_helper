

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool visible = false;
  void changePasswordVisibility(){
    visible = !visible;
    emit(ChangePassVisibleLoginState());
  }


}