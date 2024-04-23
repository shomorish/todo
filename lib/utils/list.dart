bool equalsList<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;

  for (final toDo in a) {
    if (!b.contains(toDo)) return false;
  }

  return true;
}
