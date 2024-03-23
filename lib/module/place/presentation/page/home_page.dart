import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
      ),
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.width * 0.05,
                  bottom: screenSize.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(width: 10,),
                        Text(
                          "Hi, nockerox!",
                          style: theme.textTheme.titleMedium,
                        )
                      ],
                    ),
                    Switch(
                      value: true, 
                      onChanged: (e){},
                      activeColor: Colors.black,
                    )
                    // TabBar(
                    //   tabs: [
                    //     Icon(Icons.route),
                    //     Icon(Icons.map)
                    //   ]
                    // )
                  ],
                ),
              ),
              Text("data", textAlign: TextAlign.start,)
            ],
          ),
        )
    );
  }
}