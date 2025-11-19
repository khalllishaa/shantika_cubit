import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/model/social_media_model.dart';

abstract class SocialMediaState extends Equatable{
  const SocialMediaState();

  @override
  List<Object> get props => [];
}

class SocialMediaInitial extends SocialMediaState{}
class SocialMediaLoading extends SocialMediaState{}
class SocialMediaLoaded extends SocialMediaState{
  final List<SocialMedia> socialMedia;

  const SocialMediaLoaded(this.socialMedia);

  @override
  List<Object> get props => [socialMedia];
}
class SocialMediaError extends SocialMediaState{
  final String message;

  const SocialMediaError(this.message);

  @override
  List<Object> get props => [message];
}