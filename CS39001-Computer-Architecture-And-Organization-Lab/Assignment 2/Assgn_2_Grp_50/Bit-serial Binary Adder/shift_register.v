`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2020 15:30:01
// Design Name: 
// Module Name: shift_register
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


module shift_register(
    output reg out,
    input [7:0] data,
    input clk,
    input load,
    input rst,
    input enable
    );
    
    // the following module acts as a PISO register(parallel input serial output)
    
    // memory stores the last value(flip flop)
    reg [7:0] mem;
    
    always @ (posedge clk, posedge rst) begin
        if (rst)
            // reset the values 
            begin
              out <= 0;
              mem <= 0;
            end
        else if(load)
            
            // load new values in the memory
            begin
                mem <= data;
                out <= 0;
            end
        else if (enable) 
            begin
                // one by one extract the LSB and shift the rest of the characters
                out = mem[0];
                mem = mem >> 1;
            end
      end
    
endmodule
