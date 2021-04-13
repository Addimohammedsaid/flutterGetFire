import 'package:flutter/material.dart';
import 'package:get_fire_starter/app/core/theme/app_color.dart';
import 'style.dart';

class AuthenticationLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final String mainButtonTitle;
  final Widget form;
  final void Function() onMainButtonTapped;
  final void Function() onForgotPassword;
  final void Function() onBackPressed;
  final Widget bottomWidget;
  final String validationMessage;
  final bool busy;

  const AuthenticationLayout({
    Key key,
    this.title,
    this.subtitle,
    this.mainButtonTitle,
    this.form,
    this.bottomWidget,
    this.onMainButtonTapped,
    this.onForgotPassword,
    this.onBackPressed,
    this.validationMessage,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            if (onBackPressed == null) verticalSpaceLarge,
            if (onBackPressed != null) verticalSpaceRegular,
            if (onBackPressed != null)
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: onBackPressed,
                  ),
                  Text("Back ",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: AppColors.DARK,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            if (onBackPressed != null) verticalSpaceRegular,
            if (title != null)
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black87, fontSize: 34),
                  textAlign: TextAlign.left),
            verticalSpaceSmall,
            if (subtitle != null)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: screenWidthPercentage(context, percentage: 1),
                  child: Text(subtitle,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
              ),
            verticalSpaceLarge,
            form ?? SizedBox.shrink(),
            verticalSpaceTiny,
            if (validationMessage != null)
              Text(validationMessage ?? "",
                  style: TextStyle(color: Colors.redAccent)),
            if (validationMessage != null) verticalSpaceRegular,
            verticalSpaceRegular,
            if (onMainButtonTapped != null)
              GestureDetector(
                onTap: onMainButtonTapped,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: busy
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : Text(
                          mainButtonTitle ?? "",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                ),
              ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: bottomWidget ?? SizedBox.shrink(),
        ),
      )
    ]);
  }
}
