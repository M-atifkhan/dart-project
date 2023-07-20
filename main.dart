import 'dart:io';
void main() {
  
  List<Map<String, String>> registeredUsers = [
    {'username': 'manager', 'password': '123456'},
    {'username': 'atif', 'password': '123456'},
    {'username': 'imran', 'password': '123456'},
    {'username': 'bilal', 'password': '123456'},
    {'username': 'tabeer', 'password': '123456'},
  ];
  print('*** Welcome to the Restaurant ***');
  bool exitIs = false;
  while (!exitIs) {
    print('Press 1: Login as a manager');
    print('Press 2: Login as a customer');
    print('Press 3: Exit');
    int userType = int.parse(stdin.readLineSync()!);
    if (userType == 1) {
      managerLogin(registeredUsers);
    } else if (userType == 2) {
      customerLogin(registeredUsers);
    } else if (userType == 3) {
      exitIs = true;
    } else {
      print('Invalid user type.');
    }
  }
}

// List of menu items and their prices
Map<String, double> menu = {
  'pizza': 500,
  'burger':450,
  'pasta': 350,
  'salad': 250,
};

// List to store customer orders
Map<String, List<String>> customerOrders = {};

displayMenu() {
  print('--- Menu ---');
  menu.forEach((item, price) {
    print('$item: \RS:${price}');
  });
  print('------------');
}

List<String> takeOrder(String customerName) {
  List<String> order = [];
  String item;
  do {
    displayMenu();
    print("Enter an item to order (enter done to finish): ");
    item = stdin.readLineSync()!;

    if (item != 'done' && menu.containsKey(item)) {
      order.add(item);
    } else if (item != 'done') {
      print('Invalid item! Please try again.');
    }
  } while (item != 'done');

  customerOrders[customerName] = order;
  print("Your order will be served in 30 to 45 mins");
  return order;
}

double calculateTotal(List<String> order) {
  double total = 0;
  for (var item in order) {
    total += menu[item]!;
  }
  return total;
}

createUser(List<Map<String, String>> users) {
  stdout.write('Enter your name: ');
  String username = stdin.readLineSync()!;

  bool isUsernameTaken = users.any((user) => user['username'] == username);
  if (isUsernameTaken) {
    print('Username already taken. Please choose a different username.');
    return;
  }

  stdout.write('Enter your password: ');
  String password = stdin.readLineSync()!;
  users.add({'username': username, 'password': password});
  print('User created successfully. Welcome, $username');
}

viewCustomerOrders() {
  print('--- Customer Orders ---');
  customerOrders.forEach((customer, order) {
    print('$customer: ${order.join(', ')}');
  });
  print('-----------------------');
}
addMenu(){
print('Enter the name of the new item: ');
  String itemName = stdin.readLineSync()!;
  print('Enter the price of $itemName: ');
  double itemPrice = double.parse(stdin.readLineSync()!);

  menu[itemName] = itemPrice;
  print('New item added to the menu: $itemName - \RS:$itemPrice');
}

managerLogin(List<Map<String, String>> users) {
  print('Enter username: ');
  String username = stdin.readLineSync()!;
  print('Enter password: ');
  String password = stdin.readLineSync()!;

  bool isLoggedIn = users.any((user) => user['username'] == username && user['password'] == password);
  if (isLoggedIn) {
    print('Logged in as a manager.');
    bool isDOne = true;
    while (isDOne == true) {
    print('Press 1: View Customer Order');
    print('Press 2: Add Menu');
    print('Press 3: logout');
    int managerOption = int.parse(stdin.readLineSync()!);
    if (managerOption == 1) {
      viewCustomerOrders();
    }else if (managerOption == 2){
       addMenu();
    }else if (managerOption == 3){
      isDOne = false;
    }else{
      print("Invalid");
    }
    }
    
  } else {
    print('Invalid credentials.');
  }
}

customerLogin(List<Map<String, String>> users) {
  print('Press 1: Existing Customer');
  print('Press 2: New Customer');
  int customerOption = int.parse(stdin.readLineSync()!);

  if (customerOption == 1) {
    print('Enter username: ');
    String username = stdin.readLineSync()!;
    print('Enter password: ');
    String password = stdin.readLineSync()!;

    bool isLoggedIn = users.any((user) => user['username'] == username && user['password'] == password);
    if (isLoggedIn) {
      print('Logged in as a customer.');
      print('Select an option: ');
      print('Press 1: Dine-in');
      print('Press 2: Takeaway');
      print('Press 3: Delivery');
      int option = int.parse(stdin.readLineSync()!);
      option;
      List<String> order = takeOrder(username);
      double total = calculateTotal(order);

      print('Order details: ${order.join(', ')}');
      print('Total: \ ${total}rs');
    } else {
      print('Invalid credentials.');
    }
  } else if (customerOption == 2) {
    createUser(users);
  } else {
    print('Invalid option.');
  }
}
