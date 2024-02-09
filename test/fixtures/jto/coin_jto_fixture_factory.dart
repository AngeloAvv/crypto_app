import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:data_fixture_dart/data_fixture_dart.dart';

extension CoinJTOFixture on CoinJTO {
  static CoinJTOFixtureFactory factory() => CoinJTOFixtureFactory();
}

class CoinJTOFixtureFactory extends JsonFixtureFactory<CoinJTO> {
  @override
  FixtureDefinition<CoinJTO> definition() => define(
        (faker) => CoinJTO(
          id: faker.randomGenerator.string(10),
          symbol: faker.currency.code(),
          name: faker.currency.name(),
          image: faker.internet.httpsUrl(),
          currentPrice: faker.randomGenerator.decimal(),
          marketCap: faker.randomGenerator.integer(1000),
          marketCapRank: faker.randomGenerator.integer(10),
          fullyDilutedValuation: faker.randomGenerator.integer(1000),
          totalVolume: faker.randomGenerator.integer(1000),
          high24h: faker.randomGenerator.decimal(),
          low24h: faker.randomGenerator.decimal(),
          priceChange24h: faker.randomGenerator.decimal(),
          priceChangePercentage24h: faker.randomGenerator.decimal(),
          marketCapChange24h: faker.randomGenerator.integer(1000),
          marketCapChangePercentage24h: faker.randomGenerator.decimal(),
          circulatingSupply: faker.randomGenerator.integer(1000),
          totalSupply: faker.randomGenerator.integer(1000),
          maxSupply: faker.randomGenerator.integer(1000),
          ath: faker.randomGenerator.decimal(),
          athChangePercentage: faker.randomGenerator.decimal(),
          athDate: faker.date.dateTime().toIso8601String(),
          atl: faker.randomGenerator.decimal(),
          atlChangePercentage: faker.randomGenerator.decimal(),
          atlDate: faker.date.dateTime().toIso8601String(),
          lastUpdated: faker.date.dateTime().toIso8601String(),
        ),
      );

  @override
  JsonFixtureDefinition<CoinJTO> jsonDefinition() => defineJson(
        (object) => {
          'id': object.id,
          'symbol': object.symbol,
          'name': object.name,
          'image': object.image,
          'current_price': object.currentPrice,
          'market_cap': object.marketCap,
          'market_cap_rank': object.marketCapRank,
          'fully_diluted_valuation': object.fullyDilutedValuation,
          'total_volume': object.totalVolume,
          'high_24h': object.high24h,
          'low_24h': object.low24h,
          'price_change_24h': object.priceChange24h,
          'price_change_percentage_24h': object.priceChangePercentage24h,
          'market_cap_change_24h': object.marketCapChange24h,
          'market_cap_change_percentage_24h':
              object.marketCapChangePercentage24h,
          'circulating_supply': object.circulatingSupply,
          'total_supply': object.totalSupply,
          'max_supply': object.maxSupply,
          'ath': object.ath,
          'ath_change_percentage': object.athChangePercentage,
          'ath_date': object.athDate,
          'atl': object.atl,
          'atl_change_percentage': object.atlChangePercentage,
          'atl_date': object.atlDate,
          'last_updated': object.lastUpdated,
        },
      );
}
