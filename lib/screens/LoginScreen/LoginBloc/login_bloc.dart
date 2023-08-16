import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health/repositories/api_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginData) {
      yield LoadingLoginState();
      try {
        print('this is email ${event.email}');
        if (event.email == '') {
          yield ErrorLoginState(error: 'Please Entre email');
        } else if (!event.email.contains('@') || !event.email.endsWith('.com')) {
          yield ErrorLoginState(error: 'Please enter valid email');
        } else if (event.password == '') {
          yield ErrorLoginState(error: 'Please enter passowrd');
        } else if (event.password.length < 6) {
          yield ErrorLoginState(error: 'Password length must be greater then six');
        } else {
          dynamic response = await ApiRepositories().getLogin();
          print('----LOGIN API STARTED-----${response}');
          //SentMessageResponse sentMessageResponse = SentMessageResponse.fromJson(response);
          yield LoginSuccess(message: response);
        }
      } catch (e) {
        print("----PLEASE CHECK LOGIN BLOC----");
        print('the error is ${e.toString()}');
      }
    }
  }
}
