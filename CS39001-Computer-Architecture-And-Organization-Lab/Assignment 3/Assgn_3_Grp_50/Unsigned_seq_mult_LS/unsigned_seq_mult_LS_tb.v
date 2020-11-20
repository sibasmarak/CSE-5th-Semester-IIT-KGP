`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2020 01:38:52
// Design Name: 
// Module Name: sequential_unsigned_binary_multiplier_left_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 3
// Problem No.: 2 [Sequential Unsigned Binary Multiplier (left-shift version)] 
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////


module unsigned_seq_mult_LS_tb;
    
    reg [5:0] a, b;
    reg clk = 0, load = 0, rst = 0;
    wire [11:0] prod;
    
    unsigned_seq_mult_LS m1(
                                                .clk(clk),
                                                .rst(rst),
                                                .load(load),
                                                .a(a),
                                                .b(b),
                                                .product(prod)
                                               );
    
    always #25 clk = ~clk;
    
    initial begin
        #25 rst = 1;
        #30 rst = 0; 
        #25 load = 1; a = 63; b= 62;
        #50 load = 0;
        #650 $finish;
    end
    
endmodule
