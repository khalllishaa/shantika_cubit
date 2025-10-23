import '../../model/user_model.dart';
import '../../model/users_model.dart';

extension UserModelExtension on UserModel {
  UsersModel toUsersModel() {
    return UsersModel(
      id: id != null ? int.tryParse(id!) : null,
      name: name ?? '${firstName ?? ''} ${lastName ?? ''}'.trim(),
      email: email,
      phone: phone,
      avatar: avatar,
      birth: birthDate != null ? DateTime.tryParse(birthDate!) : null,
      gender: gender,
      avatarUrl: avatar,
      createdAt: createdAt,
      updatedAt: updatedAt,
      // Field yang tidak ada di UserModel, biarkan null:
      uuid: null,
      birthPlace: null,
      nameAgent: null,
      agencies: null,
    );
  }
}