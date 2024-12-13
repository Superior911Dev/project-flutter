import 'package:appstore/pages/Sign_in/bloc/sign_in_bloc.dart';
import 'package:appstore/pages/register/bloc/register_blocs.dart';
import 'package:appstore/pages/welcome/bloc/welcome_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(lazy: false, create: (context) => WelcomeBloc()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => RegisterBlocs()),
      ];
}
