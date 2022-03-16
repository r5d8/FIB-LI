# file = miSudoku
#file = miSudoku teams events newBusCompany

# $(file): $(file).pl
# 	swipl -q -O -g main --stand_alone=true -o $(file) -c $(file).pl

miSudoku: miSudoku.pl
	swipl -q -O -g main --stand_alone=true -o miSudoku -c miSudoku.pl

teams: teams.pl
	swipl -q -O -g main --stand_alone=true -o teams -c teams.pl

events: events.pl
	swipl -q -O -g main --stand_alone=true -o events -c events.pl

newBusCompany: newBusCompany.pl
	swipl -q -O -g main --stand_alone=true -o newBusCompany -c newBusCompany.pl
