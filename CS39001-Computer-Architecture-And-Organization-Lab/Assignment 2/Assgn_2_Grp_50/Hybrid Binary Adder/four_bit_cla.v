`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2020 14:26:51
// Design Name: 
// Module Name: fourBitCLA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Assignment No.: 2
// Problem No.: 2 [Hybrid Binary Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


module fourBitCLA(input [3:0] a, input [3:0] b, input cin, output [3:0] sum, output cout);
    /**
      * a = First 4 bit input
      * b = Second 4 bit input
      * cin = input carry
      * sum = sum of A and B, without the carry
      * cout = output carry 
      */

    wire [3:0] p, g; // define propagate and generate bits
    wire [4:0] c;       // define carry bits
    
    assign p[3:0] = a[3:0] ^ b[3:0];    // assign propagate values to p
    assign g[3:0] = a[3:0] & b[3:0];    // assign generate values to g
    
    assign c[0] = cin,
    c[1] = g[0]|(p[0] & cin),
    c[2] = g[1]|(p[1] & g[0])|(p[1] & p[0] & cin),
    c[3] = g[2]|(p[2] & g[1])|(p[2] & p[1] & g[0])|(p[2] & p[1] & p[0] & cin),
    c[4] = g[3]|(p[3] & g[2])|(p[3] & p[2] & g[1])|(p[3] & p[2] & p[1] & g[0])|(p[3] & p[2] & p[1] & p[0] & cin);
    
    assign sum[3:0] = p[3:0] ^ c[3:0];  // assign the sum result to sum
    assign cout = c[4];                 // assign the output carry
endmodule
