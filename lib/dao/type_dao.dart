import 'package:floor/floor.dart';
import 'package:baitafome/models/type.dart';

@dao
abstract class TypeDao {
  @Query('SELECT * FROM Type')
  Future<List<Type>> findAllTypes();

  @Query('SELECT description FROM Type WHERE id = :id')
  Future<List<String>> findAllDescriptionType(int id);

  @Query('SELECT * FROM Type WHERE id = :id')
  Future<Type?> findTypeById(int id);

  @insert
  Future<void> insertType(Type type);
}
