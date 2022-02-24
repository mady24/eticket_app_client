class Ticket {
  final int IDTicket;
  final String DateTicket;
  final int numero;
  final bool scheduled;
  final String NomAgence;
  final String Address;
  final String Phone;
  final String NomBank;
  final String ImageBank;
  final String NomRegion;
  final int IDFile;
  final int count;
  final bool Statut;

  const Ticket(
      {required this.IDTicket,
      required this.DateTicket,
      required this.numero,
      required this.scheduled,
      required this.NomAgence,
      required this.Address,
      required this.Phone,
      required this.NomBank,
      required this.ImageBank,
      required this.NomRegion,
      required this.IDFile,
      required this.count,
      required this.Statut});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        IDTicket: json['idTicket'],
        DateTicket: json['dateTicket'],
        numero: json['numero'],
        scheduled: json['scheduled'],
        NomAgence: json['nomAgence'],
        Address: json['address'],
        Phone: json['phone'],
        NomBank: json['nomBank'],
        ImageBank: json['imageBank'],
        NomRegion: json['nomRegion'],
        IDFile: json['idFile'],
        count: json['count'],
        Statut: json['Statut']);
  }
}
