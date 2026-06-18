import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IconContent extends StatelessWidget {
  const IconContent({super.key, required this.cardIcon, required this.label});

  final FaIconData cardIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FaIcon(
              cardIcon,
              size: 32.0,
              color: Theme.of(context).colorScheme.onSurface,
            ).animate().fade(end: 1).scaleXY(end: 1.2, duration: 500.ms),
          ),
          const SizedBox(height: 15.0),
          Text(
            label,
            style: kLabelTextStyle(context),
          )
        ]);
  }
}

class IconMsgContent extends StatelessWidget {
  const IconMsgContent({super.key,
    required this.cardIcon,
    required this.label,
    required this.msg_widget,
    this.badgeDelay,
  });

  final FaIconData cardIcon;
  final String label;
  final Widget msg_widget;
  final Duration? badgeDelay;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FaIcon(
              cardIcon,
              size: 32.0,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: kLabelTextStyle(context),
              ),
              const SizedBox(width: 5.0),
              DelayedChild(
                delay: badgeDelay ?? Duration.zero,
                child: msg_widget,
              )
            ],
          )
        ]);
  }
}

class DelayedChild extends StatefulWidget {
  const DelayedChild({super.key, required this.delay, required this.child});

  final Duration delay;
  final Widget child;

  @override
  State<DelayedChild> createState() => _DelayedChildState();
}

class _DelayedChildState extends State<DelayedChild> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _show = true;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          setState(() {
            _show = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _show ? widget.child : const SizedBox.shrink();
  }
}
