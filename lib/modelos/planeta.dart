class Planeta {
  int? id;
  String nome;
  double tamanho;
  double distancia;
  String? apelido;

  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distancia,
    this.apelido,
  });

// Para um Planeta vazio
  Planeta.vazio()
      : id = null,
        nome = '',
        tamanho = 0.0,
        distancia = 0.0,
        apelido = '';

        // Método para criar objeto a partir do mapa
  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distancia: map['distancia'],
      apelido: map['apelido'],
    );
  }

  // Método para converter objeto em mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
    };
  }
}