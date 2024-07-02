// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppStateLocalCollection on Isar {
  IsarCollection<AppStateLocal> get appStateLocals => this.collection();
}

const AppStateLocalSchema = CollectionSchema(
  name: r'AppStateLocal',
  id: 4967882409137080517,
  properties: {
    r'darkModePreference': PropertySchema(
      id: 0,
      name: r'darkModePreference',
      type: IsarType.byte,
      enumMap: _AppStateLocaldarkModePreferenceEnumValueMap,
    )
  },
  estimateSize: _appStateLocalEstimateSize,
  serialize: _appStateLocalSerialize,
  deserialize: _appStateLocalDeserialize,
  deserializeProp: _appStateLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appStateLocalGetId,
  getLinks: _appStateLocalGetLinks,
  attach: _appStateLocalAttach,
  version: '3.1.7',
);

int _appStateLocalEstimateSize(
  AppStateLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _appStateLocalSerialize(
  AppStateLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.darkModePreference.index);
}

AppStateLocal _appStateLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppStateLocal();
  object.darkModePreference = _AppStateLocaldarkModePreferenceValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      DarkModePreference.alwaysDark;
  object.id = id;
  return object;
}

P _appStateLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_AppStateLocaldarkModePreferenceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          DarkModePreference.alwaysDark) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppStateLocaldarkModePreferenceEnumValueMap = {
  'alwaysDark': 0,
  'alwaysLight': 1,
};
const _AppStateLocaldarkModePreferenceValueEnumMap = {
  0: DarkModePreference.alwaysDark,
  1: DarkModePreference.alwaysLight,
};

Id _appStateLocalGetId(AppStateLocal object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _appStateLocalGetLinks(AppStateLocal object) {
  return [];
}

void _appStateLocalAttach(
    IsarCollection<dynamic> col, Id id, AppStateLocal object) {
  object.id = id;
}

extension AppStateLocalQueryWhereSort
    on QueryBuilder<AppStateLocal, AppStateLocal, QWhere> {
  QueryBuilder<AppStateLocal, AppStateLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppStateLocalQueryWhere
    on QueryBuilder<AppStateLocal, AppStateLocal, QWhereClause> {
  QueryBuilder<AppStateLocal, AppStateLocal, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppStateLocalQueryFilter
    on QueryBuilder<AppStateLocal, AppStateLocal, QFilterCondition> {
  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition>
      darkModePreferenceEqualTo(DarkModePreference value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkModePreference',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition>
      darkModePreferenceGreaterThan(
    DarkModePreference value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'darkModePreference',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition>
      darkModePreferenceLessThan(
    DarkModePreference value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'darkModePreference',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition>
      darkModePreferenceBetween(
    DarkModePreference lower,
    DarkModePreference upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'darkModePreference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppStateLocalQueryObject
    on QueryBuilder<AppStateLocal, AppStateLocal, QFilterCondition> {}

extension AppStateLocalQueryLinks
    on QueryBuilder<AppStateLocal, AppStateLocal, QFilterCondition> {}

extension AppStateLocalQuerySortBy
    on QueryBuilder<AppStateLocal, AppStateLocal, QSortBy> {
  QueryBuilder<AppStateLocal, AppStateLocal, QAfterSortBy>
      sortByDarkModePreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkModePreference', Sort.asc);
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterSortBy>
      sortByDarkModePreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkModePreference', Sort.desc);
    });
  }
}

extension AppStateLocalQuerySortThenBy
    on QueryBuilder<AppStateLocal, AppStateLocal, QSortThenBy> {
  QueryBuilder<AppStateLocal, AppStateLocal, QAfterSortBy>
      thenByDarkModePreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkModePreference', Sort.asc);
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterSortBy>
      thenByDarkModePreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkModePreference', Sort.desc);
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppStateLocal, AppStateLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension AppStateLocalQueryWhereDistinct
    on QueryBuilder<AppStateLocal, AppStateLocal, QDistinct> {
  QueryBuilder<AppStateLocal, AppStateLocal, QDistinct>
      distinctByDarkModePreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'darkModePreference');
    });
  }
}

extension AppStateLocalQueryProperty
    on QueryBuilder<AppStateLocal, AppStateLocal, QQueryProperty> {
  QueryBuilder<AppStateLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppStateLocal, DarkModePreference, QQueryOperations>
      darkModePreferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'darkModePreference');
    });
  }
}
