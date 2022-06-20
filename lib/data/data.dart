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

  Bus(this.Route, this.Bus_no, this.Capacity, this.DriverName,
      this.Driver_contact);
}

final allBUSES = <Bus>[
  Bus('r1', '234FGK', '40', 'Ali', '01044444444'),
  Bus('r2', '234FGK', '35', 'Mohamed', '01055555555'),
];

class Passenger {
  final String no;
  final String Name;
  final String Id;
  final String Email;
  final String Pickup_point;
  final String Passenger_contact;
  final String Emergency_contact;
  final String Route;

  Passenger(this.no, this.Name, this.Id, this.Email, this.Pickup_point,
      this.Passenger_contact, this.Emergency_contact, this.Route);
}

final allPASSENGERS = <Passenger>[
  Passenger('1', 'ahmed', '202000333', 'ahmed@zewailcity.edu.eg', 'point1',
      '01022222222', '01066666666', 'r1'),
  Passenger('2', 'mona', '202000345', 'mona@zewailcity.edu.eg', 'point2',
      '01033333333', '01077777777', 'r2'),
];

class Maintenance {
  final String Id;
  final String Bus_no;
  final String start_date;
  final String end_date;

  Maintenance(
    this.Id,
    this.Bus_no,
    this.start_date,
    this.end_date,
  );
}

final allmaintenenance = <Maintenance>[
  Maintenance('r1', '234FGK', '9-10-2021', '10-10-2021'),
  Maintenance('r2', '234FGK', '4-6-2022', '5-6-2022'),
];
