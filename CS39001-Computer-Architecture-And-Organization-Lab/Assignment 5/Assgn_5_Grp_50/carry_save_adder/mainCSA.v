`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 16:32:14
// Design Name: 
// Module Name: mainCSA
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

module carrysaveadder916(
    input [15:0] a1,                    // first 16-bit number
    input [15:0] a2,                    // second 16-bit number
    input [15:0] a3,                    // third 16-bit number
    input [15:0] a4,                    // fourth 16-bit number
    input [15:0] a5,                    // fifth 16-bit number
    input [15:0] a6,                    // sixth 16-bit number
    input [15:0] a7,                    // seventh 16-bit number
    input [15:0] a8,                    // eighth 16-bit number
    input [15:0] a9,                    // ninth 16-bit number
    output [19:0] sout,                 // 20 bit output
    output cout                         // carry output if any
);
    
    // the top most Or first layer of Wallace Tree
    wire [16:0] c1, s1, c2, s2, c3, s3;
    carrysaveadder1617 csa1 (a1, a2, a3, c1, s1);
    carrysaveadder1617 csa2 (a4, a5, a6, c2, s2);
    carrysaveadder1617 csa3 (a7, a8, a9, c3, s3);
    
    // the second layer of Wallace Tree
    wire [17:0] C1, S1, C2, S2;
    carrysaveadder1718 csa4 (c1, c2, c3, C1, S1);
    carrysaveadder1718 csa5 (s1, s2, s3, C2, S2);
    
    // the third layer of Wallace Tree
    wire [18:0] carry, sum;
    carrysaveadder1819 csa6 (C1, C2, S1, carry, sum);
    
    // the last layer of Wallace Tree
    wire [19:0] carr, SUM;
    wire [18:0] inp;
    assign inp = {1'b0, S2};
    carrysaveadder1920 csa7 (carry, sum, inp, carr, SUM);
    
    // the call to Hybrid Adder to evaluate the final answer
    hybrid_adder ha(carr, SUM, 1'b0, sout, cout);

endmodule
