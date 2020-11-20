`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2020 14:01:26
// Design Name: 
// Module Name: tb
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
// Problem No.: 3 [Sequential Unsigned Binary Multiplier (right-shift version)] 
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


module unsigned_seq_mult_RS_tb;
    
    reg [5:0] a, b;
    reg clk = 0, load = 0, rst = 0;
    wire [11:0] prod;
    
    unsigned_seq_mult_RS m1(
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
