import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';

final signInViewModelProvider =
    StateNotifierProvider.autoDispose<SignInViewModel, AsyncValue<void>>((ref) {
  return SignInViewModel(ref.read);
});

class SignInViewModel extends StateNotifier<AsyncValue<void>> {
  SignInViewModel(this._read) : super(const AsyncData(null));

  final Reader _read;

  Future<void> signIn() async {
    state = const AsyncLoading();
    final result = await _read(authRepositoryProvider).signIn(
      email: 'email',
      password: 'password',
    );

    state = AsyncValue.data(result);
  }
}
