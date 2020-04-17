import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:f_orm_m8_sqlite/exceptions/field_parse_exception.dart';
import 'package:f_orm_m8_sqlite/generator/emitted_entity.dart';

import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

import 'package:source_gen/source_gen.dart';

class ModelParser extends ValidationCollectable {
  String modelName;
  EntityType entityType;
  ConstantReader reader;
  int entityMetadataLevel;

  EntityAttributeFactory entityAttributeFactory;

  String get packageIdentifier => modelClassElement.library.identifier;

  final ClassElement modelClassElement;
  final String entityName;

  final Map<String, EntityAttribute> entityAttributes =
      <String, EntityAttribute>{};

  ModelParser(this.modelClassElement, this.entityName) {
    modelName = this.modelClassElement.name;
    entityAttributeFactory = EntityAttributeFactory();
  }

  EmittedEntity getEmittedEntity() {
    _extractEntityMeta();
    _extractEntityAttributes();

    _validatePostExtraction();

    final EmittedEntity resultEntity = EmittedEntity(modelName, entityName,
        entityType, entityMetadataLevel, entityAttributes, packageIdentifier);

    return resultEntity;
  }

  void _extractEntityMeta() {
    if (!validatePreExtractionConditions()) {
      validationIssues.add(ValidationIssue(
          isError: true,
          message:
              "Model ${modelName} does not implement `DbEntity` or `DbOpenEntity` interface!"));
      return;
    }

    final ElementAnnotation elementAnnotationMetadata =
        modelClassElement.metadata.firstWhere(
            (meta) =>
                isDataTable.isExactlyType(meta.computeConstantValue().type),
            orElse: () => throw Exception(
                "The DbEntity implementations must be annotated with `@DataTable`!"));

    entityMetadataLevel = modelClassElement.metadata
            .map((ElementAnnotation annot) => annot.computeConstantValue())
            .where((DartObject d) => isDataTable.isExactlyType(d.type))
            .map((DartObject obj) => obj.getField('metadataLevel').toIntValue())
            .first ??
        0;

    reader = ConstantReader(elementAnnotationMetadata.computeConstantValue());

    if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbAccountEntity.isExactlyType(i))) {
      entityType = EntityType.account;
    } else if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbAccountRelatedEntity.isExactlyType(i))) {
      entityType = EntityType.accountRelated;
    } else if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbEntity.isExactlyType(i))) {
      entityType = EntityType.independent;
    } else if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbOpenEntity.isExactlyType(i))) {
      entityType = EntityType.open;
    }
  }

  bool validatePreExtractionConditions() {
    if (isDbEntity.isAssignableFromType(modelClassElement.thisType)) {
      return true;
    }

    if (isDbOpenEntity.isAssignableFromType(modelClassElement.thisType)) {
      return true;
    }

    return false;
  }

  void _extractEntityAttributes() {
    modelClassElement.fields.forEach((f) {
      _parseModelField(f);
    });
  }

  void _parseModelField(FieldElement field) {
    try {
      if (field.displayName == 'hashCode' ||
          field.displayName == 'runtimeType' ||
          field.isStatic ||
          field.getter == null ||
          field.setter == null) return;
      //todo final or synthetic

      var valuesList = field.metadata
          .map((ElementAnnotation annot) => annot.computeConstantValue())
          .toList();

      List<EntityAttribute> rawEntityAttributes = valuesList
          .where((DartObject d) => isDataColumn.isExactlyType(d.type))
          .map((DartObject dataColumnAnnotation) {
        return entityAttributeFactory.extractEntityAttribute(
            field, dataColumnAnnotation);
      }).toList();

      if (rawEntityAttributes.length > 1) {
        validationIssues.add(ValidationIssue(
            isError: true,
            message:
                "Multiple DataColumn annotations on field ${modelName}.${field.name}"));
        return;
      }

      if (rawEntityAttributes.isEmpty) {
        return;
      }

      var firstField = rawEntityAttributes.first;

      if (mustIgnore(firstField.metadataLevel)) {
        return;
      }

      if (firstField is EntityAttributeFromNotImplemented) {
        validationIssues.add(ValidationIssue(
            isError: true,
            message:
                "The type ${firstField.modelTypeName} of ${modelName}.${field.name} is not implemented. Remove it from the model."));
        return;
      }

      if (firstField is EntityAttribute) {
        entityAttributes[firstField.modelName] = firstField;
      }
    } catch (exception, stack) {
      throw FieldParseException(field.name, modelName,
          inner: exception, trace: stack, message: "Parser exception");
    }
  }

  void _validatePostExtraction() {
    if (entityAttributes.isEmpty) {
      validationIssues.add(ValidationIssue(
          isError: true,
          message:
              "The type ${modelName} does not contain valid fields at all"));
      return;
    }
  }
}
