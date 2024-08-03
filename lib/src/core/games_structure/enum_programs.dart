enum ProgramsForStudents { arabic, phonics, math }

extension ProgramsForStudentsTypes on ProgramsForStudents {
  String text() {
    switch (this) {
      case ProgramsForStudents.math:
        return "math".toLowerCase();
      case ProgramsForStudents.phonics:
        return "Phonics".toLowerCase();
      case ProgramsForStudents.arabic:
        return "Arabic".toLowerCase();
    }
  }
}
