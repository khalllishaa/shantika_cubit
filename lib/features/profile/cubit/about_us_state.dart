import 'package:shantika_cubit/model/about_us_model.dart';

abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final About data;
  AboutLoaded(this.data);
}

class AboutError extends AboutState {
  final String message;
  AboutError(this.message);
}

