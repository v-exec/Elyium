class Timer {
  int currentTime = 0;
  int recordTime = 0;
  boolean isTiming = false;

  Timer() {
  }

  public boolean wait(int time) {
    currentTime = millis();
    if (isTiming == false) {
      recordTime = millis() + time;
      isTiming = true;
    }

    if (recordTime > currentTime) {
      isTiming = false;
      return true;
    } else return false;
  }
}