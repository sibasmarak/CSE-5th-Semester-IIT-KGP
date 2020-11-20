`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2020 19:47:26
// Design Name: 
// Module Name: mux_2in
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

// 2x1 MUX
module mux_2in#( parameter W = 8 )
(
    input [W-1:0] in0,                  // first input (7 bits)
    input [W-1:0] in1,                  // second input (7 bits)
    input sel,                          // select bit
    output reg [W-1:0] out              // output 
    );
    
    always @(*)
        if(sel==1'b0)                   // if select is True
            out <= in0;                 // out is the first input 
        else
            out <= in1;                 // out is second input 
endmodule
