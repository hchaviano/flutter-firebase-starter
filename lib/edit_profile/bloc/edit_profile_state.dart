part of 'edit_profile_bloc.dart';

enum EditProfileStatus {
  initial,
  loading,
  success,
  failure,
  valid,
  invalid,
}

enum EditProfileFields { initial, unchanged, changed }

class EditProfileState extends Equatable {
  final EditProfileStatus status;
  final EditProfileFields fieldsStatus;
  final User user;
  final FirstName firstName;
  final LastName lastName;
  final String imageURL;

  const EditProfileState({
    @required EditProfileStatus this.status,
    @required EditProfileFields this.fieldsStatus,
    this.user,
    this.firstName,
    this.lastName,
    this.imageURL,
  }) : assert(status != null);

  EditProfileState.initial()
      : this(
          status: EditProfileStatus.initial,
          fieldsStatus: EditProfileFields.initial,
          firstName: FirstName.pure(),
          lastName: LastName.pure(),
          imageURL: '',
        );

  EditProfileState copyWith({
    EditProfileStatus status,
    EditProfileFields fieldsStatus,
    User user,
    FirstName firstName,
    LastName lastName,
    String imageURL,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      fieldsStatus: fieldsStatus ?? this.fieldsStatus,
      user: user ?? this.user,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  @override
  List<Object> get props => [status, user, firstName, lastName, imageURL];
}
