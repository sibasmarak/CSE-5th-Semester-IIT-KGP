/**
 * Authors  : Debajyoti Dasgupta (18CS30051) [debajyotidasgupta6@gmail.com]
 *            Siba Smarak Panigrahi (18CS10069) [sibasmarak.p@gmail.com]
 * Language : C++14
 * Desc     : header file for the translation statements
 * Date     : 24.10.2020
 * Project  : TinyC
 * Course   : CS39003 Compilers Laboratory
 */


#ifndef _TRANSLATE_H
#define _TRANSLATE_H

#include <bits/stdc++.h>

extern  char* yytext;
extern  int yyparse();

using namespace std;

//--------------------------------------------------//
//                  Class Declarations              //
//--------------------------------------------------//

class sym;                                                                                 // stands for an entry in ST
class quad;                                                                                // stands for a single entry in the quad Array
class label;                                                                               // stands for a single label entry in the label table
class symtable;                                                                            // stands for ST
class basicType;                                                                           // stands for the basic type data
class quadArray;                                                                           // stands for the Array of quads
class symboltype;                                                                          // stands for the type of a symbol in ST
class Expression;                                                                          // standsfor the expression type data storage

typedef sym s;
typedef symboltype symtyp;
typedef Expression* Exps;

//----------------------------------------------//
//              global variables                //
//----------------------------------------------//

extern symtable* ST;                                                                       // denotes the current Symbol Table
extern symtable* globalST;                                                                 // denotes the Global Symbol Table
extern symtable* parST;                                                                    // denotes the Parent of the current Symbol Table
extern s* currSymbolPtr;                                                                   // denotes the latest encountered symbol
extern quadArray Q;                                                                        // denotes the quad Array
extern basicType bt;                                                                       // denotes the Type ST
extern long long int table_count;                                                          // denotes count of nested tables
extern bool debug_on;                                                                      // bool for printing debug output
extern string loop_name;                                                                   // get the name of the loop
extern vector<label>label_table;                                                           // table to store the labels

//----------------------------------------------------------------------//
//      Defination of structure of each element of the symbol table     //
//----------------------------------------------------------------------//
class sym 
{                                                                                          // For an entry in ST, we have
	public:
        string name;                                                                       // denotes the name of the symbol
        symboltype *type;                                                                  // denotes the type of the symbol
        int size;                                                                          // denotes the size of the symbol
        int offset;                                                                        // denotes the offset of symbol in ST
        symtable* nested;                                                                  // points to the nested symbol table
        string val;                                                                        // initial value of the symbol if specified
          
        sym (string , string t="int", symboltype* ptr = NULL, int width = 0);              // constructor
        sym* update(symboltype*);                                                          // Method to update different fields of an existing entry.
};

//--------------------------------------------------//
//      Defination of the label symbol              //
//--------------------------------------------------//
class label                                                                                // class of label symbols
{
    public:
        string name;                                                                       // stores the name of the label
        int addr;                                                                          // stores the address the label is pointing to
        list<int> nextlist;                                                                // list of dangling goto statements

        label(string _name, int _addr = -1);                                               // label
};

//--------------------------------------------------//
//      Defination of the type of symbol            //
//--------------------------------------------------//
class symboltype 
{                                                                                           // Class to store the type of the symbol
    public:
        string type;                                                                        // stores the type of symbol. 
        int width;                                                                          // stores the size of Array (if we encounter an Array) and it is 1 in default case
        symboltype* arrtype;                                                                // for storing the typr of the array in recursive manner
        
        symboltype(string , symboltype* ptr = NULL, int width = 1);                         // Constructor
};

//------------------------------------------------------//
//          Class defination for the Symbol Table       //
//------------------------------------------------------//
class symtable 
{                                                                                           // class to store the symbol table
    public:
        string name;                                                                        // Name of the Table
        int count;                                                                          // Count of the temporary variables
        list<sym> table;                                                                    // The table of symbols which is essentially a list of sym
        symtable* parent;                                                                   // Parent ST of the current ST
        
        symtable (string name="NULL");                                                      // Constructor
        s* lookup (string);                                                                 // Lookup for a symbol in ST
        void print();                                                                       // Print the ST
        void update();                                                                      // Update the ST
};

//--------------------------------------------------//
//      Defination of the struct of quad element    //
//--------------------------------------------------//
class quad 
{                                                                                            // A single quad has four components:
    public:
        string res;                                                                          // Result
        string op;                                                                           // Operator
        string arg1;                                                                         // Argument 1
        string arg2;                                                                         // Argument 2    

	    //----------Print the Quad--------------
        void print();	
        void type1();                                                                        // for printing binary operators
        void type2();                                                                        // for printing relational operators and jumps

        //----------Constructors---------------							
        quad (string , string , string op = "=", string arg2 = "");			
        quad (string , int , string op = "=", string arg2 = "");				
        quad (string , float , string op = "=", string arg2 = "");			
};

//----------------------------------------------------------//
//          Defination of the quad array type               //
//----------------------------------------------------------//
class quadArray 
{                                                                                            // Quad Array Class declaration
    public:
        vector<quad> Array;                                                                  // Simply an Array (vector) of quads
        void print();                                                                        // Print the quadArray
};

//----------------------------------------------------------//
//          Defination of the basic type                    //
//----------------------------------------------------------//
class basicType 
{                                                                                            // To denote a basic type
    public:
        vector<string> type;                                                                 // type name
        vector<int> size;                                                                    // size of the type
        void addType(string ,int );
};

//----------------------------------------------//
//     Defination of the expression type        //
//----------------------------------------------//
struct Expression {
    s* loc;                                                                                  // pointer to the symbol table entry
    string type;                                                                             // to store whether the expression is of type int or bool or float or char
    list<int> truelist;                                                                      // fruelist for boolean expressions
    list<int> falselist;                                                                     // falselist for boolean expressions
    list<int> nextlist;                                                                      // for statement expressions
};

//--------------------------------------------------------------//
//          Attributes of the array type element                //
//--------------------------------------------------------------//
struct Array {
    string atype;                                                                            // Used for type of Array: may be "ptr" or "arr" type
    s* loc;                                                                                  // Location used to compute address of Array
    s* Array;                                                                                // pointer to the symbol table entry
    symboltype* type;                                                                        // type of the subarr1 generated (important for multidimensional arr1s)
};

struct Statement {
    list<int> nextlist;                                                                      // nextlist for Statement with dangling exit
};

//------------------------------------------------------------------//
//          Overloaded emit function used by the parser             //
//------------------------------------------------------------------//
void emit(string , string , string arg1="", string arg2 = "");  
void emit(string , string , int, string arg2 = "");		  
void emit(string , string , float , string arg2 = "");   

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
s* gentemp (symboltype* , string init = "");

//-------------------------------------------------------------//
//            Backpatching and related functions               //
//-------------------------------------------------------------//
void backpatch (list <int> , int );                                                          // backpatch the dangling instructions with the given address(parameter) 
list<int> makelist (int );                                                                   // Make a new list contanining an integer address
list<int> merge (list<int> &l1, list <int> &l2);                                             // Merge two lists into a single list

//----------------------------------------------------------------------//
//          Other helper functions required for TAC generation          //
//----------------------------------------------------------------------//

label* find_label(string name);
//------------- Type checking and Type conversion functions -------------
string convertIntToString(int);                                                              // helper function to convert integer to string
string convertFloatToString(float);                                                          // helper function to convert float to string
Exps convertIntToBool(Exps);                                                                 // helper function to convert int expression to boolean
Exps convertBoolToInt(Exps);                                                                 // helper function to convert boolean expression to int

s* convertType(sym*, string);                                                                // helper function for type conversion
int computeSize (symboltype *);                                                              // helper function to calculate size of symbol type
void changeTable (symtable* );                                                               // helper function to change current table
bool compareSymbolType(sym* &s1, sym* &s2);                                                  // helper function to check for same type of two symbol table entries
bool compareSymbolType(symboltype*, symboltype*);                                            // helper function to check for same type of two symboltype objects

int nextinstr();                                                                             // Returns the next instruction number

//----------------------------------------------------------------------//
//           Other helper function for debugging and printing           //
//----------------------------------------------------------------------//
string printType(symboltype *);                                                              // print type of symbol
void generateSpaces(int);

#endif