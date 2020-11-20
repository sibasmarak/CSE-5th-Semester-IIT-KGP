`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 21:07:38
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
// Assignment No.: 5
// Problem No.: 3 [Carry-Select Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
    
    // preparing the inputs
    reg [15:0] a = 16'b1001100110011001;
    reg [15:0] b = 16'b1001111111111111;
    reg cin = 0;

    // preparing the outputs
    wire [15:0] sum;
    wire cout;


    carry_select_adder_16bit csa16 (a, b, cin, sum, cout);
    
    initial
    begin
    #5 a = 16'b1001100110011001; b = 16'b1001100110011111;
    #5 a = 16'b1001100111111101; b = 16'b1011110110011001;
    #10 $finish;
    end
    
endmodule
