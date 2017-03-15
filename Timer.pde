/*
TIMER
 
 This section acts as a standalone module that simply allows to time events.
 Currently, it is being used to trigger the idle mode (see Interface.pde) after a narrative conflict has been resolved.
 It will also likely be used in the entity spawning system (see Location.pde) to calculate player's physical speed (distance / time) to determine spawning.
 */

class Timer {
  int currentTime = 0;
  int recordTime = 0;
  boolean isTiming = false;

  Timer() {
    //
  }

  //sets the timer to wait for 'time' milliseconds
  public void wait(int time) {
    currentTime = millis();

    if (!isTiming) {
      recordTime = currentTime + time;
      isTiming = true;
    }
  }

  //when the timer has waited wait()'s milliseconds, timed() returns true
  public boolean timed() {
    currentTime = millis();
    boolean timed = false;

    if (isTiming && recordTime < currentTime) {
      isTiming = false;
      timed = true;
    } else timed = false;
    return timed;
  }
}