import 'package:flutterBoilerplate/bloc/employees/employees_event.dart';
import 'package:flutterBoilerplate/bloc/employees/employees_state.dart';
import 'package:flutterBoilerplate/bloc/forms/user_form_bloc.dart';
import 'package:flutterBoilerplate/models/domain/admin.dart';
import 'package:flutterBoilerplate/models/domain/employee.dart';
import 'package:flutterBoilerplate/models/filter.dart';
import 'package:flutterBoilerplate/repository/employees_repository.dart';

class EmployeesBloc extends UserFormBloc<EmployeesEvent, EmployeesState> {
  final _employeesRepository = EmployeesRepository();

  EmployeesBloc() : super(const NotDetermined());

  @override
  Stream<EmployeesState> mapEventToState(EmployeesEvent event) async* {
    switch (event.runtimeType) {
      case GetEmployees:
        yield* _getEmployees((event as GetEmployees).filter);
        break;
      case CreateEmployee:
        yield* _postNewEmployee();
        break;
      case FetchEmployee:
        yield* _getEmployee((event as FetchEmployee).id);
        break;
      case UpdateEmployee:
        yield* _updateEmployee((event as UpdateEmployee).id);
        break;
      case DeleteEmployee:
        yield* _deleteEmployee((event as DeleteEmployee).id);
        break;
      default:
        yield const Error('Error: Invalid event.');
    }
  }

  Stream<EmployeesState> _getEmployees(Filter filter) async* {
    yield const Loading();
    try {
      final employees = await _employeesRepository.getEmployees(filter);
      yield Employees(employees);
    } catch (err) {
      yield Error(err.toString());
    }
  }

  Stream<EmployeesState> _postNewEmployee() async* {
    try {
      yield const Loading();
      await _employeesRepository.addEmployee(
        Employee(
          firstName: firstNameController.value,
          lastName: lastNameController.value,
          email: emailController.value,
          phoneNumber: phoneController.value,
          age: ageController.value.truncate(),
          address: addressController.value,
        ),
      );
      yield const EmployeeCreated();
    } catch (err) {
      yield Error(err.toString());
    }
  }

  Stream<EmployeesState> _updateEmployee(String id) async* {
    try {
      yield const Loading();
      await _employeesRepository.updateEmployee(
        Employee(
          id: id,
          firstName: firstNameController.value,
          lastName: lastNameController.value,
          email: emailController.value,
          phoneNumber: phoneController.value,
          age: ageController.value.truncate(),
          address: addressController.value,
        ),
      );
      yield const EmployeeUpdated();
    } catch (err) {
      yield Error(err.toString());
    }
  }

  Stream<EmployeesState> _getEmployee(String id) async* {
    try {
      yield const Loading();
      final employee = await _employeesRepository.getEmployee(id);
      firstNameController.sink.add(employee.firstName);
      lastNameController.sink.add(employee.lastName);
      emailController.sink.add(employee.email);
      addressController.sink.add(employee.address);
      ageController.sink.add(employee.age.toDouble());
      isAdminController.sink.add(employee.runtimeType == Admin);
      phoneController.sink.add(employee.phoneNumber);
      yield SingleEmployee(employee);
    } catch (err) {
      yield Error(err.toString());
    }
  }

  Stream<EmployeesState> _deleteEmployee(String id) async* {
    try {
      yield const Loading();
      await _employeesRepository.deleteEmployee(id);
      yield const EmployeeDeleted();
    } catch (err) {
      yield Error(err.toString());
    }
  }
}
