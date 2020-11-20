`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 20:43:01
// Design Name: 
// Module Name: select
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
// Problem No.: 3 [Carry-Select Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////

module cla_4_bit(input [3:0] a, input [3:0] b, input cin, output [3:0] sum, output cout);
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

module carry_select_adder_4bit (
    input [3:0] a,                  // 4 bit input
    input [3:0] b,                  // second 4 bit input
    input cin,                      // input carry - decides the sum and carry output
    output [3:0] sum,               // 4-bit sum
    output cout                     // carry output
    );
 
wire [3:0] s0,s1;
wire c0,c1;
 
cla_4_bit cla1(a[3:0], b[3:0], 1'b0, s0[3:0], c0);          // the sum and carry results if the input carry is 0 
cla_4_bit cla2(a[3:0], b[3:0], 1'b1, s1[3:0], c1);          // the sum and carry results if the input carry is 01
 
mux2X1 #(4) ms0( s0[3:0], s1[3:0], cin, sum[3:0]);          // choose the sum according to the carry input from previous block
mux2X1 #(1) mc0( c0, c1, cin, cout);                        // choose the carry output according to the carry input from previous block

endmodule