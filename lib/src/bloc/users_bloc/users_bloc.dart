import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tots_test/src/services/users.dart';
import 'package:tots_test/src/utils/select_image.dart';

import '../../models/user_list.dart';

part 'users_event.dart';
part 'users_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;

  List<UserModel> userShow = [];
  List<UserModel> userListTotal = [];

  UserListModel? userFromService;

  UserBloc(this._userService) : super(const UserState()) {
    on<SearchUsers>((event, emit) {
      userListTotal = (userFromService?.data ?? [])
          .where((element) =>
              (element.firstname ?? "").toLowerCase().contains(event.search) ||
              (element.lastname ?? "").toLowerCase().contains(event.search) ||
              (element.email ?? "").toLowerCase().contains(event.search))
          .toList();

      emit.call(state.copyWith(userListTotal: userListTotal));
    });

    on<RemovePhoto>((event, emit) {
      emit.call(state.copyWith(userPhoto: Uint8List(0)));
    });

    on<AddMoreToList>((event, emit) {
      userShow.addAll(userListTotal.take(5));
      emit.call(state.copyWith(userListTotal: userShow));

      if (userListTotal.length <= 5) {
        userListTotal.clear();
      } else {
        userListTotal = userListTotal.sublist(5);
      }
    });

    on<GetUserList>((event, emit) async {
      userFromService = await _userService.getAllUsers();

      userListTotal = userFromService?.data ?? [];
      userShow.clear();
      userShow.addAll(userListTotal.take(5));

      if (userListTotal.length <= 5) {
        userListTotal.clear();
      } else {
        userListTotal = userListTotal.sublist(5);
      }

      emit.call(state.copyWith(
        userListTotal: userShow,
        loadingUsers: false,
        userPhoto: null,
      ));
    });

    on<SetLoading>((event, emit) {
      emit.call(state.copyWith(loadingDetail: event.loading));
    });

    on<GetPhoto>((event, emit) async {
      final pic = await ImageSelector.selectImage(source: event.source);
      emit.call(state.copyWith(userPhoto: pic.readAsBytesSync()));
    });
  }

  Future<void> createUser(UserModel user) async {
    try {
      // TODO: Pending to add Photo repository
      // if (!state.userPhoto.isNullOrEmpty) {
      //   user.photo = base64Encode(state.userPhoto!);
      // }
      add(SetLoading(true));
      await _userService.create(user);
      add(GetUserList());
    } on Exception catch (e) {
      throw e.toString();
    } finally {
      add(SetLoading(false));
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      add(SetLoading(true));
      await _userService.update(user);
      add(GetUserList());
    } on Exception catch (e) {
      throw e.toString();
    } finally {
      add(SetLoading(false));
    }
  }

  Future<void> removeUser(int id) async {
    try {
      add(SetLoading(true));
      await _userService.remove(id);
      add(GetUserList());
    } on Exception catch (e) {
      throw e.toString();
    } finally {
      add(SetLoading(false));
    }
  }
}
