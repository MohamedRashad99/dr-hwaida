import 'package:DrHwaida/models/prodact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHehper {
  static final DbHehper _indtance = DbHehper.internal();
  factory DbHehper() => _indtance;
  String consultantDBName = 'consultantproduct.db';
  String tableName = 'product';
  DbHehper.internal();
  static Database _db;
  Future<Database> createDataBase() async {
    if (_db != null) {
      return _db;
    }
    String path = join(await getDatabasesPath(), consultantDBName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) {
        db.execute(
          'create table $tableName(id integer primary key autoincrement ,' +
              'title varcher(50) , proImageUrl varcher(255) ,dateId integer,' +
              'consultantId integer,price double,date varcher(50),time varcher(50),type varcher(50))',
        );
      },
    );
    return _db;
  }

  Future<int> createProduct(ConsultantProdect product) async {
    Database db = await createDataBase();
    return db.insert(
      tableName,
      product.toMap(),
    );
  }

  Future<List> allProduct() async {
    Database db = await createDataBase();
    return db.query(
      tableName,
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await createDataBase();
    return db.delete(tableName, where: 'id=?', whereArgs: [id]);
  }

  deleteAllProduct() async {
    Database db = await createDataBase();
    return db.delete(tableName);
  }
}
