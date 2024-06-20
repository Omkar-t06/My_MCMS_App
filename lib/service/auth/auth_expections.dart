//login exceptions
class UserNotFoundException implements Exception {}

class WrongPasswordException implements Exception {}

//registration exceptions
class EmailAlreadyInUseException implements Exception {}

class InvalidEmailException implements Exception {}

class WeakPasswordException implements Exception {}

//Phone number exceptions
class InvalidPhoneNumberException implements Exception {}

class InvalidVerificationCodeException implements Exception {}

class NetworkRequestFailureException implements Exception {}

//generic exceptions
class GenericException implements Exception {}

class UserNotLoggedInAuthExpection implements Exception {}
