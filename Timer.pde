class Timer {
  int currentTime = 0;
  int recordTime = 0;
  boolean isTiming = false;
  boolean done = false;

  Timer() {
  }

  public void wait(int time) {
    currentTime = millis();

    if (isTiming == false) {
      recordTime = currentTime + time;
      done = false;
      isTiming = true;
    }
  }

  public boolean timed() {
    currentTime = millis();

    if (isTiming == true) {
      if (recordTime < currentTime) {
        isTiming = false;
        done = true;
      } else done = false;
    }
    return done;
  }
}