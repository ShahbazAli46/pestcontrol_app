import 'package:accurate/jsonModels/UserDetails.dart';

class DocumentStatus {
  final String name;
  String status;
  DateTime? startDate;
  DateTime? expiryDate;
  Documents? uploadedDoc;

  DocumentStatus({
    required this.name,
    this.status = 'missing',
    this.startDate,
    this.expiryDate,
    this.uploadedDoc,
  });

  // Helper method to calculate days until expiry
  int? getDaysUntilExpiry() {
    if (expiryDate == null) return null;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  // Helper method to check if document is expired
  bool get isExpired {
    if (expiryDate == null) return false;
    return expiryDate!.isBefore(DateTime.now());
  }
}

class DocumentProcessor {
  static List<DocumentStatus> processDocuments(
      List<String> requiredDocs,
      List<Documents> uploadedDocs,
      ) {
    // Create initial DocumentStatus list from required docs
    List<DocumentStatus> docStatuses = requiredDocs.map((name) {
      return DocumentStatus(name: name);
    }).toList();

    // Update statuses from uploaded documents
    for (var docStatus in docStatuses) {
      // Find matching uploaded document
      final uploadedDoc = uploadedDocs.firstWhere(
            (doc) => doc.name?.toLowerCase() == docStatus.name.toLowerCase(),
        orElse: () => Documents(),
      );

      // If matching document found, update status
      if (uploadedDoc.name != null) {
        docStatus.status = uploadedDoc.status ?? 'missing';
        docStatus.uploadedDoc = uploadedDoc;

        // Parse start date if available
        if (uploadedDoc.start != null && uploadedDoc.start!.isNotEmpty) {
          try {
            docStatus.startDate = DateTime.parse(uploadedDoc.start!);
          } catch (e) {
            print('Error parsing start date: $e');
          }
        }

        // Parse expiry date if available
        if (uploadedDoc.expiry != null && uploadedDoc.expiry!.isNotEmpty) {
          try {
            docStatus.expiryDate = DateTime.parse(uploadedDoc.expiry!);
          } catch (e) {
            print('Error parsing expiry date: $e');
          }
        }
      }
    }

    // Sort documents
    return _sortDocuments(docStatuses);
  }

  static List<DocumentStatus> _sortDocuments(List<DocumentStatus> documents) {
    documents.sort((a, b) {
      // First priority: Documents with expiry dates
      if (a.expiryDate != null && b.expiryDate == null) return -1;
      if (a.expiryDate == null && b.expiryDate != null) return 1;
      if (a.expiryDate == null && b.expiryDate == null) {
        // If neither has expiry date, sort by status
        if (a.status == 'missing' && b.status != 'missing') return -1;
        if (a.status != 'missing' && b.status == 'missing') return 1;
        return 0;
      }

      // Both have expiry dates
      return a.expiryDate!.compareTo(b.expiryDate!);
    });

    return documents;
  }
}