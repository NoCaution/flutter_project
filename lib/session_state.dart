

abstract class SessionState{}

class UnknownMainScreenState extends SessionState{}

class Authenticated extends SessionState{
  Authenticated();
}

class UnAuthenticated extends SessionState{}