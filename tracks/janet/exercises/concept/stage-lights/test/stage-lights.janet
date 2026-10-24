(import test :as t)
(import ../stage-lights :as sol)

(t/deftest "1. full brightness when none is set"
  (t/assert-equal 100 (with-dyns [:brightness nil] (sol/brightness))))

(t/deftest "1. the brightness that is set"
  (t/assert-equal 40 (with-dyns [:brightness 40] (sol/brightness))))

(t/deftest "1. a dark stage"
  (t/assert-equal 0 (with-dyns [:brightness 0] (sol/brightness))))

(t/deftest "2. a white spotlight at full brightness"
  (t/assert-equal "white spotlight on Miranda at 100%"
                  (with-dyns [:brightness nil :color nil] (sol/spotlight "Miranda"))))

(t/deftest "2. the color and brightness of the scene"
  (t/assert-equal "amber spotlight on Prospero at 60%"
                  (with-dyns [:color :amber :brightness 60] (sol/spotlight "Prospero"))))

(t/deftest "2. the innermost setting wins"
  (t/assert-equal "red spotlight on Caliban at 20%"
                  (with-dyns [:color :green :brightness 20]
                    (with-dyns [:color :red]
                      (sol/spotlight "Caliban")))))

(t/deftest "3. a scene in a color"
  (t/assert-equal "blue spotlight on Ariel at 100%"
                  (with-dyns [:brightness nil] (sol/in-color :blue (fn [] (sol/spotlight "Ariel"))))))

(t/deftest "3. the function's result is returned"
  (t/assert-equal :violet (sol/in-color :violet (fn [] (dyn :color)))))

(t/deftest "3. the color is restored afterwards"
  (t/assert-equal :amber
                  (with-dyns [:color :amber]
                    (sol/in-color :blue (fn [] nil))
                    (dyn :color))))

(t/deftest "3. the brightness of the scene still applies"
  (t/assert-equal "green spotlight on Ferdinand at 30%"
                  (with-dyns [:brightness 30] (sol/in-color :green (fn [] (sol/spotlight "Ferdinand"))))))

(t/deftest "4. dimming returns the new brightness"
  (t/assert-equal 50 (with-dyns [:brightness 80] (sol/dim! 30))))

(t/deftest "4. the dimmed brightness stays for the scene"
  (t/assert-equal 50 (with-dyns [:brightness 80] (sol/dim! 30) (sol/brightness))))

(t/deftest "4. dimming from full brightness, twice"
  (t/assert-equal 70 (with-dyns [:brightness nil] (sol/dim! 10) (sol/dim! 20) (sol/brightness))))

(t/deftest "4. never darker than dark"
  (t/assert-equal 0 (with-dyns [:brightness 15] (sol/dim! 40))))

(t/deftest "5. one printed line"
  (t/assert-equal "Lights up\n" (sol/rehearse (fn [] (print "Lights up")))))

(t/deftest "5. several printed lines"
  (t/assert-equal "Act one\nLights up\n" (sol/rehearse (fn [] (print "Act one") (print "Lights up")))))

(t/deftest "5. a quiet cue"
  (t/assert-equal "" (sol/rehearse (fn [] :nothing))))

(t/deftest "5. the result is a string, not a buffer"
  (t/assert-true (string? (sol/rehearse (fn [] (prin "fade"))))))

(t/run)
