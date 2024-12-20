class TypesOfVisit {
  String visitTitle;
  var isSelect = false;

  TypesOfVisit({required this.visitTitle, this.isSelect = false});
  TypesOfVisit.empty() : visitTitle = '', isSelect = false;
  static List<TypesOfVisit> visits = [
    TypesOfVisit(visitTitle: 'Regular Treatment'),
    TypesOfVisit(visitTitle: 'Inspection Visit'),
    TypesOfVisit(visitTitle: 'Complaint'),
    TypesOfVisit(visitTitle: 'One time (T)'),
  ];

  static void selectVisit(int index) {
    for (int i = 0; i < visits.length; i++) {
      visits[i].isSelect = i == index;
    }
  }
}