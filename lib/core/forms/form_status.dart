/// Generic submission status for form-backed cubits. Reused across features so
/// every form speaks the same state language.
enum FormStatus {
  initial,
  submitting,
  success,
  failure;

  bool get isSubmitting => this == FormStatus.submitting;
  bool get isSuccess => this == FormStatus.success;
  bool get isFailure => this == FormStatus.failure;
}
