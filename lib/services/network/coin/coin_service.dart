import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'coin_service.g.dart';

/// Abstract class of CoinService
@RestApi()
abstract class CoinService {
  factory CoinService(Dio dio, {String baseUrl}) = _CoinService;

  @GET('/coins/markets')
  Future<List<CoinJTO>> coins({
    @Query('vs_currency') String currency = 'EUR',
    @Query('order') String order = 'market_cap_desc',
    @Query('per_page') int items = 250,
    @Query('page') int page = 1,
    @Query('parkline') bool parkLine = false,
  });
}