`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2020 13:25:26
// Design Name: 
// Module Name: code
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
// Problem No.: 3 [Sequential Unsigned Binary Multiplier (right-shift version)] 
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


module unsigned_seq_mult_RS(
    input clk,                      
    input rst,                      // information on resetting the inputs
    input load,                     // information on parallel loading of the inputs
    input [5:0] a,                  // first unsigned binary number
    input [5:0] b,                  // second unsigned binary number
    output reg [11:0] product       // the product of a and b
    );
    
    reg [11:0] P, X, Y;             // temporary variables to help in computation
    reg [3:0] counter;              // counter to disable the operation after a fixed number of cycles
    reg enable, carry = 0;          // enable to allow the multiplication operation, else disable
                                    // carry is the carry of the sum of two binary numbers
    always @(posedge clk)
    begin
        if(rst) begin               // if reset is true
            X <= 0;                 // assign 0 to X
            Y <= 0;                 // assign 0 to Y
            P <= 0;                 // assign 0 to P
            enable <= 1;            // enable for future operations
            counter <= 0;           // intitalize counter for future operations
        end
        else if(load) begin         // if load is true
            X <= a;                 // assign a to X
            Y <= b;                 // assign b to Y
            P <= 0;                 // assign 0 to P
            enable <= 1;            // enable for future operations
            counter <= 0;           // intitalize counter for future operations
        end
        else if(counter>6)          // if counter is greater than fixed number of cycles required
           enable <= 0;             // disallow the multiplication operation
        else begin
            if(enable) begin        // if enable or multiplication is allowed
            	carry <= 0;
                if(X[0])                                // if the LSB of X is 1
                    {carry, P[11:6]} = P[11:6] + Y;     // use the algorithm to find the carry and sum of P and Y
                X <= X >> 1;                            // right shift X
                P <= {carry, P[11:1]};                  // right shift P with the help of carry produced
                product = P;                            // assign the current result to output product
                counter <= counter + 1;                 // increment the counter
            end
        end
    end  
endmodule

