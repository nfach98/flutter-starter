import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/bloc/login/login_event.dart';
import 'package:starter/bloc/login/login_state.dart';
import 'package:starter/utils/shared_preferences.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SharedPreferences sp;

  LoginBloc({required this.sp}) : super(LoginState.initial()) {
    on<Login>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        isLogin: false,
      ));
      await sp.setString('username', event.username);
      emit(state.copyWith(
        isLoading: false,
        isLogin: true,
      ));
    });
  }
}
