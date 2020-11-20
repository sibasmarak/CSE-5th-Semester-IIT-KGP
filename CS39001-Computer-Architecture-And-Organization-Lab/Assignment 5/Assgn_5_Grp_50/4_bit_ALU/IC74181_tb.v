`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2020 19:57:02
// Design Name: 
// Module Name: IC74181_tb
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


module IC74181_tb;
    reg [3:0] a = 0, b = 0, s = 0;
    reg _c_n=1, m=0;
    wire [3:0] f;
    wire _c_n_4, a_eq_b, g, p;
    
    IC74181 ic(
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
            #5 a=6; b=2; s=4'b0000;
            #50 a=6; b=2; s=4'b0001;
            #50 a=6; b=2; s=4'b0010;
            #50 a=6; b=2; s=4'b0011;
            #50 a=6; b=2; s=4'b0100;
            #50 a=6; b=2; s=4'b0101;
            #50 a=6; b=2; s=4'b0110;
            #50 a=6; b=2; s=4'b0111;
            #50 a=6; b=2; s=4'b1000;
            #50 a=6; b=2; s=4'b1001;
            #50 a=6; b=2; s=4'b1010;
            #50 a=6; b=2; s=4'b1011;
            #50 a=6; b=2; s=4'b1100;
            #50 a=6; b=2; s=4'b1101;
            #50 a=6; b=2; s=4'b1110;
            #50 a=6; b=2; s=4'b1111;
            #50 m = 1;
            a=6; b=2; s=4'b0000;
            #50 a=6; b=2; s=4'b0001;
            #50 a=6; b=2; s=4'b0010;
            #50 a=6; b=2; s=4'b0011;
            #50 a=6; b=2; s=4'b0100;
            #50 a=6; b=2; s=4'b0101;
            #50 a=6; b=2; s=4'b0110;
            #50 a=6; b=2; s=4'b0111;
            #50 a=6; b=2; s=4'b1000;
            #50 a=6; b=2; s=4'b1001;
            #50 a=6; b=2; s=4'b1010;
            #50 a=6; b=2; s=4'b1011;
            #50 a=6; b=2; s=4'b1100;
            #50 a=6; b=2; s=4'b1101;
            #50 a=6; b=2; s=4'b1110;
            #50 a=6; b=2; s=4'b1111;
            #50 $finish;
        end
endmodule
