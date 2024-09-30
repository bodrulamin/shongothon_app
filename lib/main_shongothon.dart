import 'package:get_storage/get_storage.dart';

import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  await GetStorage.init();

  F.appFlavor = Flavor.shongothon;
  await runner.main();
}
