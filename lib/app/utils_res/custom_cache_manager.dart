import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/storage/file_system/file_system_io.dart';

class CustomCacheManager extends CacheManager {
  static const key = 'fitmintDataFiles';
  static final CustomCacheManager _instance = CustomCacheManager._();

  factory CustomCacheManager() {
    return _instance;
  }

  CustomCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 30),
            maxNrOfCacheObjects: 10,
            repo: JsonCacheInfoRepository(databaseName: key),
            fileService: HttpFileService(),
            fileSystem: IOFileSystem(key),
          ),
        );
}
