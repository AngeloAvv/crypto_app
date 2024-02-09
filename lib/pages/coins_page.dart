import 'package:auto_route/auto_route.dart';
import 'package:crypto_app/blocs/coin/coin_bloc.dart';
import 'package:crypto_app/widgets/coin_tile.dart';
import 'package:crypto_app/widgets/loading_widget.dart';
import 'package:crypto_app/widgets/no_coins_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Enter the Coins documentation here
@RoutePage()
class CoinsPage extends StatelessWidget implements AutoRouteWrapper {
  /// The constructor of the page.
  const CoinsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<CoinBloc>(
            create: (context) => CoinBloc(
              coinRepository: context.read(),
            )..fetch(),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Crypto App')),
        body: BlocBuilder<CoinBloc, CoinState>(
          builder: (context, state) => switch (state) {
            FetchingCoinState() => const LoadingWidget(),
            FetchedCoinState(:final coins) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final coin = coins[index];

                  return CoinTile(coin);
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: coins.length,
              ),
            NoneCoinState() => NoCoinsWidget(
                onPressed: () => context.read<CoinBloc>().fetch(),
              ),
            ErrorFetchingCoinState() => NoCoinsWidget(
                onPressed: () => context.read<CoinBloc>().fetch(),
              ),
            _ => const SizedBox.shrink(),
          },
        ),
      );
}
