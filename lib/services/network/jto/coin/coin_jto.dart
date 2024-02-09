import 'package:pine/pine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_jto.g.dart';

part 'coin_jto.freezed.dart';

@Freezed(toJson: false, copyWith: false)
class CoinJTO extends DTO with _$CoinJTO {
  const factory CoinJTO({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'current_price') required num currentPrice,
    @JsonKey(name: 'market_cap') required num marketCap,
    @JsonKey(name: 'market_cap_rank') num? marketCapRank,
    @JsonKey(name: 'fully_diluted_valuation') num? fullyDilutedValuation,
    @JsonKey(name: 'total_volume') num? totalVolume,
    @JsonKey(name: 'high_24h') num? high24h,
    @JsonKey(name: 'low_24h') num? low24h,
    @JsonKey(name: 'price_change_24h') num? priceChange24h,
    @JsonKey(name: 'price_change_percentage_24h') required num priceChangePercentage24h,
    @JsonKey(name: 'market_cap_change_24h') num? marketCapChange24h,
    @JsonKey(name: 'market_cap_change_percentage_24h') num? marketCapChangePercentage24h,
    @JsonKey(name: 'circulating_supply') num? circulatingSupply,
    @JsonKey(name: 'total_supply') num? totalSupply,
    @JsonKey(name: 'max_supply') num? maxSupply,
    @JsonKey(name: 'ath') num? ath,
    @JsonKey(name: 'ath_change_percentage') num? athChangePercentage,
    @JsonKey(name: 'ath_date') String? athDate,
    @JsonKey(name: 'atl') num? atl,
    @JsonKey(name: 'atl_change_percentage') num? atlChangePercentage,
    @JsonKey(name: 'atl_date') String? atlDate,
    @JsonKey(name: 'last_updated') String? lastUpdated,
}) = _CoinJTO;

  factory CoinJTO.fromJson(Map<String, dynamic> json) =>
    _$CoinJTOFromJson(json);
}
