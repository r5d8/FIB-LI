#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <map>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;
map<int, vector<int>> occurs_list;
/* Estructura de occurs_list:
 * Cada posició del diccionari representa un literal en positiu o negatiu
 * i conté un vector de clausules que el contenen.
 */

void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses); 
  occurs_list = map<int, vector<int>>();
  
   
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
		clauses[i].push_back(lit);
		if (occurs_list.find(lit) == occurs_list.end()) occurs_list[lit] = vector<int>();
		occurs_list[lit].push_back(i);
	}
  }    
}



int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}


bool propagateGivesConflict ( ) {
	while ( indexOfNextLitToPropagate < modelStack.size() ) {
		for (int i : occurs_list[modelStack[indexOfNextLitToPropagate]])
		{
			bool someLitTrue = false;
			int numUndefs = 0;
			int lastLitUndef = 0;
			for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){
				int val = currentValueInModel(clauses[i][k]);
				if (val == TRUE) someLitTrue = true;
				else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
			}
			if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
			else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
		}
		for (int i : occurs_list[-modelStack[indexOfNextLitToPropagate]])
		{
			bool someLitTrue = false;
			int numUndefs = 0;
			int lastLitUndef = 0;
			for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){
				int val = currentValueInModel(clauses[i][k]);
				if (val == TRUE) someLitTrue = true;
				else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
			}
			if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
			else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
		}
	  
		++indexOfNextLitToPropagate;   
	}
	return false;
}


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}


// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
	int max = 0;
	for (uint i = 1; i <= numVars; ++i)
	{
		if (model[i] == UNDEF)
		{
			if (max == 0) {
				max = i;
				if (occurs_list[i].size() < occurs_list[-i].size()) max = -i;
			}
			else if (occurs_list[max].size() < occurs_list[-i].size()) max = -i;
			else if (occurs_list[max].size() < occurs_list[i].size()) max = i;
		}
	}
	return max;
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }
  
  // DPLL algorithm
  while (true) {
    while ( propagateGivesConflict() ) {
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack();
    }
    int decisionLit = getNextDecisionLiteral();
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}  
