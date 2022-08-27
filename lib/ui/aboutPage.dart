import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:musify/main.dart';
import 'package:musify/style/appColors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.about,
          style: TextStyle(
            color: accent,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: accent,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(child: AboutCards()),
    );
  }
}

class AboutCards extends StatelessWidget {
  const AboutCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 17, left: 8, right: 8, bottom: 6),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Center(
                    child: Text(
                      'Musify  | $version',
                      style: TextStyle(
                        color: accent,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8, left: 10, right: 10),
          child: Divider(
            color: Colors.white24,
            thickness: 0.8,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8, left: 50, right: 50, bottom: 6),
          child: Card(
            color: bgLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2.3,
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://avatars.githubusercontent.com/u/79704324?v=4',
                    ),
                  ),
                ),
              ),
              title: Text(
                'Valeri Gokadze',
                style: TextStyle(color: accent),
              ),
              subtitle: Text(
                'Web/APP Developer',
                style: TextStyle(color: accentLight),
              ),
            ),
          ),
        )
      ],
    );
  }
}