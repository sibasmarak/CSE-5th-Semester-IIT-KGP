`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2020 11:32:08
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
// Assignment No.: 4
// Problem No.: 1 [Two’s Complement Converter FSM]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
reg clk = 1, rst = 0, inp;
wire out;

always #40 clk = ~clk;

complement c (out, inp, rst, clk);
initial
begin
   rst = 1; 
   #40 rst = 0; 
   #40 inp = 0;
   #80 inp = 0;
   #80 inp = 1;
   #80 inp = 0;
   #80 inp = 1; 
   #80 $finish; 
   
end
endmodule
