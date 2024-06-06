// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStationLocalCollection on Isar {
  IsarCollection<StationLocal> get stationLocals => this.collection();
}

const StationLocalSchema = CollectionSchema(
  name: r'StationLocal',
  id: 1270939461689724647,
  properties: {
    r'daop': PropertySchema(
      id: 0,
      name: r'daop',
      type: IsarType.long,
    ),
    r'fgEnable': PropertySchema(
      id: 1,
      name: r'fgEnable',
      type: IsarType.long,
    ),
    r'haveSchedule': PropertySchema(
      id: 2,
      name: r'haveSchedule',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'stationId': PropertySchema(
      id: 4,
      name: r'stationId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.string,
    )
  },
  estimateSize: _stationLocalEstimateSize,
  serialize: _stationLocalSerialize,
  deserialize: _stationLocalDeserialize,
  deserializeProp: _stationLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _stationLocalGetId,
  getLinks: _stationLocalGetLinks,
  attach: _stationLocalAttach,
  version: '3.1.7',
);

int _stationLocalEstimateSize(
  StationLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stationId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.updatedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _stationLocalSerialize(
  StationLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.daop);
  writer.writeLong(offsets[1], object.fgEnable);
  writer.writeBool(offsets[2], object.haveSchedule);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.stationId);
  writer.writeString(offsets[5], object.updatedAt);
}

StationLocal _stationLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StationLocal();
  object.daop = reader.readLongOrNull(offsets[0]);
  object.fgEnable = reader.readLongOrNull(offsets[1]);
  object.haveSchedule = reader.readBoolOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[3]);
  object.stationId = reader.readStringOrNull(offsets[4]);
  object.updatedAt = reader.readStringOrNull(offsets[5]);
  return object;
}

P _stationLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stationLocalGetId(StationLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stationLocalGetLinks(StationLocal object) {
  return [];
}

void _stationLocalAttach(
    IsarCollection<dynamic> col, Id id, StationLocal object) {
  object.id = id;
}

extension StationLocalQueryWhereSort
    on QueryBuilder<StationLocal, StationLocal, QWhere> {
  QueryBuilder<StationLocal, StationLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StationLocalQueryWhere
    on QueryBuilder<StationLocal, StationLocal, QWhereClause> {
  QueryBuilder<StationLocal, StationLocal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<StationLocal, StationLocal, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterWhereClause> idBetween(
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

extension StationLocalQueryFilter
    on QueryBuilder<StationLocal, StationLocal, QFilterCondition> {
  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> daopIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'daop',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      daopIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'daop',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> daopEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daop',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      daopGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daop',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> daopLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daop',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> daopBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daop',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      fgEnableIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fgEnable',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      fgEnableIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fgEnable',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      fgEnableEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fgEnable',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      fgEnableGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fgEnable',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      fgEnableLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fgEnable',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      fgEnableBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fgEnable',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      haveScheduleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'haveSchedule',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      haveScheduleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'haveSchedule',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      haveScheduleEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'haveSchedule',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stationId',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stationId',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stationId',
        value: '',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      stationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stationId',
        value: '',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterFilterCondition>
      updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }
}

extension StationLocalQueryObject
    on QueryBuilder<StationLocal, StationLocal, QFilterCondition> {}

extension StationLocalQueryLinks
    on QueryBuilder<StationLocal, StationLocal, QFilterCondition> {}

extension StationLocalQuerySortBy
    on QueryBuilder<StationLocal, StationLocal, QSortBy> {
  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByDaop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daop', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByDaopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daop', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByFgEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fgEnable', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByFgEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fgEnable', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByHaveSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haveSchedule', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy>
      sortByHaveScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haveSchedule', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByStationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationId', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByStationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationId', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension StationLocalQuerySortThenBy
    on QueryBuilder<StationLocal, StationLocal, QSortThenBy> {
  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByDaop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daop', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByDaopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daop', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByFgEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fgEnable', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByFgEnableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fgEnable', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByHaveSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haveSchedule', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy>
      thenByHaveScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'haveSchedule', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByStationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationId', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByStationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stationId', Sort.desc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension StationLocalQueryWhereDistinct
    on QueryBuilder<StationLocal, StationLocal, QDistinct> {
  QueryBuilder<StationLocal, StationLocal, QDistinct> distinctByDaop() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daop');
    });
  }

  QueryBuilder<StationLocal, StationLocal, QDistinct> distinctByFgEnable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fgEnable');
    });
  }

  QueryBuilder<StationLocal, StationLocal, QDistinct> distinctByHaveSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'haveSchedule');
    });
  }

  QueryBuilder<StationLocal, StationLocal, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QDistinct> distinctByStationId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StationLocal, StationLocal, QDistinct> distinctByUpdatedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }
}

extension StationLocalQueryProperty
    on QueryBuilder<StationLocal, StationLocal, QQueryProperty> {
  QueryBuilder<StationLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StationLocal, int?, QQueryOperations> daopProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daop');
    });
  }

  QueryBuilder<StationLocal, int?, QQueryOperations> fgEnableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fgEnable');
    });
  }

  QueryBuilder<StationLocal, bool?, QQueryOperations> haveScheduleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'haveSchedule');
    });
  }

  QueryBuilder<StationLocal, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<StationLocal, String?, QQueryOperations> stationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stationId');
    });
  }

  QueryBuilder<StationLocal, String?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
