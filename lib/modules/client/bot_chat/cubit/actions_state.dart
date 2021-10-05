part of 'actions_cubit.dart';

@immutable
abstract class ActionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActionsLoading extends ActionsState {}

class MessagesLoaded extends ActionsState {
  final List<BotMessage> messages;

  MessagesLoaded(this.messages);
  @override
  List<Object?> get props => [UniqueKey()];
}

class MessagesError extends ActionsState {
  final String message;

  MessagesError(this.message);
  @override
  List<Object?> get props => [message];
}
