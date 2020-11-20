`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2020 14:42:47
// Design Name: 
// Module Name: gcd_tb
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



module gcd_tb;
    reg [7:0] A = 0, B = 0;
    reg load = 0, rst = 0, clk = 0, taken = 0;
    wire [7:0] C;
    wire ready;
    
    gcd#(8) m(
        .clk(clk),
        
        .operands_bits_A(A),
        .operands_bits_B(B),
        .result_bits_data(C),
        
        .input_available(load),
        .reset(rst),
        .result_rdy(ready),
        .result_taken(taken)
    );
    
    always #50 clk = ~clk;
    
    initial
        begin
            #30 rst = 1;
            #100 rst = 0;load = 1; A = 12; B = 16;
            #1000 $finish;
        end
endmodule