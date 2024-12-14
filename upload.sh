mkdir -p archive
for i in `for i in version secure geolocate comets table_update utils location tabbed_dialog altaz astro_utils trans hidemsg msgs messier_catalogue calc mfcalc lexer expr dso_read abell_cnv ngc2000 telescope base_locations openstellina; do echo $i.ml;done | grep -v base| grep -v version| grep -v calc| grep -v lexer`; do cp $i archive/$i.txt;done
