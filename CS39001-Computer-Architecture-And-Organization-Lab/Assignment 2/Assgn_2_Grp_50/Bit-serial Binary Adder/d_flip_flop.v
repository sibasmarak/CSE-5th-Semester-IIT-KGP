`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2020 15:24:44
// Design Name: 
// Module Name: d_flip_flop
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
// Problem No.: 3 [Bit-serial Binary Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////


module d_flip_flop(
    output reg Q,
    input D,
    input clk,
    input rst,
    input enable
    );
    
    // This module replicates the working of the D flip flop
    always @ (posedge clk, posedge rst) 
    begin
        if (rst)
          Q <= 0;
        else if (enable)
          Q <= D;
    end
endmodule
