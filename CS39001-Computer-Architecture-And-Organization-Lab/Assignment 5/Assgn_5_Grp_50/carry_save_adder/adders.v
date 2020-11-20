`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 16:30:39
// Design Name: 
// Module Name: adders
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 5
// Problem No.: 4 [Carry-Save Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


// fullAdder module
module fullAdder(input cin, input a, input b, output cout, output s);
    assign {cout, s} = a + b + cin;
endmodule

// 4 bit CLA Module
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


// 20 bit hybrid adder
module hybrid_adder (input [19:0] a, input [19:0] b, input cin, output [19:0] sum, output c_out);
    /**
      * a = First 20 bit input
      * b = Second 20 bit input
      * cin = input carry
      * sum = sum of A and B, without the carry
      * cout = output carry 
      */

    wire [3:0] cout;

    // cascaded five four-bit Carry Look Ahead Adders
    fourBitCLA cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(cout[0]));
    fourBitCLA cla2 (.a(a[7:4]), .b(b[7:4]), .cin(cout[0]), .sum(sum[7:4]), .cout(cout[1]));
    fourBitCLA cla3 (.a(a[11:8]), .b(b[11:8]), .cin(cout[1]), .sum(sum[11:8]), .cout(cout[2]));
    fourBitCLA cla4 (.a(a[15:12]), .b(b[15:12]), .cin(cout[2]), .sum(sum[15:12]), .cout(cout[3]));
    fourBitCLA cla5 (.a(a[19:16]), .b(b[19:16]), .cin(cout[3]), .sum(sum[19:16]), .cout(c_out));
    
endmodule

