enum ProgramsNameWillRTL { arabic }

extension TypeExtensionProgramsNameWillRTL on ProgramsNameWillRTL {
  String text() {
    switch (this) {
      case ProgramsNameWillRTL.arabic:
        return "Arabic".toLowerCase();
    }
  }
}