`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2020 01:22:19
// Design Name: 
// Module Name: sequential_unsigned_binary_multiplier_left
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
// Problem No.: 2 [Sequential Unsigned Binary Multiplier (left-shift version)] 
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////


module unsigned_seq_mult_LS(
    input clk,
    input rst,                      // information on resetting the inputs
    input load,                     // information on parallel loading of the inputs
    input [5:0] a,                  // first unsigned binary number
    input [5:0] b,                  // second unsigned binary number
    output reg [11:0] product       // the product of a and b
    );
    
    reg [11:0] P, X, Y;             // temporary variables to help in computation
    reg [3:0] counter;              // counter to disable the operation after a fixed number of cycles
    reg enable;                     // enable to allow the multiplication operation, else disable
    
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
                if(X[0])            //  if the LSB of X is 1
                    P = P + Y;      // assign the sum of Y and P to P
                Y <= Y << 1;        // left shift Y, preparing Y for the next clock cycle
                X <= X >> 1;        // right shift X, preparing X for the next clock cycle
                product <= P;       // assign the current result to output product
                counter <= counter + 1;     // increment the counter
            end
        end
    end
    
endmodule
