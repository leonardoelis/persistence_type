import 'package:floor/floor.dart';

import '../models/book.dart';

@dao
abstract class BookDAO{
  
  @Query("SELECT * FROM Book")
  Future<List<Book>> findAll();

  @insert
  Future<int> insertBook(Book book);

  @delete
  Future<int> deleteBook(Book book);
}