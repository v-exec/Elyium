/*
TIMER
 
 This section acts as a standalone module that simply allows to time events.
 Currently, it is being used to trigger the idle mode (see Interface.pde) after a narrative conflict has been resolved.
 It is also used in the entity spawning system (see Location.pde) to create a time interval between entity spawns to avoid uniformly distributed entity spawning.
 */

class Timer {
  int currentTime = 0;
  int recordTime = 0;
  boolean isTiming = false;

  Timer() {
    //
  }

  //sets the timer to wait for 'time' seconds
  public void wait(int time) {
    currentTime = millis();

    if (!isTiming) {
      recordTime = currentTime + (time * 1000);
      isTiming = true;
    }
  }

  //when the timer has waited wait()'s time, timed() returns true
  public boolean timed() {
    currentTime = millis();
    boolean timed = false;

    if (isTiming && recordTime < currentTime) {
      isTiming = false;
      timed = true;
    }

    return timed;
  }
}