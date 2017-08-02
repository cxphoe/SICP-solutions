;; a)
(meeting ?division (Friday ?time))

;; b)
(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time)
          (and (job ?person (?division . ?type))
               (meeting ?division ?day-and-time))))

;; c)
(meeting-time (Hacker P Alyssa) (Wednesday ?time))