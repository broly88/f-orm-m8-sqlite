import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class EntityAttributeFromDateTime extends EntityAttribute {
  EntityAttributeFromDateTime(
      String modelTypeName, String modelName, String attributeName,
      {int metadataLevel, List<CompositeConstraint> compositeConstraints})
      : super(modelTypeName, modelName, attributeName,
            metadataLevel: metadataLevel,
            compositeConstraints: compositeConstraints);

  @override
  String getAttributeTypeDefinition() {
    return "INTEGER";
  }

  @override
  String get modelToEntityConversionString {
    return "${modelName}.millisecondsSinceEpoch";
  }

  @override
  String get entityToModelConversionString {
    return "DateTime.fromMillisecondsSinceEpoch(map['${attributeName}'])";
  }
}
