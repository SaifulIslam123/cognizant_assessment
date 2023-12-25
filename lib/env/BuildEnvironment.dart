enum Environment { DEV, PROD }

class BuildEnvironment {
  static BuildEnvironment environment = DevEnvironment();

  late String baseUrl;

  late String contactsUrl;

  late String type;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        environment = DevEnvironment();
        break;
      case Environment.PROD:
        environment = ProdEnvironment();
        break;
    }
  }
}

class DevEnvironment extends BuildEnvironment {
  DevEnvironment() {
    baseUrl = "https://mocki.io";
    contactsUrl = "/v1/b0678e55-caaa-4a80-9c56-8113ecd43303";
    type = "dev";
  }
}

class ProdEnvironment extends BuildEnvironment {
  ProdEnvironment() {
    baseUrl = "https://cognizantv3.free.beeceptor.com";
    contactsUrl = "/contacts";
    type = "prod";
  }
}
