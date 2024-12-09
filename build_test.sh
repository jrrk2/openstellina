rm -rf data/dcfbinary.*

cc -Wall -Wno-unknown-pragmas -g -I /Users/jonathan/ephemeris-compute-de430/src -I gsl-2.8 -D DEBUG=1 -D MEMDEBUG1=0 -D MEMDEBUG2=0 -D DCFVERSION=\"4.0\" -D DATE=\"23/09/2024\"  -D PATHLINK=\"/\"  -D SRCDIR=\"src/\" src/argparse/argparse.c src/coreUtils/asciiDouble.c src/coreUtils/errorReport.c src/coreUtils/makeRasters.c src/ephemCalc/magnitudeEstimate.c src/ephemCalc/jpl.c src/ephemCalc/orbitalElements.c src/listTools/ltDict.c src/listTools/ltList.c src/listTools/ltMemory.c src/listTools/ltStringProc.c src/mathsTools/julianDate.c src/mathsTools/precess_equinoxes.c src/mathsTools/sphericalAst.c src/settings/settings.c src/main.c -o ephem_test.bin -Xlinker -map -Xlinker mapfile gsl-2.8/sys/infnan.c gsl-2.8/sys/pow_int.c gsl-2.8/sys/hypot.c gsl-2.8/sys/fdiv.c gsl-2.8/err/error.c gsl-2.8/err/stream.c

./ephem_test.bin --objects="C/2023 A3"
./ephem_test.bin --objects=mars --use_orbital_elements=1
