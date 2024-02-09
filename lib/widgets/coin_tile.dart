import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/features/theme/extensions/color_extension.dart';
import 'package:crypto_app/misc/formatters/price_format.dart';
import 'package:crypto_app/models/coin/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:intl/intl.dart';

class CoinTile extends StatelessWidget {
  final Coin coin;

  const CoinTile(this.coin, {super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: coin.image?.let(
          (url) => CachedNetworkImage(
            imageUrl: url,
            width: 56.0,
            height: 56.0,
          ),
        ),
        minLeadingWidth: 56.0,
        title: Text(coin.formattedName),
        subtitle: Text(PriceFormat(decimalDigits: 0).format(coin.marketCap)),
        trailing: SizedBox.fromSize(
          size: const Size(140.0, 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                PriceFormat().format(coin.currentPrice),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(height: 2),
              Text(
                NumberFormat.decimalPercentPattern(decimalDigits: 2)
                    .format(coin.priceChangePercentage24h / 100),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: coin.priceRising
                          ? context.colors?.rising
                          : coin.priceFalling
                              ? context.colors?.falling
                              : context.colors?.neutral,
                    ),
              ),
            ],
          ),
        ),
      );
}
