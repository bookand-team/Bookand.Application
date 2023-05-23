import 'package:bookand/data/datasource/push/push_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repository/push_repository.dart';
import '../datasource/push/push_local_data_source_impl.dart';

part 'push_repository_impl.g.dart';

@riverpod
PushRepository pushRepository(PushRepositoryRef ref) {
  final pushLocalDataSource = ref.read(pushLocalDataSourceProvider);

  return PushRepositoryImpl(pushLocalDataSource);
}

class PushRepositoryImpl implements PushRepository {
  final PushLocalDataSource pushLocalDataSource;

  PushRepositoryImpl(this.pushLocalDataSource);

  @override
  Future<bool> isEnabledPush() async {
    return await pushLocalDataSource.isEnabledPush();
  }

  @override
  Future<void> setEnabledPush(bool enabled) async {
    await pushLocalDataSource.setEnabledPush(enabled);
  }
}
