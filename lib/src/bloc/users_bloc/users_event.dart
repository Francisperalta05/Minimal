part of 'users_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserList extends UserEvent {}

class AddMoreToList extends UserEvent {}

class SetLoading extends UserEvent {
  final bool loading;

  SetLoading(this.loading);
}

class GetPhoto extends UserEvent {
  final ImageSource source;

  GetPhoto(this.source);
}

class RemovePhoto extends UserEvent {}

class SearchUsers extends UserEvent {
  final String search;

  SearchUsers(this.search);
}
