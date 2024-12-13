import 'package:appstore/pages/Sign_in/bloc/sign_in_events.dart';
import 'package:appstore/pages/Sign_in/bloc/signin_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    //print("อีเมลของฉันคือ ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    //print("รหัสผ่านของฉันคือ ${event.password}");
    emit(state.copyWith(password: event.password));
  }
}
