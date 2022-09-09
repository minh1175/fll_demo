import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget SmartRefresherCustomHeader() {
  return ClassicHeader(
    idleText: "",
    completeText: "",
    refreshingText: "",
    releaseText: "",
    releaseIcon: SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      height: 15.0,
      width: 15.0,
    ),
    refreshingIcon: SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      height: 15.0,
      width: 15.0,
    ),
    completeIcon: SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      height: 15.0,
      width: 15.0,
    ),
  );
}

Widget SmartRefresherCustomFooter() {
  return ClassicFooter(
    completeDuration: const Duration(milliseconds: 0),
    idleText: "",
    loadingText: "",
    noDataText: "",
    canLoadingText: "",
    idleIcon: null,
    canLoadingIcon: null,
    loadingIcon: SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      height: 15.0,
      width: 15.0,
    ),
    noMoreIcon: SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      height: 15.0,
      width: 15.0,
    ),
  );
}