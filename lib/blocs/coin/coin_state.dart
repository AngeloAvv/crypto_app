part of 'coin_bloc.dart';

@freezed
class CoinState with _$CoinState {
  const factory CoinState.initial() = InitialCoinState;

  const factory CoinState.fetching() = FetchingCoinState;

  const factory CoinState.fetched(List<Coin> coins) = FetchedCoinState;

  const factory CoinState.none() = NoneCoinState;

  const factory CoinState.errorFetching(dynamic error) = ErrorFetchingCoinState;
}
