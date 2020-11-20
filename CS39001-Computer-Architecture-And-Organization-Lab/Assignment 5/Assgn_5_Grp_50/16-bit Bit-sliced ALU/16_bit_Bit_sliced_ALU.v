`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2020 20:13:12
// Design Name: 
// Module Name: 16_bit_Bit_sliced_ALU
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


module bit_16_Bit_sliced_ALU(
    input [15:0] A,
    input [15:0] B,
    input [3:0] S,
    output [15:0] F,
    input M,
    input _C_n,
    output _C_n_4,
    output A_eq_B,
    output G,
    output P
    );
    
    wire [3:0] g, p, a_eq_b;
    wire [2:0] _c_n_4;

    /**
      * Following are thinstantiations of the sub modules each
      * of which is an 4 bit IC 74181 which have been joined to 
      * form a 16 bit ALU
      */
    IC74181 a(A[3:0],B[3:0],S,F[3:0],M,_C_n,_c_n_4[0],a_eq_b[0],g[0],p[0]);
    IC74181 b(A[7:4],B[7:4],S,F[7:4],M,_c_n_4[0],_c_n_4[1],a_eq_b[1],g[1],p[1]);
    IC74181 c(A[11:8],B[11:8],S,F[11:8],M,_c_n_4[1],_c_n_4[2],a_eq_b[2],g[2],p[2]);
    IC74181 d(A[15:12],B[15:12],S,F[15:12],M,_c_n_4[2],_C_n_4,a_eq_b[3],g[3],p[3]);
    
    // Explicitly calculating the parameters for the 16-bit circuit
    assign A_eq_B = a_eq_b[0] & a_eq_b[1] & a_eq_b[2] & a_eq_b[3];
    assign P = p[0] & p[1] & p[2] & p[3];
    assign G = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]);
    
endmodule
