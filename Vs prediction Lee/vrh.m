function [Kreuss,Kvoigt,Kfluid] = vrh(sb,Kb,Ko,Kg)
Kreuss=(sb/Kb)+((1-sb)/Ko)+(0/Kg);
Kvoigt=(sb*Kb)+((1-sb)*Ko)+(0*Kg);
Kfluid=(0.5*(Kreuss+Kvoigt));
end
