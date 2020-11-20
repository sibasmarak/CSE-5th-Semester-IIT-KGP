`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2020 15:47:34
// Design Name: 
// Module Name: serial_bit_binary_adder_tb
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
// Problem No.: 3 [Bit-serial Binary Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////


module serial_bit_binary_adder_tb;
    reg clk = 0, rst = 0, load = 0;    
    reg [7:0] a, b;
    wire [7:0] sum;
    wire carry;
    
    
    serial_bit_binary_adder m(
                                .A_in(a), 
                                .B_in(b), 
                                .clk(clk), 
                                .rst(rst), 
                                .load(load), 
                                .out(sum), 
                                .cout(carry)
                              );
    
    always #40 clk = ~clk;
    
    initial begin
        #40 rst = 1; #40 rst = 0;
        #40 load = 1;
        a = 8'b10001011;
        b = 8'b10000101;
        #40 load = 0;
        #760 load = 1;
        #20 $finish;
    end    
endmodule
