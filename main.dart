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
  'burger': 450,
  'pasta': 350,
  'salad': 250,
};

// List to store customer orders
Map<String, List<String>> customerOrders = {};

void displayMenu() {
  print('--- Menu ---');
  menu.forEach((item, price) {
    print('$item: \RS:${price.toStringAsFixed(2)}');
  });
  print('------------');
}

List<String> takeOrder(String customerName) {
  List<String> order = [];
  String item;
  do {
    displayMenu();
    print("Enter an item to order (or 'done' to finish): ");
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

void createUser(List<Map<String, String>> users) {
  stdout.write('Enter your desired username: ');
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

void viewCustomerOrders() {
  print('--- Customer Orders ---');
  customerOrders.forEach((customer, order) {
    print('$customer: ${order.join(', ')}');
  });
  print('-----------------------');
}

void managerLogin(List<Map<String, String>> users) {
  print('Enter username: ');
  String username = stdin.readLineSync()!;
  print('Enter password: ');
  String password = stdin.readLineSync()!;

  bool isLoggedIn = users.any((user) => user['username'] == username && user['password'] == password);
  if (isLoggedIn) {
    print('Logged in as a manager.');
    viewCustomerOrders();
  } else {
    print('Invalid credentials.');
  }
}

void customerLogin(List<Map<String, String>> users) {
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

      List<String> order = takeOrder(username);
      double total = calculateTotal(order);

      print('Order details: ${order.join(', ')}');
      print('Total: \Rs:${total.toStringAsFixed(2)}');
    } else {
      print('Invalid credentials.');
    }
  } else if (customerOption == 2) {
    createUser(users);
  } else {
    print('Invalid option.');
  }
}
