`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2020 14:50:04
// Design Name: 
// Module Name: gcdDatapath
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


module gcdDataPath#( parameter W = 8 )
(
    input clk,

    // Data signals
    input [W-1:0] operands_bits_A,
    input [W-1:0] operands_bits_B,
    output [W-1:0] result_bits_data,

    // Control signals (ctrl->dpath)
    input A_en,
    input B_en,
    input [1:0] A_mux_sel,
    input B_mux_sel,

    // Control signals (dpath->ctrl)
    output B_zero,
    output A_lt_B
);
        
    wire [W-1:0] A;
    wire [W-1:0] B;
    wire [W-1:0] sub_out;
    wire [W-1:0] A_mux_out;
    wire [W-1:0] B_mux_out;
    
    mux_3in#(W) A_mux
    (
     .in0 (operands_bits_A),
     .in1 (B),
     .in2 (sub_out),
     .sel (A_mux_sel),
     .out (A_mux_out)
    ); 
    
    EDFF#(W) A_ff
    (
     .clk (clk),
     .en (A_en),
     .D (A_mux_out),
     .Q (A)
    ); 
    
    mux_2in#(W) B_mux
    (
     .in0 (operands_bits_B),
     .in1 (A),
     .sel (B_mux_sel),
     .out (B_mux_out)
    ); 
    
    EDFF#(W) B_ff
    (
     .clk (clk),
     .en (B_en),
     .D (B_mux_out),
     .Q (B)
    ); 
    
    initial $monitor("%d",A);
    assign B_zero = ( B == 0 );
    assign A_lt_B = ( A < B );
    assign sub_out = A - B;
    assign result_bits_data = A; 

endmodule