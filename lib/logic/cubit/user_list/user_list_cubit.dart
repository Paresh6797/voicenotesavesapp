import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voicenotesavesapp/data/model/user.dart';

import '../../../data/repositories/data_repository.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(UserListInitial()) {
    usersRecord();
  }

  DataRepository dataRepository = DataRepository();

  void usersRecord() async {
    if (isClosed) return;
    try {
      emit(UserListInitial());
      List<User> list = await dataRepository.usersRepository();
      if (!isClosed) {
        emit(UserListLoaded(list));
      }
    } catch (ex) {
      if (!isClosed) {
        emit(UserListError('something went wrong'));
      }
    }
  }
}
