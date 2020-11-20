`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2020 04:01:17
// Design Name: 
// Module Name: unsigned_array_mult_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 3
// Problem No.: 1 [Combinational Unsigned Binary Multiplier (Array Multiplier)] 
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////

module unsigned_array_mult_tb;
    reg [5:0]a = 0, b = 0;
    wire [11:0] c;
    
    unsigned_array_mult u(
                            .a(a),
                            .b(b),
                            .product(c)
                            );
    
    initial begin
        #50 a=100101; b = 101010;
        #50 a=101001; b = 100110;
        #50 a=111111; b = 000001;
        #50 a=100000; b = 100000;
        #50 $finish;
    end
    
endmodule
