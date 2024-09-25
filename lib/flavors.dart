enum Flavor {
  shongothon,
  shongothon_pro,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.shongothon:
        return 'Shongothon';
      case Flavor.shongothon_pro:
        return 'Shongothon Pro';
      default:
        return 'title';
    }
  }

}
