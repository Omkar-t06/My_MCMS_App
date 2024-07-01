class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateUserException extends CloudStorageException {}

class CouldNotCreateComplaintException extends CloudStorageException {}

class CouldNotGetUserException extends CloudStorageException {}

class CouldNotGetAllComplaintException extends CloudStorageException {}

class CouldNotUpdateUserException extends CloudStorageException {}

class CouldNotUpdateComplaintException extends CloudStorageException {}

class CouldNotDeleteUserException extends CloudStorageException {}

class CouldNotDeleteComplaintException extends CloudStorageException {}

class ComplaintNotFoundException extends CloudStorageException {}
