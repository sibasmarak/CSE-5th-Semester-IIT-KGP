`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2020 14:01:48
// Design Name: 
// Module Name: gcd
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


module gcd#( parameter W = 8 )
(
     input clk,
 
     // Data signals
     input [W-1:0] operands_bits_A,
     input [W-1:0] operands_bits_B,
     output [W-1:0] result_bits_data,
 
     // Control signals
     input input_available,
     input reset,
     output result_rdy,
     input result_taken
);
     wire A_en, B_en, B_mux_sel, B_zero, A_lt_B;
     wire [1:0] A_mux_sel;
     
     // Data path
     gcdDataPath#( W ) data(
         clk,
         operands_bits_A,
         operands_bits_B,
         result_bits_data,
         
         A_en,
         B_en,
         A_mux_sel,
         B_mux_sel,
         
         B_zero,
         A_lt_B
        ); 
     
     // control path   
     gcdControlPath control(
         clk,
         reset,
       
         input_available,
         result_rdy,
         result_taken,
       
         A_en,
         B_en,
         A_mux_sel,
         B_mux_sel,
       
         B_zero,
         A_lt_B
    );

endmodule
