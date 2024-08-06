
import '../core/contants/api.dart';

import '../core/class/crud.dart';

class DriversCategoriesData{
  Crud crud;
  DriversCategoriesData(this.crud);

  getDriversCategoryData(categoryId,lat,long)async{
    var response = await crud.getData(driversCategory(categoryId,lat,long));
    return response.fold((left) => left, (right) => right);
  }
}