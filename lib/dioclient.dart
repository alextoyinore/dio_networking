import 'package:dio/dio.dart';
import 'package:dio_networking/user/user.dart';
import 'package:dio_networking/userinfo/userinfo.dart';

class DioClient {
  // Set up and define methods for network operations with Dio package

  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  Future<User?> getUser({required String id}) async {
    User? user;

    try {
      // Perform GET request to the endpoint "/users/<id>"
      Response userData = await _dio.get(_baseUrl + '/users/$id');

      // Parsing the raw JSON data to the User class
      user = User.fromJson(userData.data);

      // Prints the raw data returned by the server
      print("User info: ${userData}");
    } on DioError catch (e) {
      // Status code is falls outside 200 - 304
      if (e.response != null) {
        print('Dio Error');
        print(e.response!.statusCode);
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something else happened
        print('Error sending request');
        print(e.requestOptions);
        print(e.message);
      }
    }

    return user;
  }

  Future<UserInfo?> createUser({required UserInfo userInfo}) async {
    UserInfo? user;

    try {
      // Perform POST request to the endpoint "/users"
      Response userData =
          await _dio.post('$_baseUrl/users', data: user!.toJson());

      print("User created: ${userData.data}");

      user = UserInfo.fromJson(userData.data);
    } on DioError catch (e) {
      // Status code is falls outside 200 - 304
      if (e.response != null) {
        print('Dio Error');
        print(e.response!.statusCode);
        print('Error creating user: $e');
      } else {
        // Something else happened
        print('Error sending request');
        print(e.requestOptions);
        print(e.message);
      }
    }

    return user;
  }
}
