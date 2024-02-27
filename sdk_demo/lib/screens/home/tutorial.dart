import 'package:flutter/material.dart';

class TutorialHome<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Home Page';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1 / 1.1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Tutorial - Home Page',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Text(
                      "Tap this icon at the bottom left corner "
                      "to navigate to the Home Page",
                    ),
                    const Icon(
                      Icons.home,
                      size: 60,
                    ),
                    const Text(
                      'where you can view the app\'s tracking status',
                    ),
                    TextButton(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward,
                          ),
                          Text(
                            "Next",
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(TutorialInfo());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialInfo<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Revisit Tutorial';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1 / 1.1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Tutorial - Home Page',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Text(
                      "Tap this icon at the top right corner of the home page "
                      "to navigate to this tutorial",
                    ),
                    const Icon(
                      Icons.info_outline,
                      size: 60,
                    ),
                    const Text(
                      "where you can review app functionalities",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                              ),
                              Text(
                                "Previous",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialHome());
                          },
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Text(
                                "Next",
                              ),
                              Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialSettings());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialSettings<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Application and Account Info';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1 / 1.1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Tutorial - Settings Page',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Text(
                      "Tap this icon at the bottom right corner "
                      "to navigate to the Settings Page",
                    ),
                    const Icon(
                      Icons.settings_outlined,
                      size: 60,
                    ),
                    const Text(
                      "where you can edit your profile, request your data,"
                      " and view app info",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                              ),
                              Text(
                                "Previous",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialInfo());
                          },
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Text(
                                "Next",
                              ),
                              Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialEditProfile());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialEditProfile<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Manage your credentials';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1 / 1.1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Tutorial - Settings Page',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Text(
                      "Tap this icon in the settings page "
                      "to navigate to your profile",
                    ),
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 60,
                    ),
                    const Text(
                      'where you can view and manage your credentials ',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                              ),
                              Text(
                                "Previous",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialSettings());
                          },
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Text(
                                "Next",
                              ),
                              Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialRequestData());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialRequestData<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Settings';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1 / 1.1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Tutorial - Settings Page',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Text(
                      "Tap this icon in the settings page "
                      "to navigate a form",
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.drive_file_move_rtl,
                          size: 60,
                        ),
                        Icon(
                          Icons.file_copy,
                          size: 60,
                        ),
                        Icon(
                          Icons.file_present,
                          size: 60,
                        ),
                      ],
                    ),
                    const Text(
                      'where you can request your collected'
                      ' raw drive data',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                              ),
                              Text(
                                "Previous",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(TutorialEditProfile());
                          },
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Text(
                                "Done",
                              ),
                              Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
