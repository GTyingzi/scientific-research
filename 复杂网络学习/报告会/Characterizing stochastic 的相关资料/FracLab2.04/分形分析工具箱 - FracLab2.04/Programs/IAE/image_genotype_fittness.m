function result = image_genotype_fittness(imgnum)
global mydata;

minmax = [0.49839		0.98548		19.883		1				0.89871; ...
					0					0.014686	0.67977		0.20646	0.078831];


geno = mydata.images.image(imgnum).genotype;
erg = calculate_NN('D:\ProgramsXP\0Science\Pythia\Restrictions_041206.NN', minmax, {[geno.amin,geno.gmin,geno.amax,geno.gmax,geno.anod]});

result = erg{1};