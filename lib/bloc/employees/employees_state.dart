import 'package:equatable/equatable.dart';
import 'package:firebasestarter/models/employee.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

class EmployeesInitial extends EmployeesState {
  const EmployeesInitial();
}

class EmployeesLoadInProgress extends EmployeesState {
  const EmployeesLoadInProgress();
}

class EmployeesLoadFailure extends EmployeesState {
  final String message;
  const EmployeesLoadFailure(this.message);
}

class EmployeesLoadSuccess extends EmployeesState {
  final List<Employee> employees;
  const EmployeesLoadSuccess(this.employees);
}

class EmployeesLoadEmpty extends EmployeesState {
  const EmployeesLoadEmpty();
}
