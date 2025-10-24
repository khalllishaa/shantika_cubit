// File: profile_repository.dart

import 'dart:io';
import 'package:retrofit/retrofit.dart';
import '../data/api/api_service.dart';
import '../model/users_model.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class ProfileRepository extends BaseRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  /// ✅ Get Profile
  Future<DataState<UsersModel>> profile() async {
    return await getStateOf<UsersModel>(
      request: () async {
        final response = await _apiService.profile();

        final apiResponse = response.data;

        final user = apiResponse.data;

        return HttpResponse<UsersModel>(
          user!,
          response.response,
        );
      },
    );
  }

  /// ✅ Update Profile
  Future<DataState<UsersModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? avatar,
    String? birth,
    String? birthPlace,
    String? address,
    String? gender,
    String? uuid,
  }) async {
    return await getStateOf<UsersModel>(
      request: () async {
        final response = await _apiService.updateProfile(
          name: name,
          email: email,
          phone: phone,
          avatar: avatar,
          birth: birth ?? "",
          birth_place: birthPlace ?? "",
          address: address ?? "",
          gender: gender ?? "",
          uuid: uuid ?? "",
        );

        final apiResponse = response.data;
        final user = apiResponse.data;

        return HttpResponse<UsersModel>(
          user!,
          response.response,
        );
      },
    );
  }
}
