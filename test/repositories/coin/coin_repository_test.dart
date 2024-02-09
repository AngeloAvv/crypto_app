import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:crypto_app/repositories/mappers/coin_mapper.dart';
import 'package:crypto_app/services/network/coin/coin_service.dart';
import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talker/talker.dart';

import '../../fixtures/models/coin_fixture_factory.dart';
import 'coin_repository_test.mocks.dart';

/// Test case for the class CoinRepositoryImpl
@GenerateMocks([
  CoinService,
  CoinMapper,
], customMocks: [
  MockSpec<Talker>(unsupportedMembers: {#configure})
])
void main() {
  late MockCoinService service;
  late MockCoinMapper mapper;
  late MockTalker logger;

  late CoinRepository repository;

  setUp(() {
    service = MockCoinService();
    mapper = MockCoinMapper();
    logger = MockTalker();

    repository = CoinRepositoryImpl(
      coinService: service,
      coinMapper: mapper,
      logger: logger,
    );
  });

  group('Testing the coins getter', () {
    late List<Coin> coins;
    late List<CoinJTO> jtos;

    setUp(() {
      coins = CoinFixture.factory().makeMany(5);
      jtos = coins
          .map((coin) => CoinJTO(
                id: coin.id,
                symbol: coin.symbol,
                name: coin.name,
                image: coin.image,
                currentPrice: coin.currentPrice,
                marketCap: coin.marketCap,
                priceChangePercentage24h: coin.priceChangePercentage24h,
              ))
          .toList(growable: false);
    });

    test('get coins successfully', () async {
      when(service.coins()).thenAnswer((_) async => jtos);
      for (var i = 0; i < coins.length; i++) {
        when(mapper.fromDTO(jtos[i])).thenReturn(coins[i]);
      }

      expect(await repository.coins, coins);

      verify(service.coins()).called(1);
      for (var i = 0; i < coins.length; i++) {
        verify(mapper.fromDTO(jtos[i])).called(1);
      }
    });

    test('get coins with an unexpected error', () async {
      when(service.coins()).thenThrow(Exception());

      expect(() async => await repository.coins, throwsException);

      verify(service.coins()).called(1);
    });
  });
}
