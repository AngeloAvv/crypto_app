import 'package:crypto_app/models/coin/coin.dart';
import 'package:data_fixture_dart/data_fixture_dart.dart';

extension CoinFixture on Coin {
  static CoinFixtureFactory factory() => CoinFixtureFactory();
}

class CoinFixtureFactory extends FixtureFactory<Coin> {
  @override
  FixtureDefinition<Coin> definition() => define(
        (faker) => Coin(
          id: faker.randomGenerator.string(10),
          symbol: faker.currency.code(),
          name: faker.currency.name(),
          image: faker.internet.httpsUrl(),
          currentPrice: faker.randomGenerator.decimal(),
          marketCap: faker.randomGenerator.integer(1000),
          priceChangePercentage24h: faker.randomGenerator.decimal(),
        ),
      );
}
