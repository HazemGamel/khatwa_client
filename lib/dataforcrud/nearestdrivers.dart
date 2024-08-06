


import '../core/class/crud.dart';
import '../core/contants/api.dart';

class NearestDriversData{
  Crud crud;
  NearestDriversData(this.crud);
  postData(lan,log,categoryid)
  async{
    var response = await crud.getData(getdrivers(lan,log,categoryid));
    return response.fold((left) {
    }, (right) => right);
  }

}