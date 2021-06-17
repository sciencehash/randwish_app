extension MyDuration on Duration {
  String hHMMSSFormat() => this.toString().split('.').first.padLeft(8, "0").substring(
      this.inHours == 0 ? 3 : 0);
}
