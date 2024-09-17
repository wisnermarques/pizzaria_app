class Pizza {
  final int id;
  final String nome;
  final String descricao;
  final double preco;

  Pizza(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.preco});

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: double.parse(json['preco']),
    );
  }
}
