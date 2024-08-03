enum LevelsForStudents { ec1, ec2, ec3 }

extension LevelsForStudentsTypes on LevelsForStudents {
  String text() {
    switch (this) {
      case LevelsForStudents.ec1:
        return "EC1".toLowerCase();
      case LevelsForStudents.ec2:
        return "EC2".toLowerCase();
      case LevelsForStudents.ec3:
        return "EC3".toLowerCase();
    }
  }
}
