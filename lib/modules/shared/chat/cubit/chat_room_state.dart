part of 'chat_room_cubit.dart';

@immutable
abstract class ChatWithDriverState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatRoomLoading extends ChatWithDriverState {}

class ChatRoomEmpty extends ChatWithDriverState {}

class ChatRoomError extends ChatWithDriverState {
  final String message;

  ChatRoomError(this.message);
  @override
  List<Object?> get props => [message];
}

class ChatRoomLoaded extends ChatWithDriverState {
  final List<ChatMessageEntity> messages;
  ChatRoomLoaded(this.messages);
  @override
  List<Object?> get props => [UniqueKey()];
}

// class ChatRoomLoaingMore extends ChatWithDriverState {
//   final List<ChatMessageEntity> messages;
//   ChatRoomLoaingMore(this.messages);
//   @override
//   List<Object?> get props => [UniqueKey()];
// }
