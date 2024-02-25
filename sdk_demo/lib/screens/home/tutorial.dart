import 'package:flutter/material.dart';

class TutorialHome<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Home Page Tutorial';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      // Provide DefaultTextStyle to ensure that the dialog's text style
      // matches the rest of the text in the app.
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        // UnconstrainedBox is used to make the dialog size itself
        // to fit to the size of the content.
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Tutorial',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Home Page',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here you can view the application\'s tracking status',
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 200,
                  child: Text(
                    "Tap this icon at the bottom left "
                    "to navigate to the Home Page",
                    textAlign: TextAlign.center,
                  ),
                ),
                const Icon(
                  Icons.home,
                  size: 50,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(TutorialInfo());
                  },
                ),
              ],
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
  String? get barrierLabel => 'Tutorial and Request Data';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      // Provide DefaultTextStyle to ensure that the dialog's text style
      // matches the rest of the text in the app.
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        // UnconstrainedBox is used to make the dialog size itself
        // to fit to the size of the content.
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Tutorial',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Tutorial and Requesting Data',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here you can review the Tutorial or\n'
                  'Request your tracking data',
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Tap this icon at the top right '
                    'to navigate to the selection menu',
                    textAlign: TextAlign.center,
                  ),
                ),
                const Icon(
                  Icons.info_outlined,
                  size: 50,
                ),
                Row(
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Previous"),
                      onPressed: () {
                        Navigator.pushReplacement(context, TutorialHome());
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Next"),
                      onPressed: () {
                        Navigator.pushReplacement(context, TutorialProfile());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialProfile<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'View your credentials';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      // Provide DefaultTextStyle to ensure that the dialog's text style
      // matches the rest of the text in the app.
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        // UnconstrainedBox is used to make the dialog size itself
        // to fit to the size of the content.
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Tutorial',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Profile Page',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here you can view and modify your account information',
                ),
                const SizedBox(height: 10),
                const Column(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Tap this icon at the bottom right "
                        "to navigate to the Profile Page",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Icon(
                      Icons.person_rounded,
                      size: 50,
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Previous"),
                      onPressed: () {
                        Navigator.pushReplacement(context, TutorialInfo());
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Next"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, TutorialCredentials());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialCredentials<T> extends PopupRoute<T> {
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
    return Center(
      // Provide DefaultTextStyle to ensure that the dialog's text style
      // matches the rest of the text in the app.
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        // UnconstrainedBox is used to make the dialog size itself
        // to fit to the size of the content.
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Tutorial',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Profile Page'
                  '\nManage Credentials',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here you can modify your account credentials',
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        "Tap this button in the Profile Page to change your "
                        "E-mail, password, or physician",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.lock_person_rounded),
                      label:
                          Text(textAlign: TextAlign.left, 'Manage Credentials'),
                    )
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Previous"),
                      onPressed: () {
                        Navigator.pushReplacement(context, TutorialProfile());
                      },
                    ),
                    TextButton.icon(
                      label: const Text("Done"),
                      icon: const Icon(Icons.arrow_forward),
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
    );
  }
}
