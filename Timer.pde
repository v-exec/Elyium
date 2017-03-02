/*
TIMER
 
 This section acts as a standalone module that simply allows to time events.
 Currently, it is being used to trigger the idle mode (see Interface.pde) after a narrative conflict has been resolved.
 It will also likely be used in the entity spawning system (see Location.pde) to control the entity spawn frequency.
 */

class Timer {
  int currentTime = 0;
  int recordTime = 0;
  boolean isTiming = false;
  boolean done = false;

  Timer() {
  }

  public void wait(int time) {
    currentTime = millis();

    if (!isTiming) {
      recordTime = currentTime + time;
      done = false;
      isTiming = true;
    }
  }

  public boolean timed() {
    currentTime = millis();

    if (isTiming) {
      if (recordTime < currentTime) {
        isTiming = false;
        done = true;
      } else done = false;
    }
    return done;
  }
}