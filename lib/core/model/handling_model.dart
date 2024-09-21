
class ResultModel {}

class ExceptionModel extends ResultModel{}

class Litsof<T> extends ResultModel{
  List<T> listOfData;
  Litsof({
    required this.listOfData,
  });
}
class DataSuccess extends ResultModel {}