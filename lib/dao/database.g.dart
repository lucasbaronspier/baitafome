// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TypeDao? _typeDaoInstance;

  RecipeDao? _recipeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Type` (`id` INTEGER NOT NULL, `description` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Recipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `description` TEXT, `ingredients` TEXT, `type` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TypeDao get typeDao {
    return _typeDaoInstance ??= _$TypeDao(database, changeListener);
  }

  @override
  RecipeDao get recipeDao {
    return _recipeDaoInstance ??= _$RecipeDao(database, changeListener);
  }
}

class _$TypeDao extends TypeDao {
  _$TypeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _typeInsertionAdapter = InsertionAdapter(
            database,
            'Type',
            (Type item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Type> _typeInsertionAdapter;

  @override
  Future<List<Type>> findAllTypes() async {
    return _queryAdapter.queryList('SELECT * FROM Type',
        mapper: (Map<String, Object?> row) => Type(
            id: row['id'] as int, description: row['description'] as String));
  }

  @override
  Future<List<String>> findAllDescriptionType(int id) async {
    return _queryAdapter.queryList('SELECT description FROM Type WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<Type?> findTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM Type WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Type(
            id: row['id'] as int, description: row['description'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertType(Type type) async {
    await _typeInsertionAdapter.insert(type, OnConflictStrategy.abort);
  }
}

class _$RecipeDao extends RecipeDao {
  _$RecipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _recipeInsertionAdapter = InsertionAdapter(
            database,
            'Recipe',
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'ingredients': item.ingredients,
                  'type': item.type
                }),
        _recipeUpdateAdapter = UpdateAdapter(
            database,
            'Recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'ingredients': item.ingredients,
                  'type': item.type
                }),
        _recipeDeletionAdapter = DeletionAdapter(
            database,
            'Recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'ingredients': item.ingredients,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Recipe> _recipeInsertionAdapter;

  final UpdateAdapter<Recipe> _recipeUpdateAdapter;

  final DeletionAdapter<Recipe> _recipeDeletionAdapter;

  @override
  Future<List<Recipe>> findAllRecipes() async {
    return _queryAdapter.queryList('SELECT * FROM recipe ORDER BY recipe.id',
        mapper: (Map<String, Object?> row) => Recipe(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            type: row['type'] as int?,
            ingredients: row['ingredients'] as String?));
  }

  @override
  Future<Recipe?> findRecipeById(int id) async {
    return _queryAdapter.query('SELECT * FROM recipe WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Recipe(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            type: row['type'] as int?,
            ingredients: row['ingredients'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Recipe>> findRecipeByType(int type) async {
    return _queryAdapter.queryList('SELECT * FROM recipe WHERE type = ?1',
        mapper: (Map<String, Object?> row) => Recipe(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            type: row['type'] as int?,
            ingredients: row['ingredients'] as String?),
        arguments: [type]);
  }

  @override
  Future<void> insertRecipe(Recipe recipe) async {
    await _recipeInsertionAdapter.insert(recipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    await _recipeUpdateAdapter.update(recipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) async {
    await _recipeDeletionAdapter.delete(recipe);
  }
}
