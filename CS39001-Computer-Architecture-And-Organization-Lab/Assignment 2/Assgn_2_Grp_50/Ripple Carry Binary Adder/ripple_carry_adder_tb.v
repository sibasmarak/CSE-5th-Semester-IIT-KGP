`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 22:06:13
// Design Name: 
// Module Name: eightBitAdderTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 2
// Problem No.: 1 [Ripple Carry Binary Adder]
// Semester No.: 5
// Group No.: G50
// Group Members:  Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////

module eightBitAdderTB;
    // define the input and output
    reg [7:0] A = 8'b00000001, B = 8'b00000001;
    reg c_in = 1'b0;
    wire [7:0] s;
    wire c_out;

    ripple_carry_adder mut (.a(A), .b(B), .cin(c_in), .sum(s), .cout(c_out));
    initial
    begin
        $monitor ("A = [%d], B = [%d], carry_in = [%d], carry = [%d], sum = [%d]", A, B, c_in, c_out, s);
        #5 A = 8'b00000010; B = 8'b00000011;
        #5 A = 8'b10000000; B = 8'b10000001;
        #5 A = 8'b00001001; B = 8'b01001010;
        #5 $finish;
    end
endmodule