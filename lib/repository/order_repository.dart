import 'package:dio/dio.dart';
import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:shantika_cubit/model/history_order_model.dart';
import 'package:shantika_cubit/repository/base/base_repository.dart';

class OrderRepository extends BaseRepository {
  final ApiService _apiService;

  OrderRepository(this._apiService);

  Future<HistoryOrderModel> getHistoryOrder() async {
    try {
      final response = await _apiService.getHistoryOrder();

      if (response.response.statusCode == 200) {
        if (response.data != null) {
          return response.data!;
        } else {
          throw Exception('Data home kosong');
        }
      } else {
        throw Exception(
            'Server error: ${response.response.statusCode} - ${response.response.statusMessage}'
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('Endpoint tidak ditemukan (${e.response?.statusCode})');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Koneksi timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server tidak merespons');
      } else {
        throw Exception('Koneksi gagal: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching home: $e');
    }
  }
}