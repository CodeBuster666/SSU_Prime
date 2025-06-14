import "package:flutter/material.dart";

StatefulWidget trail({
  required Widget child,
  required String name,
  required String description,
}) {
  return Trail(
    child: child,
    name: name,
    description: description,
  );
}