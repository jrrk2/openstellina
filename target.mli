
type target_category = 
  | SolarSystem
  | Comets 
  | DeepSky
  | Simbad      
(*
  | Horizons
  | NgcCatalog
  *)
  | RecentTargets

type target_info = {
  name: string;
  ra: float;
  dec: float;
  mag: float;
  desc: string;
  category: target_category;
  debug: string;
}
