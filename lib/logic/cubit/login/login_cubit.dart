import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/data_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  DataRepository dataRepository = DataRepository();

  static String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  void validateData(String email, String pass) async {
    if (email == "") {
      emit(LoginEmail("Please enter email"));
    } else if (!RegExp(pattern).hasMatch(email)) {
      emit(LoginEmail("Please enter valid email"));
    } else if (pass == "") {
      emit(LoginPass("Please enter password"));
    } else if (pass.length < 6) {
      emit(LoginPass("Please enter a minimum 6 digit password"));
    } else {
      emit(LoginValid());
    }
  }

  void checkLogin(String email, String pass) async {
    if (isClosed) return;
    try {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 3));
      bool res = await dataRepository.checkLogin(email, pass);
      if (res) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Wrong credentials'));
      }
    } catch (ex) {
      if (!isClosed) {
        emit(LoginFailure(error: 'something went wrong'));
      }
    }
  }
}
