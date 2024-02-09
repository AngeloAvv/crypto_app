import 'package:crypto_app/misc/constants.dart';
import 'package:crypto_app/models/coin/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:crypto_app/repositories/mappers/coin_mapper.dart';
import 'package:crypto_app/services/network/coin/coin_service.dart';
import 'package:crypto_app/services/network/jto/coin/coin_jto.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        providers: [
          Provider<Dio>(
            create: (_) {
              final dio = Dio(BaseOptions(
                connectTimeout: K.networkTimeout,
                sendTimeout: K.networkTimeout,
                receiveTimeout: K.networkTimeout,
              ));

              dio.interceptors.addAll([
                RetryInterceptor(
                  dio: dio,
                  retries: 3,
                  retryDelays: const [
                    Duration(seconds: 1),
                    Duration(seconds: 2),
                    Duration(seconds: 3),
                  ],
                ),
                if (kDebugMode)
                  TalkerDioLogger(
                    settings: const TalkerDioLoggerSettings(
                      printRequestHeaders: true,
                      printResponseHeaders: true,
                      printResponseMessage: true,
                    ),
                  ),
              ]);

              return dio;
            },
          ),
          Provider<Talker>(
            create: (_) => Talker(),
          ),
          Provider<CoinService>(
            create: (context) => CoinService(
              context.read(),
              baseUrl: K.baseUrl,
            ),
          ),
        ],
        mappers: [
          Provider<DTOMapper<CoinJTO, Coin>>(
            create: (_) => const CoinMapper(),
          ),
        ],
        repositories: [
          RepositoryProvider<CoinRepository>(
            create: (context) => CoinRepositoryImpl(
              coinService: context.read(),
              coinMapper: context.read(),
              logger: context.read(),
            ),
          ),
        ],
        child: child,
      );
}
