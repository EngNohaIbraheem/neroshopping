part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//login
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginErrer extends AuthState {}

// Register
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterErrer extends AuthState {
  final String msg;
  RegisterErrer(this.msg);
}

final class GetProfileLoading extends AuthState {}

final class GetProfileSuccess extends AuthState {}

final class GetProfileError extends AuthState {}

final class UpdateProfieLoading extends AuthState {}

final class UpdateProfieSuccess extends AuthState {}

final class UpdateProfieError extends AuthState {}

final class GetShoppingLoading extends AuthState {}

final class GetShoppingSuccess extends AuthState {}

final class GetShoppingeError extends AuthState {}

final class AddOrRemoveFavoriteLoading extends AuthState {}
final class AddOrRemoveFavoriteSuccess extends AuthState {}
final class AddOrRemoveFavoriteError extends AuthState {}
//getFavorite
final class GetFavoriteLoading extends AuthState {}
final class GetFavoriteSuccess extends AuthState {}
final class GetFavoriteError extends AuthState {}