require ../lib/test.fs
require ../tide-tables.fs

create today 120 , 180 , 240 , 210 , 150 ,
create calm 90 ,
create falling 300 , 260 , 190 , 120 , 60 , 20 ,

test" 1. the first reading"  today 0 tide-at 120 assert= ;test
test" 1. a reading in the middle"  today 2 tide-at 240 assert= ;test
test" 1. the last reading"  today 4 tide-at 150 assert= ;test

test" 2. the high tide in the middle of the day"  today 5 highest 240 assert= ;test
test" 2. a single reading"  calm 1 highest 90 assert= ;test
test" 2. the high tide first"  falling 6 highest 300 assert= ;test
test" 2. only part of the day"  falling 2 cells + 4 highest 190 assert= ;test

test" 3. the average of the day"  today 5 average-level 180 assert= ;test
test" 3. a single reading"  calm 1 average-level 90 assert= ;test
test" 3. an average that rounds down"  falling 6 average-level 158 assert= ;test

test" 4. the first reading is below"  today 5 200 first-below 0 assert= ;test
test" 4. no reading is below"  today 5 100 first-below -1 assert= ;test
test" 4. a reading later in the day"  falling 6 100 first-below 4 assert= ;test
test" 4. equal is not below"  falling 6 60 first-below 5 assert= ;test
test" 4. no readings at all"  today 0 500 first-below -1 assert= ;test

create gauge 120 , 180 , 240 ,
create gauge-down 100 , 160 , 220 ,
test" 5. lowering every reading"  gauge 3 -20 raise-all  gauge 3 gauge-down 3 assert-cells= ;test

create gauge2 5 , 0 , -5 , 10 ,
create gauge2-up 20 , 15 , 10 , 25 ,
test" 5. raising every reading"  gauge2 4 15 raise-all  gauge2 4 gauge2-up 4 assert-cells= ;test

create gauge3 7 , 8 , 9 ,
create gauge3-part 17 , 18 , 9 ,
test" 5. only the readings given"  gauge3 2 10 raise-all  gauge3 3 gauge3-part 3 assert-cells= ;test

end-tests
