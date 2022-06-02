# file = horarisSol
file = horaris
#file = miSudoku teams events newBusCompany

$(file): $(file).pl
	swipl -q -O -g main --stand_alone=true -o $(file) -c $(file).pl
