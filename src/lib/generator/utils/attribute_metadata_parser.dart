import 'package:f_orm_m8_sqlite/generator/utils/type_utils.dart';

class AttributeMetadataParser {
  static String getDefinition(int metadataLevel,
      {String uniqueAttributesComposition = ""}) {
    String definition = "";

    if (isNotNull(metadataLevel)) {
      definition = "$definition NOT NULL";
    }

    if (isPrimaryKey(metadataLevel)) {
      definition = "$definition PRIMARY KEY";
    }

    if (isAutoIncrement(metadataLevel)) {
      definition = "$definition AUTOINCREMENT";
    }

    return definition;
  }
}
