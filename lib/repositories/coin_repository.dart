import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/services/network/coin/coin_service.dart';
import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:pine/pine.dart';
import 'package:talker/talker.dart';

/// Abstract class of CoinRepository
abstract class CoinRepository {
  Future<List<Coin>> get coins;
}

/// Implementation of the base interface CoinRepository
class CoinRepositoryImpl implements CoinRepository {
  final CoinService coinService;
  final DTOMapper<CoinJTO, Coin> coinMapper;
  final Talker logger;

  const CoinRepositoryImpl({
    required this.coinService,
    required this.coinMapper,
    required this.logger,
  });

  @override
  Future<List<Coin>> get coins async {
    try {
      logger.info('Fetching coins');
      final jtos = await coinService.coins();
      logger.info('Coins fetched');
      return jtos.map(coinMapper.fromDTO).toList(growable: false);
    } catch (error, stackTrace) {
      logger.error('Failed to fetch coins', error, stackTrace);
      rethrow;
    }
  }
}
