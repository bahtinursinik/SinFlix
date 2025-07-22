abstract class ProfileEvent {}

class ProfileRequested extends ProfileEvent {
  final String token;
  ProfileRequested(this.token);
}
