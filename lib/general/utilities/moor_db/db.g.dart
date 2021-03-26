// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String img;
  final int parentId;
  final bool selected;
  final bool showSideManu;
  Category(
      {@required this.id,
      @required this.name,
      @required this.img,
      @required this.parentId,
      @required this.selected,
      @required this.showSideManu});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Category(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      img: stringType.mapFromDatabaseResponse(data['${effectivePrefix}img']),
      parentId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      selected:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}selected']),
      showSideManu: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}show_side_manu']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || img != null) {
      map['img'] = Variable<String>(img);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    if (!nullToAbsent || selected != null) {
      map['selected'] = Variable<bool>(selected);
    }
    if (!nullToAbsent || showSideManu != null) {
      map['show_side_manu'] = Variable<bool>(showSideManu);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      img: img == null && nullToAbsent ? const Value.absent() : Value(img),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      selected: selected == null && nullToAbsent
          ? const Value.absent()
          : Value(selected),
      showSideManu: showSideManu == null && nullToAbsent
          ? const Value.absent()
          : Value(showSideManu),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      img: serializer.fromJson<String>(json['img']),
      parentId: serializer.fromJson<int>(json['parentId']),
      selected: serializer.fromJson<bool>(json['selected']),
      showSideManu: serializer.fromJson<bool>(json['showSideManu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'img': serializer.toJson<String>(img),
      'parentId': serializer.toJson<int>(parentId),
      'selected': serializer.toJson<bool>(selected),
      'showSideManu': serializer.toJson<bool>(showSideManu),
    };
  }

  Category copyWith(
          {int id,
          String name,
          String img,
          int parentId,
          bool selected,
          bool showSideManu}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        img: img ?? this.img,
        parentId: parentId ?? this.parentId,
        selected: selected ?? this.selected,
        showSideManu: showSideManu ?? this.showSideManu,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('img: $img, ')
          ..write('parentId: $parentId, ')
          ..write('selected: $selected, ')
          ..write('showSideManu: $showSideManu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              img.hashCode,
              $mrjc(parentId.hashCode,
                  $mrjc(selected.hashCode, showSideManu.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.img == this.img &&
          other.parentId == this.parentId &&
          other.selected == this.selected &&
          other.showSideManu == this.showSideManu);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> img;
  final Value<int> parentId;
  final Value<bool> selected;
  final Value<bool> showSideManu;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.img = const Value.absent(),
    this.parentId = const Value.absent(),
    this.selected = const Value.absent(),
    this.showSideManu = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String img,
    @required int parentId,
    this.selected = const Value.absent(),
    @required bool showSideManu,
  })  : name = Value(name),
        img = Value(img),
        parentId = Value(parentId),
        showSideManu = Value(showSideManu);
  static Insertable<Category> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> img,
    Expression<int> parentId,
    Expression<bool> selected,
    Expression<bool> showSideManu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (img != null) 'img': img,
      if (parentId != null) 'parent_id': parentId,
      if (selected != null) 'selected': selected,
      if (showSideManu != null) 'show_side_manu': showSideManu,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> img,
      Value<int> parentId,
      Value<bool> selected,
      Value<bool> showSideManu}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      parentId: parentId ?? this.parentId,
      selected: selected ?? this.selected,
      showSideManu: showSideManu ?? this.showSideManu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (img.present) {
      map['img'] = Variable<String>(img.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (selected.present) {
      map['selected'] = Variable<bool>(selected.value);
    }
    if (showSideManu.present) {
      map['show_side_manu'] = Variable<bool>(showSideManu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('img: $img, ')
          ..write('parentId: $parentId, ')
          ..write('selected: $selected, ')
          ..write('showSideManu: $showSideManu')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imgMeta = const VerificationMeta('img');
  GeneratedTextColumn _img;
  @override
  GeneratedTextColumn get img => _img ??= _constructImg();
  GeneratedTextColumn _constructImg() {
    return GeneratedTextColumn(
      'img',
      $tableName,
      false,
    );
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedIntColumn _parentId;
  @override
  GeneratedIntColumn get parentId => _parentId ??= _constructParentId();
  GeneratedIntColumn _constructParentId() {
    return GeneratedIntColumn(
      'parent_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _selectedMeta = const VerificationMeta('selected');
  GeneratedBoolColumn _selected;
  @override
  GeneratedBoolColumn get selected => _selected ??= _constructSelected();
  GeneratedBoolColumn _constructSelected() {
    return GeneratedBoolColumn('selected', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _showSideManuMeta =
      const VerificationMeta('showSideManu');
  GeneratedBoolColumn _showSideManu;
  @override
  GeneratedBoolColumn get showSideManu =>
      _showSideManu ??= _constructShowSideManu();
  GeneratedBoolColumn _constructShowSideManu() {
    return GeneratedBoolColumn(
      'show_side_manu',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, img, parentId, selected, showSideManu];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('img')) {
      context.handle(
          _imgMeta, img.isAcceptableOrUnknown(data['img'], _imgMeta));
    } else if (isInserting) {
      context.missing(_imgMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id'], _parentIdMeta));
    } else if (isInserting) {
      context.missing(_parentIdMeta);
    }
    if (data.containsKey('selected')) {
      context.handle(_selectedMeta,
          selected.isAcceptableOrUnknown(data['selected'], _selectedMeta));
    }
    if (data.containsKey('show_side_manu')) {
      context.handle(
          _showSideManuMeta,
          showSideManu.isAcceptableOrUnknown(
              data['show_side_manu'], _showSideManuMeta));
    } else if (isInserting) {
      context.missing(_showSideManuMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Category.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categories];
}
