let messier_array =
[|("M   1", "05 34 31.9474694616", "+22 00 52.153698024");
  ("M   2", "21 33 27.02", "-00 49 23.7");
  ("M   3", "13 42 11.62", "+28 22 38.2");
  ("M   4", "16 23 35.22", "-26 31 32.7");
  ("M   5", "15 18 33.22", "+02 04 51.7");
  ("NGC  6405", "17 40 17", "-32 14.5");
  ("NGC  6475", "17 53 47", "-34 50.5"); ("M   8", "18 03 37", "-24 23.2");
  ("M   9", "17 19 11.78", "-18 30 58.5");
  ("M  10", "16 57 09.05", "-04 06 01.1");
  ("NGC  6705", "18 51 04", "-06 16.3");
  ("M  12", "16 47 14.18", "-01 56 54.7");
  ("M  13", "16 41 41.634", "+36 27 40.75");
  ("M  14", "17 37 36.15", "-03 14 45.3");
  ("M  15", "21 29 58.33", "+12 10 01.2"); ("M  16", "18 18 45", "-13 47.5");
  ("NGC  6618", "18 20 47", "-16 10.3"); ("M  18", "18 19 57", "-17 05.3");
  ("M  19", "17 02 37.69", "-26 16 04.6"); ("M  20", "18 02 42", "-22 58.3");
  ("M  21", "18 04 09", "-22 30.3"); ("M  22", "18 36 23.94", "-23 54 17.1");
  ("M  23", "17 56 57", "-18 59.2"); ("M  24", "18 16.8", "-18 33");
  ("IC 4725", "18 31 45", "-19 06.8"); ("M  26", "18 45 16", "-09 23.2");
  ("M  27", "19 59 36.3631850088", "+22 43 16.312059552");
  ("M  28", "18 24 32.89", "-24 52 11.4"); ("M  29", "20 23 46", "+38 29.2");
  ("M  30", "21 40 22.12", "-23 10 47.5");
  ("M  31", "00 42 44.330", "+41 16 07.50");
  ("M  32", "00 42 41.825", "+40 51 54.61");
  ("M  33", "01 33 50.8965749232", "+30 39 36.630403128");
  ("NGC  1039", "02 42 07", "+42 43.3");
  ("NGC  2168", "06 09 05", "+24 20.2"); ("M  36", "05 36 20", "+34 08.1");
  ("M  37", "05 52 18", "+32 32.7"); ("M  38", "05 28 40", "+35 49.4");
  ("NGC  7092", "21 31 33", "+48 14.8"); ("M  40", "12 22.2", "+58 05");
  ("M  41", "06 46 00", "-20 43.0"); ("M  42", "05 35 17.3", "-05 23 28");
  ("M  43", "05 35 31", "-05 16.2"); ("NGC  2632", "08 40 13", "+19 37.3");
  ("Cl Melotte   22", "03 46 24", "+24 06.8");
  ("NGC  2437", "07 41 47", "-14 50.6");
  ("NGC  2422", "07 36 35", "-14 29.3");
  ("NGC  2548", "08 13 39", "-05 43.6");
  ("M  49", "12 29 46.798", "+08 00 01.48");
  ("NGC  2323", "07 02 47.5", "-08 20 16");
  ("M  51", "13 29 52.698", "+47 11 42.93");
  ("M  52", "23 24 47", "+61 35.4"); ("M  53", "13 12 55.25", "+18 10 05.4");
  ("M  54", "18 55 03.33", "-30 28 47.5");
  ("M  55", "19 39 59.71", "-30 57 53.1");
  ("M  56", "19 16 35.57", "+30 11 00.5");
  ("M  57", "18 53 35.0967659112", "+33 01 44.883287544");
  ("M  58", "12 37 43.597", "+11 49 05.12");
  ("M  59", "12 42 02.2581375168", "+11 38 48.909507756");
  ("M  60", "12 43 39.9708251928", "+11 33 09.688174056");
  ("M  61", "12 21 54.9282582888", "+04 28 25.597367184");
  ("M  62", "17 01 12.60", "-30 06 44.5");
  ("M  63", "13 15 49.2741893928", "+42 01 45.728076108");
  ("M  64", "12 56 43.696", "+21 40 57.57");
  ("M  65", "11 18 55.9084654776", "+13 05 32.300703672");
  ("M  66", "11 20 15.026", "+12 59 28.64");
  ("NGC  2682", "08 51 23", "+11 48.8");
  ("M  68", "12 39 27.98", "-26 44 38.6");
  ("M  69", "18 31 23.10", "-32 20 53.1");
  ("M  70", "18 43 12.76", "-32 17 31.6");
  ("M  71", "19 53 46.49", "+18 46 45.1");
  ("M  72", "20 53 27.70", "-12 32 14.3"); ("M  73", "20 59.0", "-12 38");
  ("M  74", "01 36 41.7451236624", "+15 47 01.107512304");
  ("M  75", "20 06 04.841", "-21 55 20.14");
  ("M  76", "01 42 19.6557728208", "+51 34 31.534970052");
  ("M  77", "02 42 40.7091669408", "-00 00 47.859690204");
  ("M  78", "05 46 45.8", "+00 04 45");
  ("M  79", "05 24 10.59", "-24 31 27.3");
  ("M  80", "16 17 02.41", "-22 58 33.9");
  ("M  81", "09 55 33.1726556496", "+69 03 55.062505368");
  ("M  82", "09 55 52.430", "+69 40 46.93");
  ("M  83", "13 37 00.91920", "-29 51 56.7400");
  ("M  84", "12 25 03.74333", "+12 53 13.1393");
  ("M  85", "12 25 24.053", "+18 11 27.89");
  ("M  86", "12 26 11.814", "+12 56 45.49");
  ("M  87", "12 30 49.42338230", "+12 23 28.0438581");
  ("M  88", "12 31 59.1525062448", "+14 25 13.148971824");
  ("M  89", "12 35 39.8073444", "+12 33 22.830809");
  ("M  90", "12 36 49.8009839880", "+13 09 46.523813040");
  ("M  91", "12 35 26.4446761320", "+14 29 46.760333748");
  ("M  92", "17 17 07.39", "+43 08 09.4");
  ("NGC  2447", "07 44 34", "-23 51.2");
  ("M  94", "12 50 53.0737971432", "+41 07 12.900884628");
  ("M  95", "10 43 57.7313485800", "+11 42 13.301191332");
  ("M  96", "10 46 45.744", "+11 49 11.78");
  ("M  97", "11 14 47.7122947800", "+55 01 08.482832076");
  ("M  98", "12 13 48.2910686976", "+14 54 01.953475200");
  ("M  99", "12 18 49.625", "+14 24 59.36");
  ("M 100", "12 22 54.9299993592", "+15 49 20.296257960");
  ("M 101", "14 03 12.583", "+54 20 55.50");
  ("M 102", "15 06 29.561", "+55 45 47.91");
  ("M 103", "01 33 21", "+60 39.5");
  ("M 104", "12 39 59.4302501832", "-11 37 22.988264808");
  ("M 105", "10 47 49.600", "+12 34 53.87");
  ("M 106", "12 18 57.620", "+47 18 13.39");
  ("M 107", "16 32 31.86", "-13 03 13.6");
  ("M 108", "11 11 30.967", "+55 40 26.84");
  ("M 109", "11 57 35.9631479640", "+53 22 29.006082336");
  ("M 110", "00 40 22.0572349992", "+41 41 07.507220136")|]