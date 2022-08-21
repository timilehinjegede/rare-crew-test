import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';

final profileViewModelProvider =
    StateNotifierProvider.autoDispose<ProfileViewModel, AsyncValue<User?>>(
        (ref) {
  return ProfileViewModel(ref.read);
});

class ProfileViewModel extends StateNotifier<AsyncValue<User?>> {
  ProfileViewModel(this._read) : super(const AsyncData(null)) {
    getUser();
  }

  final Reader _read;

  Future<void> getUser() async {
    state = const AsyncLoading();

    final result = await _read(authRepositoryProvider).getUser();

    state = AsyncValue.data(result);
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).removeToken();
  }
}
