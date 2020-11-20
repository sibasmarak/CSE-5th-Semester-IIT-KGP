`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2020 14:39:23
// Design Name: 
// Module Name: hybridAdder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 2
// Problem No.: 2 [Hybrid Binary Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051) 
// 
//////////////////////////////////////////////////////////////////////////////////


module hybrid_adder (input [7:0] a, input [7:0] b, input cin, output [7:0] sum, output cout);
    /**
      * a = First 8 bit input
      * b = Second 8 bit input
      * cin = input carry
      * sum = sum of A and B, without the carry
      * cout = output carry 
      */

    wire c_out;

    // cascaded two four-bit Carry Look Ahead Adders
    fourBitCLA cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c_out));
    fourBitCLA cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c_out), .sum(sum[7:4]), .cout(cout));   
endmodule
