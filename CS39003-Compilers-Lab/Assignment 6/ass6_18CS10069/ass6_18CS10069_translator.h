
/**
 * Authors  : Debajyoti Dasgupta (18CS30051) [debajyotidasgupta6@gmail.com]
 *            Siba Smarak Panigrahi (18CS10069) [sibasmarak.p@gmail.com]
 * Language : C++14
 * Desc     : header file for the translation statements
 * Date     : 24.10.2020
 * Project  : TinyC
 * Course   : CS39003 Compilers Laboratory
 */


#ifndef TRANSLATE
#define TRANSLATE
#include <bits/stdc++.h>

#define CHAR_SIZE          1
#define INT_SIZE           4
#define DOUBLE_SIZE        8
#define POINTER_SIZE       4

using namespace std;

extern char *yytext;
extern int yyparse();


//--------------------------------------------------//
//                  Class Declarations              //
//--------------------------------------------------//

class sym;	                                                                     // class for storing Entry in a symbol table
class quad;                                                                      // class for storing Entry in quad Array
class symtype;                                                                   // class for storing Type of a symbol in symbol table
class symtable;                                                                  // class for storing Symbol Table
class quadArray;	                                                             // class for storing QuadArray

//----------------------------------------------//
//              global variables                //
//----------------------------------------------//

extern quadArray q;                                                               // Array of Quads
extern symtable * table;                                                          // Current Symbbol Table
extern sym * currentSymbol;                                                       // Pointer to just encountered symbol
extern symtable * globalTable;                                                    // Global Symbbol Table


//--------------------------------------------------//
//      Defination of the type of symbol            //
//--------------------------------------------------//

class symtype
{                                                                                 // Type of symbols in symbol table
	public:
	
	symtype(string type, symtype *ptr = NULL, int width = 1);
	string type;
	int width;                                                                    // Size of Array (in case of Arrays)
	symtype * ptr;                                                                // for 2d Arrays and pointers
};

//--------------------------------------------------//
//      Defination of the struct of quad element    //
//--------------------------------------------------//

class quad
{                                                                                  // Quad Class
	public:
		
	string op;                                                                     // Operator
	string result;                                                                 // Result
	string arg1;                                                                   // Argument 1
	string arg2;                                                                   // Argument 2

	void print();                                                                  // Print Quad
	quad(string result, string arg1, string op = "EQUAL", string arg2 = "");       //constructors
	quad(string result, int arg1, string op = "EQUAL", string arg2 = "");          //constructors
	quad(string result, float arg1, string op = "EQUAL", string arg2 = "");        //constructors
};

//----------------------------------------------------------//
//          Defination of the quad array type               //
//----------------------------------------------------------//

class quadArray
{                                                                                  // Array of quads
	public:
	
	vector<quad> Array;                                                            // Vector of quads
	void print();                                                                  // Print the quadArray
};

//----------------------------------------------------------------------//
//      Defination of structure of each element of the symbol table     //
//----------------------------------------------------------------------//

class sym
{                                                                                  // Symbols class
	public:
		
	string name;                                                                   // Name of the symbol
	symtype * type;                                                                // Type of the Symbol
	string initial_value;                                                          // Symbol initial valus (if any)
	string category;                                                               // global, local or param
	int size;                                                                      // Size of the symbol
	int offset;                                                                    // Offset of symbol
	symtable * nested;                                                             // Pointer to nested symbol table

	sym(string name, string t = "INTEGER", symtype *ptr = NULL, int width = 0);    // constructor declaration
	sym* update(symtype *t);                                                       // A method to update different fields of an existing entry.
	sym* link_to_symbolTable(symtable *t);
};

//------------------------------------------------------//
//          Class defination for the Symbol Table       //
//------------------------------------------------------//
class symtable
{                                                                                  // Symbol Table class
	public:
		
	string name;                                                                   // Name of Table
	int count;                                                                     // Count of temporary variables
	list<sym> table;                                                               // The table of symbols
	symtable * parent;                                                             // Immediate parent of the symbol table
	map<string, int> ar;                                                           // activation record
	symtable(string name = "NULL");
	sym* lookup(string name);                                                      // Lookup for a symbol in symbol table
	void print();                                                                  // Print the symbol table
	void update();                                                                 // Update offset of the complete symbol table
};

//------------------------------------------------------//
//          Class defination for the Statements         //
//------------------------------------------------------//

struct statement
{
	list<int> nextlist;	                                                           // Nextlist for statement
};

//--------------------------------------------------------------//
//          Attributes of the array type element                //
//--------------------------------------------------------------//

struct Array
{
	string cat;
	sym * loc;                                                                     // Temporary used for computing Array address
	sym * Array;                                                                   // Pointer to symbol table
	symtype * type;                                                                // type of the subArray generated
};

//----------------------------------------------//
//     Defination of the expression type        //
//----------------------------------------------//
struct expr
{
	string type;	                                                               // to store whether the expression is of type int or bool

	// -------- Valid for non-bool type ----------
	sym * loc;                                                                     // Pointer to the symbol table entry

	// ------------- Valid for bool type ----------
	list<int> truelist;                                                            // Truelist valid for boolean
	list<int> falselist;                                                           // Falselist valid for boolean expressions

	//------- Valid for statement expression ------
	list<int> nextlist;
};

/**
 * GENTEMP
 * -------
 * generates a temporary variable 
 * and insert it in the current 
 * Symbole table 
 * 
 * Parameter
 * ---------
 * symbol type * : pointer to the 
 *                 class of symbol type
 * init : initial value of the structure
 * 
 * Return
 * ------
 * Pointer to the newly created symbol 
 * table entry
 */
sym* gentemp(symtype *t, string init = "");

//------------------------------------------------------------------//
//          Overloaded emit function used by the parser             //
//------------------------------------------------------------------//

//----------------Global functions required for the translator----------------

void emit(string op, string result, string arg1 = "", string arg2 = "");	       // emits for adding quads to quadArray
void emit(string op, string result, int arg1, string arg2 = "");                   // emits for adding quads to quadArray (arg1 is int)
void emit(string op, string result, float arg1, string arg2 = "");                 // emits for adding quads to quadArray (arg1 is float)

//-------------------------------------------------------------//
//            Backpatching and related functions               //
//-------------------------------------------------------------//

void backpatch(list<int> lst, int i);
list<int> makelist(int i);                                                         // Make a new list contaninig an integer
list<int> merge(list<int> &lst1, list<int> &lst2);                                 // Merge two lists into a single list

//----------------------------------------------------------------------//
//          Other helper functions required for TAC generation          //
//----------------------------------------------------------------------//

sym* conv(sym *, string);                                                          // TAC for Type conversion in program
bool typecheck(sym* &s1, sym* &s2);                                                // Checks if two symbols have same type
bool typecheck(symtype *t1, symtype *t2);                                          // checks if two symtype objects have same type

expr* convertInt2Bool(expr*);                                                      // convert any expression (int) to bool
expr* convertBool2Int(expr*);                                                      // convert bool to expression (int)

void changeTable(symtable *newtable);                                              //for changing the current sybol table
int nextinstr();                                                                   // Returns the next instruction number

//----------------------------------------------------------------------//
//           Other helper function for debugging and printing           //
//----------------------------------------------------------------------//

int size_type(symtype*);                                                           // Calculate size of any symbol type 
string print_type(symtype*);                                                       // For printing type of symbol recursive printing of type

#endif