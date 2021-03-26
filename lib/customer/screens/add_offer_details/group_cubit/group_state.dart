part of 'group_cubit.dart';

abstract class GroupState extends Equatable {
  final List<SpecificationGroupModel> specifications;
  final bool changed;

  GroupState({@required this.specifications,@required  this.changed});
}

class GroupInitial extends GroupState {
  GroupInitial({@required bool changed}):super(specifications: [],changed: changed);
  @override
  List<Object> get props => [changed,specifications];
}

class GroupUpdated extends GroupState {
  GroupUpdated({@required bool changed,@required List<SpecificationGroupModel> specifications})
      :super(specifications: specifications,changed: changed);
  @override
  List<Object> get props => [changed,specifications];
}