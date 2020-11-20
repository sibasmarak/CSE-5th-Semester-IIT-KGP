`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2020 21:46:25
// Design Name: 
// Module Name: 16_bit_ALU_tb
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
// Problem No.: 2 [16-bit Bit-sliced ALU]
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069) 
// 
//////////////////////////////////////////////////////////////////////////////////


module bit_16_ALU_tb;
    reg [15:0] a = 0, b = 0;
    reg [3:0] s = 0;
    reg _c_n=1, m=0;
    wire [15:0] f;
    wire _c_n_4, a_eq_b, g, p;
    
    bit_16_Bit_sliced_ALU ic(
                .A(a),
                .B(b),
                .S(s),
                .F(f),
                .M(m),
                ._C_n(_c_n),
                ._C_n_4(_c_n_4),
                .A_eq_B(a_eq_b),
                .G(g),
                .P(p)
                );
                
    initial
        begin 
            #100 a=16; b=2; s=4'b0000;
            #100 a=16; b=2; s=4'b0001;
            #100 a=16; b=2; s=4'b0010;
            #100 a=16; b=2; s=4'b1001;
            #100 a=16; b=2; s=4'b1111;

            #50 $finish;
        end
endmodule
