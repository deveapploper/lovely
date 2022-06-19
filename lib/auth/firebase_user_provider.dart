import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MuseumFirebaseUser {
  MuseumFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MuseumFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MuseumFirebaseUser> museumFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MuseumFirebaseUser>((user) => currentUser = MuseumFirebaseUser(user));
