enum Enviroment {
  localhost,
  development,
  staging,
  production,
}

mixin AppConfiguration {
  static const Enviroment enviroment = Enviroment.development;
  static const bool isDebug = true;
}
