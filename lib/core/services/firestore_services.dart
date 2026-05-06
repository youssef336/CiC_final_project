import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysterybag/core/services/database_servies.dart';

class FirestoreServices implements DatabaseServies {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? docuementId,
    Map<String, dynamic>? query,
  }) async {
    print('🔥 FirestoreServices.getData: path=$path, query=$query');

    if (docuementId != null) {
      var data = await firestore.collection(path).doc(docuementId).get();
      return data.data();
    }

    // Special handling for products - they're stored as arrays inside restaurant documents
    if (path == 'products') {
      print('🔥 Fetching products from resturants collection');
      try {
        // Check if filtering by restaurantId
        String? filterRestaurantId;
        if (query != null && query['restaurantId'] != null) {
          filterRestaurantId = query['restaurantId'] as String;
          print('🔥 Filtering by restaurantId: $filterRestaurantId');
        }

        late final QuerySnapshot<Map<String, dynamic>> restaurantsSnapshot;
        if (filterRestaurantId != null) {
          // Fetch specific restaurant only
          restaurantsSnapshot = await firestore
              .collection('resturants')
              .where(FieldPath.documentId, isEqualTo: filterRestaurantId)
              .get();
        } else {
          // Fetch all restaurants
          restaurantsSnapshot = await firestore.collection('resturants').get();
        }

        print('🔥 Found ${restaurantsSnapshot.docs.length} restaurants');

        List<Map<String, dynamic>> allProducts = [];

        for (var restaurantDoc in restaurantsSnapshot.docs) {
          final restaurantData = restaurantDoc.data();
          final restaurantId = restaurantDoc.id;
          final restaurantName = restaurantData['name'] ?? 'Unknown';

          // Extract products array from restaurant document
          final productsArray =
              restaurantData['products'] as List<dynamic>? ?? [];
          print(
            '🔥 Restaurant "$restaurantName" has ${productsArray.length} products',
          );

          // Convert each product to a map and add restaurantId and restaurantName
          for (var product in productsArray) {
            if (product is Map<String, dynamic>) {
              final productWithMeta = {
                ...product,
                'documentId':
                    product['docId'] ??
                    product['productId'] ??
                    product['documentId'] ??
                    '${restaurantId}_${product['title'] ?? product['nameEn']}',
                'restaurantId': restaurantId,
                'restaurantName': restaurantName,
              };
              allProducts.add(productWithMeta);
            }
          }
        }

        print('🔥 Total products extracted: ${allProducts.length}');

        // Apply query filters if provided
        if (query != null) {
          if (query['limit'] != null) {
            final limit = query['limit'] as int;
            allProducts = allProducts.take(limit).toList();
            print('🔥 Applied limit: $limit');
          }
          if (query['orderBy'] != null && query['orderBy'] == 'sellingCount') {
            allProducts.sort((a, b) {
              final aCount = (a['sellingCount'] as num?)?.toInt() ?? 0;
              final bCount = (b['sellingCount'] as num?)?.toInt() ?? 0;
              return bCount.compareTo(aCount); // Descending
            });
            print('🔥 Sorted by sellingCount');
          }
        }

        return allProducts;
      } catch (e, st) {
        print('🔥 Error fetching products from restaurants: $e\n$st');
        return [];
      }
    }

    // Handle regular collections
    Query<Map<String, dynamic>> data;

    if (path.contains('/')) {
      final parts = path.split('/');
      print('🔥 Path contains /, parts: $parts');
      if (parts.length == 3) {
        print(
          '🔥 Creating nested query: ${parts[0]} -> ${parts[1]} -> ${parts[2]}',
        );
        data = firestore
            .collection(parts[0])
            .doc(parts[1])
            .collection(parts[2]);
      } else {
        print('🔥 Parts length != 3, using regular collection');
        data = firestore.collection(path);
      }
    } else {
      print('🔥 Path does not contain /, using regular collection: $path');
      data = firestore.collection(path);
    }

    if (query != null) {
      if (query['where'] != null) {
        final whereClause = query['where'];
        if (whereClause is Map<String, dynamic>) {
          whereClause.forEach((field, value) {
            data = data.where(field, isEqualTo: value);
          });
        }
      }
      if (query['orderBy'] != null) {
        var orderByField = query['orderBy'];
        var descending = query['descending'];
        data = data.orderBy(orderByField, descending: descending);
      }
      if (query['limit'] != null) {
        var limit = query['limit'];
        data = data.limit(limit);
      }
    }

    var result = await data.get();
    print('🔥 Query returned ${result.docs.length} documents');
    return result.docs.map((e) => {...e.data(), 'documentId': e.id}).toList();
  }

  @override
  Future<bool> checkifDataExists({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }
}
