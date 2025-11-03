import 'package:equatable/equatable.dart';
import '../../../model/faq_model.dart';

abstract class FAQState extends Equatable {
  const FAQState();

  @override
  List<Object?> get props => [];
}

class FAQInitial extends FAQState {}

class FAQLoading extends FAQState {}

class FAQLoaded extends FAQState {
  final List<FaqModel> faqs;

  const FAQLoaded(this.faqs);

  @override
  List<Object?> get props => [faqs];
}

class FAQError extends FAQState {
  final String message;

  const FAQError(this.message);

  @override
  List<Object?> get props => [message];
}
