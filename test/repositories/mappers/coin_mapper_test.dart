import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/repositories/mappers/coin_mapper.dart';
import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';

void main() {
  late CoinMapper mapper;
  late CoinJTO dto;
  late Coin model;

  setUp(() {
    dto = CoinJTO(
      id: faker.randomGenerator.string(10),
      symbol: faker.currency.code(),
      name: faker.currency.name(),
      image: faker.internet.httpsUrl(),
      currentPrice: faker.randomGenerator.decimal(),
      marketCap: faker.randomGenerator.integer(1000),
      priceChangePercentage24h: faker.randomGenerator.decimal(),
    );

    model = Coin(
      id: dto.id,
      symbol: dto.symbol,
      name: dto.name,
      image: dto.image,
      currentPrice: dto.currentPrice,
      marketCap: dto.marketCap,
      priceChangePercentage24h: dto.priceChangePercentage24h,
    );
    mapper = const CoinMapper();
  });

  test('mapping Coin object from CoinJTO', () {
    expect(mapper.fromDTO(dto), equals(model));
  });

  test('mapping Coin to CoinJTO', () {
    expect(mapper.toDTO(model), equals(dto));
  });
}
