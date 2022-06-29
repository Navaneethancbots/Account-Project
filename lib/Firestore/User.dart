class User {
  String? id;
  String? expenseName;
  String? Mesure;
  String? decription;
  String? date;
  String? totalAmount;
  String? descpEquity;
  String? selectItem;
  String? measurement;
  String? Amount;

  User({
    this.id,
    this.expenseName,
    this.Mesure,
    this.decription,
    this.date,
    this.descpEquity,
    this.totalAmount,
    this.selectItem,
    this.measurement,
    this.Amount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'expenseName': expenseName,
        'Mesure': Mesure,
        'decription': decription,
      };

  Map<String, dynamic> equity() => {
        'id': id,
        'date': date,
        'totalAmount': totalAmount,
        'descpEquity': descpEquity,
      };

  Map<String, dynamic> Expense() => {
    'id': id,
    'selectItem': selectItem,
    'measurement': measurement,
    'Amount': Amount,
  };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        expenseName: json['expenseName'],
        Mesure: json['Mesure'],
        decription: json['decription'],
        date: json['date'],
        descpEquity: json['descpEquity'],
        totalAmount: json['totalAmount'],
        selectItem: json['selectItem'],
        measurement: json['measurement'],
        Amount: json['Amount'],
      );
}
