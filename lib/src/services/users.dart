import 'package:tots_test/src/models/user_list.dart';
import 'package:tots_test/src/utils/network.dart';

class UserService {
  Future<UserListModel> getAllUsers() async {
    try {
      final dio = MyDioClient.getClient;
      final response = await dio.get("clients");
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        throw response.data["message"];
      }
      final userList = UserListModel.fromJson(response.data);
      return userList;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<bool> create(UserModel user) async {
    try {
      final dio = MyDioClient.getClient;
      final response = await dio.post("clients", data: user.toJson());
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        throw response.data["message"];
      }
      return true;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<bool> update(UserModel user) async {
    try {
      final dio = MyDioClient.getClient;
      final response =
          await dio.post("clients/${user.id}", data: user.toJson());
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        throw response.data["message"];
      }
      return true;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<bool> remove(int id) async {
    try {
      final dio = MyDioClient.getClient;
      final response = await dio.delete("clients/$id");
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        throw response.data["message"];
      }
      return true;
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
