import 'package:petamin_repository/petamin_repository.dart';

class UserPagination {
  List<Profile> users;
  PaginationData pagination;

  UserPagination({
    required this.users,
    required this.pagination,
  });
}