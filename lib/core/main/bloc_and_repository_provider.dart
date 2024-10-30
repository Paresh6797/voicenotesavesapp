import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/data_repository.dart';
import '../../logic/cubit/login/login_cubit.dart';
import '../../logic/cubit/user_list/user_list_cubit.dart';
import 'app.dart';

class BlocAndRepositoryProvider extends StatelessWidget {
  const BlocAndRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DataRepository(),
          ),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => LoginCubit()),
          BlocProvider(create: (_) => UserListCubit()),
        ], child: const App()));
  }
}
