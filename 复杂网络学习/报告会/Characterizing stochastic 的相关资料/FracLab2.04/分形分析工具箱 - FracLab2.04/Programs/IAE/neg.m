function erg = neg(vals, all_vals)

erg = all_vals;
erg(vals) = [];
erg = sort(erg);