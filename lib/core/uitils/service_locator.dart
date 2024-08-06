import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

import '../../features/reels/data/repos/reels_repo_imp.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ReelsRepoImpl>(
    ReelsRepoImpl(),
  );
}
