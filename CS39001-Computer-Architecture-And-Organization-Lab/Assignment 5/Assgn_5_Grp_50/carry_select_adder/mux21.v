`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 20:58:08
// Design Name: 
// Module Name: mux21
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

// 2 by 1 mux
module mux2X1 #(parameter width = 16)( 
    input [width-1 : 0] in0, in1,
    input sel,
    output [width-1 : 0] out
    );
 
    assign out = (sel) ? in1 : in0;					// output according to the sel input
    
endmodule
