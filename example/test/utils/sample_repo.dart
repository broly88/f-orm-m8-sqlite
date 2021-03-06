import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:sqlite_m8_demo/models/to_do.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

GymLocationProxy gymLocationProxySample01 = GymLocationProxy()
  ..id = 1
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
  ..rating = 5
  ..description = "silva";

GymLocationProxy gymLocationProxySample02 = GymLocationProxy()
  ..id = 2
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763031)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763032)
  ..rating = 2
  ..description = "montis";

HealthEntryProxy healthEntryProxySample01 = HealthEntryProxy()
  ..id = 1
  ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763046)
  ..accountId = 2
  ..description = "happy"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763047)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763048);

HealthEntryProxy healthEntryProxySample02 = HealthEntryProxy()
  ..id = 2
  ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763042)
  ..accountId = 2
  ..description = "healthy"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763043)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763044);

ReceiptProxy receiptNewProbe = ReceiptProxy()
  ..id = 1
  ..isBio = false
  ..expirationDate = DateTime.fromMillisecondsSinceEpoch(2889787803000)
  ..quantity = 1.618
  ..numberOfItems = 42
  ..storageTemperature = -38.83
  ..description = "Happiness"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
  ..decomposingDuration = Duration(milliseconds: 123456789)
  ..numberOfMolecules = BigInt.from(987654321);

ReceiptProxy receiptUpdateProbe = ReceiptProxy()
  ..id = 1
  ..isBio = true
  ..expirationDate = DateTime.fromMillisecondsSinceEpoch(3205320603000)
  ..quantity = 3.1415
  ..numberOfItems = 44
  ..storageTemperature = 106
  ..description = "Happiness forever"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
  ..decomposingDuration = Duration(milliseconds: 123456788)
  ..numberOfMolecules = BigInt.from(987654322);

ReceiptProxy receiptProxySample01 = ReceiptProxy()
  ..id = 1
  ..isBio = true
  ..expirationDate = DateTime.fromMillisecondsSinceEpoch(1557701763036)
  ..quantity = 3.1415
  ..numberOfItems = 44
  ..storageTemperature = 106
  ..description = "Happiness forever"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
  ..decomposingDuration = Duration(milliseconds: 123456789)
  ..numberOfMolecules = BigInt.from(987654321);

ReceiptProxy receiptProxySample02 = ReceiptProxy()
  ..id = 2
  ..isBio = false
  ..expirationDate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..quantity = 1.41
  ..numberOfItems = 13
  ..storageTemperature = -38
  ..description = "Joy forever"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..decomposingDuration = Duration(milliseconds: 123000789)
  ..numberOfMolecules = BigInt.from(987000321);

var receiptMapSample01 = {
  "id": 1,
  "is_bio": 1,
  "expiration_date": 1557701763036,
  "quantity": 3.1415,
  "number_of_items": 44,
  "storage_temperature": 106,
  "description": "Happiness forever",
  "date_create": 1557701763037,
  "date_update": 1557701763038,
  "decomposing_duration": 123456789,
  "number_of_molecules": '987654321'
};

ToDoProxy toDoProxySample01 = ToDoProxy()
  ..id = 1
  ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763036)
  ..accountId = 2
  ..description = "handy"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
  ..dateDelete = DateTime.fromMillisecondsSinceEpoch(1557701763039);

ToDoProxy toDoProxySample02 = ToDoProxy()
  ..id = 2
  ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763032)
  ..accountId = 2
  ..description = "heavy"
  ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
  ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763033)
  ..dateDelete = DateTime.fromMillisecondsSinceEpoch(1557701763034);

UserAccountProxy userAccountProxySample01 = UserAccountProxy()
  ..id = 1
  ..email = "john@doe.com"
  ..abbreviation = "JD"
  ..description = "Tester John"
  ..userName = "John Doe"
  ..isCurrent = true;

UserAccountProxy userAccountProxySample02 = UserAccountProxy()
  ..id = 1
  ..email = "john@doe.com"
  ..abbreviation = "JD"
  ..description = "Tester John"
  ..userName = "John Doe"
  ..isCurrent = true;
