import 'package:moor/moor.dart';
// Define tables that can model a database of recipes.

@DataClassName('Category')
class Categories extends Table {

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get img => text()();
  IntColumn get parentId => integer()();
  BoolColumn get selected => boolean().withDefault(const Constant(false))();
  BoolColumn get showSideManu => boolean()();


  @override
  Set<Column> get primaryKey => {id};

  @override
  String toString() {
    return name.toString();
  }

}