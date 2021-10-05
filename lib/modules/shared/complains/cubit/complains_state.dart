part of 'complains_cubit.dart';

@immutable
abstract class ComplainsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ComplainsLoading extends ComplainsState {}

class ComplainsEmpty extends ComplainsState {}

class ComplainsLoadingMore extends ComplainsState {
  final List<ComplianEntity> complains;

  ComplainsLoadingMore(this.complains);
  @override
  List<Object?> get props => [complains];
}

class ComplainsLoaded extends ComplainsState {
  final List<ComplianEntity> complains;

  ComplainsLoaded(this.complains);
  @override
  List<Object?> get props => [complains];
}

class ComplainsCatLoad extends ComplainsState {
  final String msg;
  ComplainsCatLoad(this.msg);
  @override
  List<Object?> get props => [msg];
}
