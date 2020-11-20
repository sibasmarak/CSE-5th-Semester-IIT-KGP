`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2020 20:52:21
// Design Name: 
// Module Name: RDFF
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


module RDFF(
    input clk,                      // clock signal          
    input reset,                    // reset signal
    input [1:0] D,                  // D input of D Flip Flop
    output reg[1:0] Q               // Q output of D Flip Flop
    );
    
    always @(posedge clk)
        if(reset)                   // if reset is True
            Q = 0;                  // reset Q
        else                        // otherwise
            Q = D;                  // set Q as D
endmodule
