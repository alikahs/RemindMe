import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../constanta_data.dart';
import 'package:http/http.dart' as http;
import '../../model/response_model/auth_response_model.dart';

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String uuid,
    String nama,
    String token,
  ) async {
    final header = {'Content-Type': 'application/json'};
    final url = Uri.parse('${ConstantaData.baseUrl}/login.php');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'uuid': uuid,
        'nama': nama,
        'token': token,
      }),
      headers: header,
    );
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout(String uuid) async {
    final header = {'Content-Type': 'application/json'};
    final url = Uri.parse('${ConstantaData.baseUrl}/logout.php');

    try {
      final response = await http.post(
        url,
        headers: header,
        body: jsonEncode({'uuid': uuid}),
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final success = body['success'] == true;
      final message = body['message']?.toString() ?? 'Unknown response';

      if (response.statusCode == 200 && success) {
        return Right(message); // "Logout berhasil, token sudah dikosongkan"
      } else {
        // Ambil pesan dari server (mis. "User tidak ditemukan...")
        return Left(message);
      }
    } catch (e) {
      return Left('Logout error: $e');
    }
  }
}
