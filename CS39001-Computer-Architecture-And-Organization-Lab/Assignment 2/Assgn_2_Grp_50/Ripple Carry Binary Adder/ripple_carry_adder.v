`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2020 20:53:08
// Design Name: 
// Module Name: fullAdder
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
// Problem No.: 1 [Ripple Carry Binary Adder]
// Semester No.: 5
// Group No.: G50
// Group Members:  Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
//
//////////////////////////////////////////////////////////////////////////////////

// fullAdder module
module fullAdder(input c_in, input a, input b, output c_out, output s);
    assign {c_out, s} = a + b + c_in;
endmodule

module ripple_carry_adder (input [7:0] a, input [7:0] b, input cin, output [7:0] sum, output cout);
    /**
      * a = First 8 bit input
      * b = Second 8 bit input
      * cin = input carry
      * sum = sum of A and B, without the carry
      * cout = output carry 
      */

    wire [6:0] c_out;

    // cascaded eight full adders
    fullAdder fa_1(.c_in(cin), .a(a[0]), .b(b[0]), .c_out(c_out[0]), .s(sum[0]));
    fullAdder fa_2(.c_in(c_out[0]), .a(a[1]), .b(b[1]), .c_out(c_out[1]), .s(sum[1]));
    fullAdder fa_3(.c_in(c_out[1]), .a(a[2]), .b(b[2]), .c_out(c_out[2]), .s(sum[2]));
    fullAdder fa_4(.c_in(c_out[2]), .a(a[3]), .b(b[3]), .c_out(c_out[3]), .s(sum[3]));
    fullAdder fa_5(.c_in(c_out[3]), .a(a[4]), .b(b[4]), .c_out(c_out[4]), .s(sum[4]));
    fullAdder fa_6(.c_in(c_out[4]), .a(a[5]), .b(b[5]), .c_out(c_out[5]), .s(sum[5]));
    fullAdder fa_7(.c_in(c_out[5]), .a(a[6]), .b(b[6]), .c_out(c_out[6]), .s(sum[6]));
    fullAdder fa_8(.c_in(c_out[6]), .a(a[7]), .b(b[7]), .c_out(cout), .s(sum[7]));
endmodule

