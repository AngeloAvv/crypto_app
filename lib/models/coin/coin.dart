import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin.freezed.dart';

@freezed
class Coin with _$Coin {
  const Coin._();

  const factory Coin({
    required String id,
    required String symbol,
    required String name,
    String? image,
    required num currentPrice,
    required num marketCap,
    required num priceChangePercentage24h,
  }) = _Coin;

  String get formattedName => '$name (${symbol.toUpperCase()})';

  bool get priceRising => priceChangePercentage24h > 0;

  bool get priceFalling => priceChangePercentage24h < 0;
}
