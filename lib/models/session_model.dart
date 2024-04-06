class SessionModel {
  final String sessionId;

  SessionModel({required this.sessionId});

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    print('\n_________________________\n');
    print('\nHasta aqui va bien el session id es $map \n');
    print('\n_________________________\n');
    return SessionModel(
      sessionId: map['session_id'],
    );
  }
}
