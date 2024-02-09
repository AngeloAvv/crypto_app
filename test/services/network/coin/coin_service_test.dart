import 'package:crypto_app/services/network/coin/coin_service.dart';
import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:data_fixture_dart/misc/fixture_tuple.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../fixtures/jto/coin_jto_fixture_factory.dart';

/// Test case for the class CoinService
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  late CoinService service;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);

    service = CoinService(dio);
  });

  group('Testing coins endpoint', () {
    late List<FixtureTuple<CoinJTO>> coins;

    setUp(() {
      coins = CoinJTOFixture.factory().makeManyWithJsonArray(5);
    });

    test('when /coins/markets answers 200 OK successfully', () async {
      dioAdapter.onGet(
        '/coins/markets',
        (server) => server.reply(
          200,
          coins.map((coin) => coin.json).toList(),
        ),
      );

      final actual = coins.map((coin) => coin.object).toList();
      expect(await service.coins(), actual);
    });

    test('when /coins/markets answers 422 Unprocessable Entity', () async {
      dioAdapter.onGet(
        '/coins/markets',
        (server) => server.reply(422, null),
      );

      expect(
        () async => await service.coins(),
        throwsA(isA<DioException>()),
      );
    });
  });
}
