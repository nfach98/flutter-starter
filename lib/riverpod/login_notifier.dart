import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/utils/shared_preferences.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  late SharedPreferences _sharedPreferences;

  @override
  Future<void> build() async {
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
  }

  Future<void> login(String username) async {
    state = const AsyncLoading();
    await _sharedPreferences.setString('username', username);
    state = const AsyncData(null);
  }
}
