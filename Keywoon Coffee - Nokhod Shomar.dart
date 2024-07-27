import 'dart:async';
import 'dart:io';
//.START
Map<String, Map<String, dynamic>> players = {};

void addPlayer(String name, int speed) {
  int entryTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  players[name] = {
    'speed': speed,
    'totalChickpeas': 0,
    'entryTime': entryTime,
    'secondsSpent': 0,
  };
  print('$name dare nokhod mikhore ==>> ba in sorat $speed');
}

void removePlayer(String name) {
  if (players.containsKey(name)) {
    int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int cost = calculateCost(name, currentTime);
    print('$name bayad $cost bede');
    players.remove(name);
  } else {
    print('Player $name not found');
  }
}

void showStatus() {
  if (players.isEmpty) {
    print('Hichkas Nist Kio Neshon Bedam??:|');
  } else {
    players.forEach((name, player) {
      print('$name  ${player['totalChickpeas']} khorde ');
    });
  }
}

void closeShop() {
  int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  int totalIncome = 0;

  if (players.isEmpty) {
    print('Hichkas Nist Kio Neshon Bedam??:|');
  } else {
    players.forEach((name, player) {
      int cost = calculateCost(name, currentTime);
      print('$name Bayad $cost Bede');
      totalIncome += cost;
    });
  }

  print('Total income: $totalIncome');
}

int calculateCost(String name, int currentTime) {
  var player = players[name]!;
  int chickpeaCost = player['totalChickpeas'] * 100;
  int stayDuration = (currentTime - player['entryTime']).toInt();
  int stayCost = stayDuration * 10;
  return chickpeaCost + stayCost;
}

Future<void> startEating() async {
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    players.forEach((name, player) {
      player['secondsSpent'] += 1;
      if (player['secondsSpent'] % player['speed'] == 0) {
        player['totalChickpeas'] += 1;
      }
    });
  }
}
//دارم چیکار میکنم:||||
void main() async {
  startEating();

  while (true) {
    print('Enter Dastoor:');
    String? command = stdin.readLineSync();

    if (command == null) {
      print('Error: No input provided');
      continue;
    }

    command = command.trim();

    if (command.startsWith('Name:')) {
      try {
        var parts = command.split(',');
        var namePart = parts[0].split(':');
        var speedPart = parts[1].split(':');

        String name = namePart[1].trim();
        int speed = int.parse(speedPart[1].trim());

        addPlayer(name, speed);
      } catch (e) {
        print('Injoori Bayad Vred Kni "Name:n ,speed:s"');
      }
    } else if (command.startsWith('Exit Name:')) {
      try {
        var namePart = command.split(':');
        String name = namePart[1].trim();
        removePlayer(name);
      } catch (e) {
        print('Injoori Bayad Vred Kni "Name:n ,speed:s"');
      }
    } else if (command == 'Show') {
      showStatus();
    } else if (command == 'Close') {
      closeShop();
      break;
    } else {
      print('Show: Namayesh total / Close : Bastane Coffee ');
    }
  }
}
//THE END...