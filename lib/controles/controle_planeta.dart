import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modelos/planeta.dart';

class ControlePlaneta {
  static Database? _bd;

  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.db');
    return _bd!;
  }

  // Inicializa o banco de dados
  Future<Database> _initBD(String localArquivo) async {
    final caminhoBD = await getDatabasesPath();
    final caminho = join(caminhoBD, localArquivo);
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBD,
    );
  }

  // Cria a tabela do banco de dados
  Future<void> _criarBD(Database db, int version) async {
    const sql = '''
CREATE TABLE planetas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  tamanho REAL NOT NULL,
  distancia REAL NOT NULL,
  apelido TEXT
)
''';
    await db.execute(sql);
  }

  // Lê todos os planetas do banco de dados
  Future<List<Planeta>> lerPlanetas() async {
    final db = await bd;
    final result = await db.query('planetas');
    return result.map((map) => Planeta.fromMap(map)).toList();
  }

  // Insere um planeta no banco de dados
  Future<int> inserirPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.insert(
      'planetas',
      planeta.toMap(),
    );
  }

  Future<int> alterarPlaneta(Planeta planeta) async {
    final db = await bd;
    return db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }

  Future<int> excluirPlaneta(int id) async {
    final db = await bd;
    return await db.delete('planetas', where: 'id = ?', whereArgs: [id]);
  }
}
