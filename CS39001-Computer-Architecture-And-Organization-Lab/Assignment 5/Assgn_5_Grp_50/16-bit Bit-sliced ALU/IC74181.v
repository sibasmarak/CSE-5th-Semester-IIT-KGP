`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2020 18:27:28
// Design Name: 
// Module Name: IC74181
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


module IC74181(
    input [3:0] A,
    input [3:0] B,
    input [3:0] S,
    output [3:0] F,
    input M,
    input _C_n,
    output _C_n_4,
    output A_eq_B,
    output G,
    output P
    );
    // Active High Implementation
    wire C_n, cout;
    wire [3:0] sum;
    reg C_n_4;
    reg [3:0] a, b, f;
    assign C_n = ~_C_n;
    
    // Design is implemented according to the data sheet attached Page 2
    always @(*)
        if(M==1'b1) begin
            a = 0;
            b = 0;
            C_n_4 = 0;
            case(S)
                // following are the output of the logic operations
                4'b0000: f = ~A;
                4'b0001: f = ~A | ~B;
                4'b0010: f = ~A & B;
                4'b0011: f = 0;
                4'b0100: f = ~A & ~B;
                4'b0101: f = ~B;
                4'b0110: f = A ^ B;
                4'b0111: f = A & ~B;
                4'b1000: f = ~A | B;
                4'b1001: f = ~A ^ ~B;
                4'b1010: f = B;
                4'b1011: f = A & B;
                4'b1100: f = 1;
                4'b1101: f = A | ~B;
                4'b1110: f = A | B;
                4'b1111: f = A;
            endcase
        end
        else begin
            case(S)
                // following are the output of the arithmetic operations
                4'b0000: begin
                            a = A;
                            b = 0;
                         end
                4'b0001: begin
                            a = A | B;
                            b = 0;
                         end
                4'b0010: begin
                            a = A | ~B;
                            b = 0;
                         end
                4'b0011: begin
                            a = -1;
                            b = 0;
                         end
                4'b0100: begin
                            a = A;
                            b = A & ~B;
                         end
                4'b0101: begin
                            a = A | B;
                            b = A & ~B;
                         end
                4'b0110: begin
                            a = A - 1;
                            b = -B;
                         end
                4'b0111: begin
                            a = A & B;
                            b = -1;
                         end
                4'b1000: begin
                            a = A;
                            b = A & B;
                         end
                4'b1001: begin
                            a = A;
                            b = B;
                         end
                4'b1010: begin
                            a = A | ~B;
                            b = A & B;
                         end
                4'b1011: begin
                            a = A & B;
                            b = -1;
                         end
                4'b1100: begin
                            a = A;
                            b = A;
                         end
                4'b1101: begin
                            a = A | B;
                            b = A;
                         end
                4'b1110: begin
                            a = A | ~B;
                            b = A;
                         end
                4'b1111: begin
                            a = A;
                            b = -1;
                         end
            endcase
            C_n_4 = cout;
            f = sum;
        end
        
    // carry look ahead adder for the arithmetic addition
    cla_4_bit adder(sum, cout, G, P, a, b, C_n);
    
    // continuous assignm,ent statements
    assign _C_n_4 = ~C_n_4;         // assign the negation of carry out
    assign A_eq_B = ( A == B );     // set the flag if A == B
    assign F = ~f;                  // set the complemented output
endmodule
