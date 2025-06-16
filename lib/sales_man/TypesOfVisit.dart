class TypesOfVisit {
  String visitTitle;
  var isSelect = false;

  TypesOfVisit({required this.visitTitle, this.isSelect = false});
  TypesOfVisit.empty() : visitTitle = '', isSelect = false;
  static List<TypesOfVisit> visits = [
    TypesOfVisit(visitTitle: 'Regular Treatment (Contract)'),
    TypesOfVisit(visitTitle: 'Inspection Visit (Contract)'),
    TypesOfVisit(visitTitle: 'Complaint Visit (Contract)'),
    TypesOfVisit(visitTitle: 'One-Off Treatment'),
    TypesOfVisit(visitTitle: 'Complaint Visit (One-Off)'),
  ];

  static void selectVisit(int index) {
    for (int i = 0; i < visits.length; i++) {
      visits[i].isSelect = i == index;
    }
  }
}