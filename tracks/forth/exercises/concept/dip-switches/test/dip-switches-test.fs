require ../lib/test.fs
require ../dip-switches.fs

test" 1. the mask for switch 0"  0 switch-mask 1 assert= ;test
test" 1. the mask for switch 3"  3 switch-mask %1000 assert= ;test
test" 1. the mask for switch 7"  7 switch-mask %10000000 assert= ;test

test" 2. a switch that is on"  %0101 2 switch-on? true assert= ;test
test" 2. a switch that is off"  %0101 1 switch-on? false assert= ;test
test" 2. the lowest switch"  %0101 0 switch-on? true assert= ;test
test" 2. the highest switch"  %10000000 7 switch-on? true assert= ;test

test" 3. turning on a switch that is off"  %0101 1 turn-on %0111 assert= ;test
test" 3. turning on a switch that is already on"  %0101 2 turn-on %0101 assert= ;test
test" 3. turning on the highest switch"  0 7 turn-on %10000000 assert= ;test

test" 4. turning off a switch that is on"  %0101 2 turn-off %0001 assert= ;test
test" 4. turning off a switch that is already off"  %0101 1 turn-off %0101 assert= ;test
test" 4. turning off every switch but one"  %11111111 0 turn-off %11111110 assert= ;test

test" 5. flipping a switch that is on"  %0101 0 flip %0100 assert= ;test
test" 5. flipping a switch that is off"  %0101 1 flip %0111 assert= ;test
test" 5. flipping a switch twice"  %10010 4 flip 4 flip %10010 assert= ;test

test" 6. no switches on"  0 switches-on 0 assert= ;test
test" 6. some switches on"  %10110001 switches-on 4 assert= ;test
test" 6. every switch on"  %11111111 switches-on 8 assert= ;test
test" 6. bits above the switches do not count"  %1100000011 switches-on 2 assert= ;test

end-tests
