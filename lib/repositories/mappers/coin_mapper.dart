import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:pine/pine.dart';

class CoinMapper extends DTOMapper<CoinJTO, Coin> {
  const CoinMapper();

  @override
  Coin fromDTO(CoinJTO dto) => Coin(
        id: dto.id,
        symbol: dto.symbol,
        name: dto.name,
        image: dto.image,
        currentPrice: dto.currentPrice,
        marketCap: dto.marketCap,
        priceChangePercentage24h: dto.priceChangePercentage24h,
      );

  @override
  CoinJTO toDTO(Coin model) => CoinJTO(
        id: model.id,
        symbol: model.symbol,
        name: model.name,
        image: model.image,
        currentPrice: model.currentPrice,
        marketCap: model.marketCap,
        priceChangePercentage24h: model.priceChangePercentage24h,
      );
}
