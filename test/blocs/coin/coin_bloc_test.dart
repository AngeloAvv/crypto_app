import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_app/blocs/coin/coin_bloc.dart';
import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/models/coin_fixture_factory.dart';
import 'coin_bloc_test.mocks.dart';

@GenerateMocks([CoinRepository])
void main() {
  late MockCoinRepository coinRepository;
  late CoinBloc bloc;

  setUp(() {
    coinRepository = MockCoinRepository();
    bloc = CoinBloc(coinRepository: coinRepository);
  });

  /// Testing the event [FetchCoinEvent]
  group('when the event FetchCoinEvent is added to the BLoC', () {
    late List<Coin> coins;
    late dynamic exception;

    setUp(() {
      coins = CoinFixture.factory().makeMany(3);
      exception = Exception();
    });

    blocTest<CoinBloc, CoinState>(
      'test that CoinBloc emits CoinState.fetched when fetch is called',
      setUp: () {
        when(coinRepository.coins).thenAnswer((_) async => coins);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <CoinState>[
        const CoinState.fetching(),
        CoinState.fetched(coins),
      ],
      verify: (_) {
        verify(coinRepository.coins).called(1);
      },
    );

    blocTest<CoinBloc, CoinState>(
      'test that CoinBloc emits CoinState.errorFetching when fetch is called and an error occurs',
      setUp: () {
        when(coinRepository.coins).thenThrow(exception);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <CoinState>[
        const CoinState.fetching(),
        CoinState.errorFetching(exception),
      ],
      verify: (_) {
        verify(coinRepository.coins).called(1);
      },
    );

    blocTest<CoinBloc, CoinState>(
      'test that CoinBloc emits CoinState.none when fetch is called',
      setUp: () {
        when(coinRepository.coins).thenAnswer((_) async => []);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <CoinState>[
        const CoinState.fetching(),
        const CoinState.none(),
      ],
      verify: (_) {
        verify(coinRepository.coins).called(1);
      },
    );
  });
}
