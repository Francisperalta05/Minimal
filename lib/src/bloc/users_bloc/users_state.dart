part of 'users_bloc.dart';

@immutable
class UserState {
  final List<UserModel> userListTotal;
  // final List<UserModel> userShow;
  final bool loadingUsers;
  final bool loadingDetail;
  final Uint8List? userPhoto;

  const UserState({
    this.userListTotal = const [],
    this.loadingUsers = true,
    this.loadingDetail = false,
    this.userPhoto,
    // this.userShow = const [],
  });

  UserState copyWith({
    List<UserModel>? userListTotal,
    bool? loadingUsers,
    bool? loadingDetail,
    Uint8List? userPhoto,
    // List<UserModel>? userShow,
  }) {
    return UserState(
      userListTotal: userListTotal ?? this.userListTotal,
      loadingUsers: loadingUsers ?? this.loadingUsers,
      loadingDetail: loadingDetail ?? this.loadingDetail,
      userPhoto: userPhoto ?? this.userPhoto,
      // userShow: userShow ?? this.userShow,
    );
  }
}
