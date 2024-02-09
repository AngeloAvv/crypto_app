part of 'coin_bloc.dart';

@freezed
class CoinEvent with _$CoinEvent {
  
  const factory CoinEvent.fetch() = FetchCoinEvent;
  
}
