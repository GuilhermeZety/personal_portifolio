enum DataTypes {
  apresentation,
  init;

  String toPrismicName() {
    switch (this) {
      case DataTypes.apresentation:
        return 'apresentacao';
      case DataTypes.init:
        return 'inicio';
    }
  }
}
