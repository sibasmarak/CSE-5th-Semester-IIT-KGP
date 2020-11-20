`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2020 16:25:37
// Design Name: 
// Module Name: mux_3in
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

// 3x1 MUX
module mux_3in#( parameter W = 8 )
(
    input [W-1:0] in0,                  // first input (7 bits)
    input [W-1:0] in1,                  // second input (7 bits)
    input [W-1:0] in2,                  // third input (7 bits)
    input [1:0] sel,                    // select input
    output reg [W-1:0] out              // output
    );
    
    always @(*)
        if(sel==2'b00)                  // if select is 0
            out <= in0;                 // output is first input
        else if(sel==2'b01)             // if select is 1
            out <= in1;                 // output is second input
        else if(sel==2'b10)             // if select is 2
            out <= in2;                 // output is third input
    
endmodule
