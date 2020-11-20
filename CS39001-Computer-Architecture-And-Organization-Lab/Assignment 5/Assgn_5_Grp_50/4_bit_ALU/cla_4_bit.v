`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2020 19:16:30
// Design Name: 
// Module Name: cla_4_bit
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
// Problem No.: 1 [4-bit Combinational ALU]
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069) 
// 
//////////////////////////////////////////////////////////////////////////////////


module cla_4_bit(
    output [3:0] out,
    output C_out,
    output GG,
    output PG,
    input [3:0] a,
    input [3:0] b,
    input C_in
    );
    wire [3:0] g, p, c;
    assign g = a & b;
    assign p = a ^ b;
    
    assign c[0] = C_in;
    assign c[1] = g[0] | (p[0] & C_in);
    assign c[2] = g[1] | (g[0] & p[1]) | (C_in & p[0] & p[1]);
    assign c[3] = g[2] | (g[1] & p[2]) | (g[0] & p[1] & p[2]) | (C_in & p[0] & p[1] & p[2]);
    assign C_out = g[3] | (g[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[0] & p[1] & p[2] & p[3]) | (C_in & p[0] & p[1] & p[2] & p[3]);
    
    assign out = p ^ c;
    assign GG = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]);
    assign PG = p[0] & p[1] & p[2] & p[3];
endmodule