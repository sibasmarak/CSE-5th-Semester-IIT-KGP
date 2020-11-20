`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 16:57:33
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
// Problem No.: 4 [Carry-Save Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
    
    // preparing the inputs
    reg [15:0] a1 = 16'b1111111111111111;
    reg [15:0] a2 = 16'b1111111111111111;
    reg [15:0] a3 = 16'b1111111111111111;
    reg [15:0] a4 = 16'b1111111111111111;
    reg [15:0] a5 = 16'b1111111111111111;
    reg [15:0] a6 = 16'b1111111111111111;
    reg [15:0] a7 = 16'b1111111111111111;
    reg [15:0] a8 = 16'b1111111111111111;
    reg [15:0] a9 = 16'b1111111111111111;
    
    // preparing the outputs
    wire [19:0] sout;
    wire cout;
    
    carrysaveadder916 mut(a1, a2, a3, a4, a5, a6, a7, a8, a9, sout, cout);
    initial
    begin
    // if interested, add other 9 - 16 bits numbers to add
    // else change the initialization above
    #5
        a1 = 16'b1111111111111111;
        a2 = 16'b1011111111111111;
        a3 = 16'b1001111111111111;
        a4 = 16'b1000111111111111;
        a5 = 16'b1000011111111111;
        a6 = 16'b1000001111111111;
        a7 = 16'b1000000111111111;
        a8 = 16'b1000000011111111;
        a9 = 16'b1000000001111111;
    #10 $finish;
    end

endmodule
