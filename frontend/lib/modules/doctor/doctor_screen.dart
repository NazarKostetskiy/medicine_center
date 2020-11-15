import 'package:flutter/material.dart';
import 'package:medecine_app/ui/appbar/base_appbar.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildDoctorHeadInfo(context),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Dr. Stefeni Albert is a cardiologist in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              buildAddress(context),
              buildActivityLayout(context)
            ],
          ),
        ),
      ),
    );
  }

  Column buildActivityLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Activity",
          style: TextStyle(
            color: Color(0xff242424),
            fontSize: 28,
          ),
        ),
        SizedBox(
          height: 22,
        ),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(0xFF73AEF5),
            child: new InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => print("tapped"),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(144, 202, 249, 1),
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(Icons.list_alt)),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "List of Schedules",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
            )),
        // ),
        SizedBox(
          width: 16,
        ),
        //   child:
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(0xFF73AEF5),
            child: new InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => print("tapped"),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(144, 202, 249, 1),
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(Icons.list_alt)),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Doctor's Daily Post",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
            )),
        // )
      ],
    );
  }

  Row buildAddress(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // Image.asset("assets/mappin.png"),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: [
                      Text(
                        "Hospital",
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.7),
                            fontSize: 20),
                      ),
                      Icon(Icons.location_city),
                      SizedBox(
                        width: 15,
                      ),
                    ]),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 268,
                        child: Text(
                          "Hospital №4, Solomyantska street 16, Kyiv",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
//
          ],
        ),
        Image.asset(
          "assets/map.png",
          width: 180,
        )
      ],
    );
  }

  Row buildDoctorHeadInfo(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Image.asset(
          "assets/doctor_pic3.png",
          // height: 220,
          // width: 150,
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Dr. Stefeni Albert",
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  "Heart Speailist",
                  style: TextStyle(fontSize: 19, color: Colors.grey),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    IconTile(
                      backColor: Color.fromRGBO(144, 202, 249, 1),
                      iconButton: IconButton(
                          icon: Icon(Icons.email),
                          onPressed: () => print('pressed mail')),
                    ),
                    IconTile(
                      backColor: Color(0xFF73AEF5),
                      iconButton: IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () => print('pressed call')),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class IconTile extends StatelessWidget {
  final IconButton iconButton;
  final Color backColor;

  IconTile({this.iconButton, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(15)),
          child: iconButton),
    );
  }
}
