class Bank {
  final int IDBank;
  final String NomBank;
  final String Image;

  const Bank({
    required this.IDBank,
    required this.NomBank,
    required this.Image,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return  Bank(
      IDBank: json['idBank'],
      NomBank: json['nomBank'],
      Image: json['image'],
    );
  }
}
