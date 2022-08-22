import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/core.dart';

final profileViewModelProvider =
    StateNotifierProvider.autoDispose<ProfileViewModel, User?>((ref) {
  return ProfileViewModel(ref.read);
});

class ProfileViewModel extends StateNotifier<User?> {
  ProfileViewModel(this._read) : super(null) {
    getUser();
  }

  final Reader _read;

  void getUser() {
    state = _read(authRepositoryProvider).getUser();
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).removeUser();
  }
}
