import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_app/blocs/coin/coin_bloc.dart';
import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/pages/coins_page.dart';
import 'package:crypto_app/widgets/coin_tile.dart';
import 'package:crypto_app/widgets/no_coins_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pine/pine.dart';

import '../../fixtures/models/coin_fixture_factory.dart';

/// Test case for the page Coins
void main() {
  late MockCoinBloc coinBloc;
  late List<BlocProvider> blocs;

  late List<Coin> coins;

  setUpAll(() => HttpOverrides.global = null);

  setUp(() {
    coinBloc = MockCoinBloc();
    blocs = [
      BlocProvider<CoinBloc>.value(value: coinBloc),
    ];

    coins = CoinFixture.factory().makeMany(3);
  });

  testWidgets(
      'Testing that CoinsPage with a list of coins is rendered properly',
      (tester) async {
    whenListen(
      coinBloc,
      Stream.fromIterable([
        const FetchingCoinState(),
        FetchedCoinState(coins),
      ]),
      initialState: const FetchingCoinState(),
    );

    await tester.pumpWidget(
      DependencyInjectorHelper(
        blocs: blocs,
        child: const MaterialApp(
          home: CoinsPage(),
        ),
      ),
    );

    expect(find.text('Crypto App'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NoCoinsWidget), findsNothing);
    expect(find.byType(CoinTile), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(NoCoinsWidget), findsNothing);
    expect(find.byType(CoinTile), findsNWidgets(coins.length));
  });

  testWidgets('Testing that CoinsPage with no coins is rendered properly',
      (tester) async {
    whenListen(
      coinBloc,
      Stream.fromIterable([
        const FetchingCoinState(),
        const NoneCoinState(),
      ]),
      initialState: const FetchingCoinState(),
    );

    await tester.pumpWidget(
      DependencyInjectorHelper(
        blocs: blocs,
        child: const MaterialApp(
          home: CoinsPage(),
        ),
      ),
    );

    expect(find.text('Crypto App'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NoCoinsWidget), findsNothing);
    expect(find.byType(CoinTile), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NoCoinsWidget), findsOneWidget);
    expect(find.byType(CoinTile), findsNothing);
  });

  testWidgets('Testing that CoinsPage with an error is rendered properly',
      (tester) async {
    whenListen(
      coinBloc,
      Stream.fromIterable([
        const FetchingCoinState(),
        ErrorFetchingCoinState(Exception()),
      ]),
      initialState: const FetchingCoinState(),
    );

    await tester.pumpWidget(
      DependencyInjectorHelper(
        blocs: blocs,
        child: const MaterialApp(
          home: CoinsPage(),
        ),
      ),
    );

    expect(find.text('Crypto App'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NoCoinsWidget), findsNothing);
    expect(find.byType(CoinTile), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(NoCoinsWidget), findsOneWidget);
    expect(find.byType(CoinTile), findsNothing);
  });
}

class MockCoinBloc extends MockBloc<CoinEvent, CoinState> implements CoinBloc {}
