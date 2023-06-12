import 'package:flutter/cupertino.dart';
import 'package:sekolahku/model/item_detail.dart';

import '../res/dimen_res.dart';
import '../res/string_res.dart';

class ItemDetailView extends StatelessWidget {

  final ItemDetail itemDetail;

  const ItemDetailView({super.key, required this.itemDetail});

  @override
  Widget build(BuildContext context) {
    var value1 = itemDetail.data1;
    var value2 = itemDetail.data2;
    var valueToShow = StringRes.notRecorded;
    if(value1 == null) {
      value1 = valueToShow;
    }

    if(value2 == null) {
      value2 = valueToShow;
    }
    return Padding(
        padding: EdgeInsets.all(DimenRes.size_25),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(itemDetail.iconData,size: DimenRes.size_50),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(value1), Text(value2)],),),
            ]
        )
    );
  }


}