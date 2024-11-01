import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/src/bloc/users_bloc/users_bloc.dart';
import 'package:tots_test/src/preferences/preferences.dart';
import 'package:tots_test/src/router/router.dart';
import 'package:tots_test/src/screens/authentication/login.dart';
import 'package:tots_test/src/screens/home/home_list.dart';
import 'package:tots_test/src/services/authentication.dart';
import 'package:tots_test/src/services/users.dart';

import 'src/bloc/auth_bloc/auth_bloc.dart';
import 'src/utils/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.initPrefs();
  runApp(const Minimal());
}

class Minimal extends StatelessWidget {
  const Minimal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserBloc(UserService())),
          BlocProvider(create: (_) => AuthBloc(AuthenticationService())),
        ],
        child: MaterialApp(
          theme: themeData,
          initialRoute: preferences.uToken.isEmpty
              ? LoginScreen.routeName
              : HomeList.routeName,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
