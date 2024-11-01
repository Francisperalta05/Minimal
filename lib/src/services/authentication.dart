
import '../models/authentication.dart';
import '../utils/network.dart';

class AuthenticationService {
  Future<AuthModel> loginUser(String email, String password) async {
    try {
      final dio = MyDioClient.getClient;
      final response = await dio.post(
        "oauth/token",
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        throw response.data["message"];
      }

      return AuthModel.fromJson(response.data);
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
