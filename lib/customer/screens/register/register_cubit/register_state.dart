part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  final bool terms;
  final bool loading;
  const RegisterState({this.terms, this.loading});
}

class RegisterInitial extends RegisterState {
  RegisterInitial() : super(terms: false,loading: false);

  @override
  List<Object> get props => [];
}

class TermsChanged extends RegisterState {
  final bool terms;
  final bool loading;
  TermsChanged({this.terms, this.loading}) : super(terms: terms,loading: loading);

  @override
  List<Object> get props => [terms,loading];
}
class LoadingChanged extends RegisterState {
  final bool loading;
  final bool terms;
  LoadingChanged({this.loading, this.terms}) : super(terms: terms,loading: loading);
  @override
  List<Object> get props => [loading,terms];
}
