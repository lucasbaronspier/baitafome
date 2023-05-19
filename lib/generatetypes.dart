import 'package:baitafome/dao/database.dart';
import 'package:baitafome/models/type.dart';
import 'package:baitafome/dao/type_dao.dart';

void generateTypes() async {
  //generatin database instance
  final database =
      await $FloorAppDatabase.databaseBuilder('baitafome.db').build();

  //generatin types for the app
  final typeDao = database.typeDao;
  final type1 = Type(id: 1, description: 'sobremesa');
  final type2 = Type(id: 2, description: 'bolo');
  final type3 = Type(id: 3, description: 'carne');
  final type4 = Type(id: 4, description: 'peixe');
  final type5 = Type(id: 5, description: 'torta');
  final type6 = Type(id: 6, description: 'massa');
  final type7 = Type(id: 7, description: 'suco');
  final type8 = Type(id: 8, description: 'salada');
  final type9 = Type(id: 9, description: 'pao');
  final type10 = Type(id: 10, description: 'sopa');
  final type11 = Type(id: 11, description: 'frango');
  final type12 = Type(id: 12, description: 'outros');

  await typeDao.insertType(type1);
  await typeDao.insertType(type2);
  await typeDao.insertType(type3);
  await typeDao.insertType(type4);
  await typeDao.insertType(type5);
  await typeDao.insertType(type6);
  await typeDao.insertType(type7);
  await typeDao.insertType(type8);
  await typeDao.insertType(type9);
  await typeDao.insertType(type10);
  await typeDao.insertType(type11);
  await typeDao.insertType(type12);
}
