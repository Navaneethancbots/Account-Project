class Accounts {
  String? id;
  String? masterName;
  String? masterUOM;
  String? masterDescription;
  String? equityDate;
  double? equityAmount;
  String? equityDescription;
  String? expenseSelectItem;
  String? expenseMeasure;
  double? expenseTotalAmount;
  double? expenseAmount;
  String? expenseUOM;
  String? expenseDate;

  Accounts({
    this.id,
    this.masterName,
    this.masterUOM,
    this.masterDescription,
    this.equityDate,
    this.equityDescription,
    this.equityAmount,
    this.expenseSelectItem,
    this.expenseMeasure,
    this.expenseTotalAmount,
    this.expenseAmount,
    this.expenseUOM,
    this.expenseDate,
  });

  Map<String, dynamic> Master() => {
        'id': id,
        'masterName': masterName,
        'masterUOM': masterUOM,
        'masterDescription': masterDescription,
      };

  Map<String, dynamic> equity() => {
        'id': id,
        'equityDate': equityDate,
        'equityAmount': equityAmount,
        'equityDescription': equityDescription,
      };

  Map<String, dynamic> Expense() => {
        'id': id,
        'expenseSelectItem': expenseSelectItem,
        'expenseMeasure': expenseMeasure,
        'expenseTotalAmount': expenseTotalAmount,
        'expenseAmount': expenseAmount,
        //'expenseUOM': expenseUOM,
        'expenseDate': expenseDate,
      };

  static Accounts fromJson(Map<String, dynamic> json) => Accounts(
        id: json['id'],
        masterName: json['masterName'],
        masterUOM: json['masterUOM'],
        masterDescription: json['masterDescription'],
        equityDate: json['equityDate'],
        equityDescription: json['equityDescription'],
        equityAmount: json['equityAmount'],
        expenseSelectItem: json['expenseSelectItem'],
        expenseMeasure: json['expenseMeasure'],
        expenseTotalAmount: json['expenseTotalAmount'],
        expenseAmount: json['expenseAmount'],
        expenseUOM: json['expenseUOM'],
        expenseDate: json['expenseDate'],
      );
}
