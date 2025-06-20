import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';

class UserService {
  
  Future<void> saveUserToDB({
    required String name,
    required String email,
  }) async {
    const String mutation = '''
      mutation CreateUser(\$name: String!, \$email: String!) {
        createUser(input: {name: \$name, email: \$email}) {
          id
          name
          email
        }
      }
    ''';

    try {
      final request = GraphQLRequest<String>(
        document: mutation,
        variables: {
          'name': name,
          'email': email,
        },
      );

      final response = await Amplify.API.mutate(request: request).response;

      if (response.errors.isNotEmpty) {
        safePrint("GraphQL Error: \${response.errors}");
        throw Exception("Failed to save user to DB");
      } else {
        safePrint("User saved successfully: \${response.data}");
      }
    } catch (e) {
      safePrint("Save User Error: \$e");
      rethrow;
    }
  }
 
  Future<List<Map<String, dynamic>>> getAllUsers() async {
  const String query = '''
    query ListUsers {
      listUsers {
        items {
          id
          name
          email
        }
      }
    }
  ''';

  try {
    final request = GraphQLRequest<String>(document: query);
    final response = await Amplify.API.query(request: request).response;

    if (response.errors.isNotEmpty) {
      safePrint("GraphQL Error: ${response.errors}");
      throw Exception("Failed to fetch users");
    }

    final data = response.data;
    if (data == null) throw Exception("No data returned from GraphQL");
    

    final decoded = jsonDecode(data) as Map<String, dynamic>;
    final users = decoded['listUsers']['items'] as List<dynamic>;

    return users.map((u) => Map<String, dynamic>.from(u)).toList();
  } catch (e) {
    safePrint("Fetch Users Error: $e");
    rethrow;
  }
}

}
