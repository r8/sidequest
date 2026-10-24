require ../lib/test.fs
require ../space-age.fs

test" age on Earth"  1000000000 earth age 31.69e assert-f~ ;test
test" age on Mercury"  2134835688 mercury age 280.88e assert-f~ ;test
test" age on Venus"  189839836 venus age 9.78e assert-f~ ;test
test" age on Mars"  2129871239 mars age 35.88e assert-f~ ;test
test" age on Jupiter"  901876382 jupiter age 2.41e assert-f~ ;test
test" age on Saturn"  2000000000 saturn age 2.15e assert-f~ ;test
test" age on Uranus"  1210123456 uranus age 0.46e assert-f~ ;test
test" age on Neptune"  1821023456 neptune age 0.35e assert-f~ ;test

end-tests
