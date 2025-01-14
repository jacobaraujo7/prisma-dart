import 'dart:async';

import '../../dmmf/dmmf.dart' show Document;
import 'get_config_result.dart';
import 'types/query_engine.dart';
import 'types/transaction.dart';

abstract class Engine {
  const Engine({
    required this.schema,
    required this.dmmf,
  });

  /// Prisma schema as SDL string.
  final String schema;

  /// Prisma schema as [Document].
  final Document dmmf;

  /// Start the engine.
  Future<void> start();

  /// Stop the engine.
  Future<void> stop();

  /// Get Current configuration.
  FutureOr<GetConfigResult> getConfig();

  /// Get Current DMMF.
  FutureOr<Document> getDmmf() => dmmf;

  /// Get current engine version.
  Future<String> version({bool forceRun = false}) async => 'unknown';

  /// Request a query execution.
  Future<QueryEngineResult> request({
    required String query,
    QueryEngineRequestHeaders? headers,
  });

  /// Request batch query execution.
  Future<List<QueryEngineResult>> requestBatch({
    required List<String> queries,
    QueryEngineRequestHeaders? headers,
    bool? transaction,
  });

  /// Start a transaction.
  Future<TransactionInfo> startTransaction({
    required TransactionHeaders headers,
    TransactionOptions options = const TransactionOptions(),
  });

  /// Commit a transaction.
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  });

  /// Rollback a transaction.
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required TransactionInfo info,
  });
}
