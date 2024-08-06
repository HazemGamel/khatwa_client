
import '../core/contants/api.dart';

import '../core/class/crud.dart';

class MainViewData{
  Crud crud;
  MainViewData(this.crud);

  getData()async{
    var response = await crud.getData(mainviewbanners);
    return response.fold((left) => left, (right) => right);
  }

  getCategoryData()async{
    var response = await crud.getData(mainviewcategories);
    return response.fold((left) => left, (right) => right);
  }
}