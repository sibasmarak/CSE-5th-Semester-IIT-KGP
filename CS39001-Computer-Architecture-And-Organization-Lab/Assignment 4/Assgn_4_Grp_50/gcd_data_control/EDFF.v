`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2020 19:41:53
// Design Name: 
// Module Name: EDFF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 4
// Problem No.: 3 [Sequential GCD Calculator]
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////


module EDFF#( parameter W = 8 )
(
    input clk,						// clock signal 
    input en,						// enable signal
    input [W-1:0] D,				// D signal
    output reg [W-1:0] Q			// Q output
    );
    
    always @(posedge clk)	
        if(en)						// if enable is True
            Q = D;					// set Q as D
    
endmodule
