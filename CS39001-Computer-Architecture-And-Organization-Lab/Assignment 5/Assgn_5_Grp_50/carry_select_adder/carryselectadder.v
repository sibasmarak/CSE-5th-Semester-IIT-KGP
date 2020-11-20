`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 19:31:53
// Design Name: 
// Module Name: carryselectadder
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


module carry_select_adder_16bit(
    input [15:0] a, 					// first 16-bit input
    input [15:0] b, 					// second 16-bit input
    input cin, 							// carryin
    output [15:0] sum, 					// 16-bit sum output
    output cout							// carry output
    );

wire [2:0] c;

// evaluate the result in four phases
cla_4_bit cla1 (a[3:0], b[3:0], cin, sum[3:0], c[0]);								// the first is a simple one on the basis of CLA addition

// rest three modules evaluate the possible results 
// with the aid of carry in from previous module
// generate the required output 
carry_select_adder_4bit csa_slice1(a[7:4], b[7:4], c[0], sum[7:4], c[1]);
carry_select_adder_4bit csa_slice2(a[11:8], b[11:8], c[1], sum[11:8], c[2]);
carry_select_adder_4bit csa_slice3(a[15:12], b[15:12], c[2], sum[15:12], cout);

endmodule
