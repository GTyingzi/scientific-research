function results = evaluate_formula(fm, vars, vals)
results = [];


vars = eval(vars)
for i=1:1:size(vals,1)
	data = mat2cell(vals(i,:))
	results(i) = subs(fm,vars,data)
	
end