import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/model/info_agency_model.dart';

abstract class InfoAgencyState extends Equatable {
  const InfoAgencyState();

  @override
  List<Object?> get props => [];
}

class InfoAgencyInitial extends InfoAgencyState {}

class InfoAgencyLoading extends InfoAgencyState {}

class InfoAgencyLoaded extends InfoAgencyState {
  final List<Agency> agencies;
  final List<Agency> filteredAgencies;
  final String searchQuery;

  const InfoAgencyLoaded({
    required this.agencies,
    required this.filteredAgencies,
    this.searchQuery = '',
  });

  InfoAgencyLoaded copyWith({
    List<Agency>? agencies,
    List<Agency>? filteredAgencies,
    String? searchQuery,
  }) {
    return InfoAgencyLoaded(
      agencies: agencies ?? this.agencies,
      filteredAgencies: filteredAgencies ?? this.filteredAgencies,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [agencies, filteredAgencies, searchQuery];
}

class InfoAgencyError extends InfoAgencyState {
  final String message;

  const InfoAgencyError(this.message);

  @override
  List<Object?> get props => [message];
}