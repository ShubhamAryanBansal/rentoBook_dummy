import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_router.dart';
import 'cubit/login_cubit.dart';

class SettingBloc extends StatelessWidget {
  final AppRouter? appRouter;

  const SettingBloc({Key? key, @required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (loginContext) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: appRouter!.generateRoute,
      ),
    );
  }
}

