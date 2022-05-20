class payment {
  final String no;
  final String name;
  final String id;
  final String payment_date;
  final String route;
  final String Email;
  final String approval;

  payment(this.no, this.name, this.id, this.payment_date, this.route,
      this.Email, this.approval);
}

final allPAYMENTS = <payment>[
  payment('1', 'ahmed', '202000333', '3/10/2022', 'r1', '@zewailcity.edu.eg',
      'true'),
  payment('2', 'mona', '202000345', '9/1/2022', 'r5', '@zewailcity.edu.eg',
      'false'),
];

class Bus {
  final String Route;
  final String Bus_no;
  final String Capacity;
  final String DriverName;
  final String Driver_contact;
  final String Select;

  Bus(this.Route, this.Bus_no, this.Capacity, this.DriverName,
      this.Driver_contact, this.Select);
}

final allBUSES = <Bus>[
  Bus('r1', '234FGK', '40', 'Ali', '0104444', 'true'),
  Bus('r2', '234FGK', '35', 'MMohamed', '0105555', 'false'),
];
