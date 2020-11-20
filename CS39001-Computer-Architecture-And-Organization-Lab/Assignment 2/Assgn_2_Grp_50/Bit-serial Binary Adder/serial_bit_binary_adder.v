`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2020 15:34:28
// Design Name: 
// Module Name: serial_bit_binary_adder
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


module serial_bit_binary_adder(
    output reg [7:0] out,
    output reg cout,
    input [7:0] A_in,
    input [7:0] B_in,
    input load,
    input clk,
    input rst
    );
    
      reg [4:0] count;
      reg enable;
      wire wire_a, wire_b, cout_temp, cin, sum;
    
      // following module extracts each bit of A_in one by one
      shift_register ma(wire_a, A_in, clk, load, rst, enable);
      
      // following module extracts each bit of B_in one by one
      shift_register mb(wire_b, B_in, clk, load, rst, enable);
      
      // following module is used to calculate the sum
      full_adder madd(sum, cout_temp, wire_a, wire_b, cin);
      
      // the following module is used for implementing the sequential logic
      d_flip_flop dff(cin, cout_temp, clk, rst, enable);
      
      always @ (posedge clk, posedge rst) begin
        // if the rst or load signal is high update the following
        if (rst || load) begin
          enable = 1; 
          count = 0; 
          out = 0;
        end
        else begin
          // counter to check whether 8 clock cycle sre complete or not
          if (count > 4'b1000)
            enable = 0;
          else begin
            // enable signal refers to whether the sum mechanism is inactive or active
            if (enable) begin
              // update the cout
              cout = cout_temp;
              
              // increment the counter
              count = count + 1;
              
              // shift the current value of out before updating
              out = out >> 1;
              
              // update the current value of sum
              out[7] = sum;
            end
          end
        end
      end
    
endmodule
