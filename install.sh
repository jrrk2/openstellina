exec env RSYNC_RSH="ssh -i ~/.ssh/google_compute_engine" rsync -z _build/default/openstellina.bc.{js,map} kimmitt.co.uk:/usr/share/wordpress/openstellina2/_build/default/
