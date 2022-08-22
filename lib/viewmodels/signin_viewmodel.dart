import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';

final signInViewModelProvider =
    StateNotifierProvider.autoDispose<SignInViewModel, void>((ref) {
  return SignInViewModel(ref.read);
});

class SignInViewModel extends StateNotifier<void> {
  SignInViewModel(this._read) : super(null);

  final Reader _read;

  void signIn() async {
    _read(authRepositoryProvider).signIn(
      email: 'email',
      password: 'password',
    );
  }
}
