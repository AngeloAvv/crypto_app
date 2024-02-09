import 'dart:async';

import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_bloc.freezed.dart';

part 'coin_event.dart';

part 'coin_state.dart';

/// The CoinBloc
class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepository coinRepository;

  /// Create a new instance of [CoinBloc].
  CoinBloc({
    required this.coinRepository,
  }) : super(const CoinState.initial()) {
    on<FetchCoinEvent>(_onFetch);
  }

  /// Method used to add the [FetchCoinEvent] event
  void fetch() => add(const CoinEvent.fetch());

  FutureOr<void> _onFetch(
    FetchCoinEvent event,
    Emitter<CoinState> emit,
  ) async {
    try {
      emit(const CoinState.fetching());
      final coins = await coinRepository.coins;
      emit(
        coins.isNotEmpty ? CoinState.fetched(coins) : const CoinState.none(),
      );
    } catch (error) {
      emit(CoinState.errorFetching(error));
    }
  }
}
