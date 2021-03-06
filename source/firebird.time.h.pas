unit firebird.time.h;

interface

type
  tm = record
    tm_sec:   integer; // Seconds
    tm_min:   integer; // Minutes
    tm_hour:  integer; // Hour (0--23)
    tm_mday:  integer; // Day of month (1--31)
    tm_mon:   integer; // Month (0--11)
    tm_year:  integer; // Year (calendar year minus 1900)
    tm_wday:  integer; // Weekday (0--6) Sunday = 0)
    tm_yday:  integer; // Day of year (0--365)
    tm_isdst: integer; // 0 if daylight savings time is not in effect)
  end;
  ptm = ^tm;

implementation

end.
