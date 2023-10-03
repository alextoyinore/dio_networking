import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../userinfo.dart';

part 'userinfo_notifier.g.dart';

@riverpod
class UserInfoNotifier extends _$UserInfoNotifier {
  @override
  UserInfo build() {
    return UserInfo();
  }

  void onNameChange(String name) {
    state = state.copyWith(name: name);
  }

  void onJobChange(String job) {
    state = state.copyWith(job: job);
  }
}
