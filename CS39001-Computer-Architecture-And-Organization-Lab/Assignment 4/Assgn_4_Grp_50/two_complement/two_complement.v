`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2020 09:39:43
// Design Name: 
// Module Name: complement
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 4
// Problem No.: 1 [Two’s Complement Converter FSM]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////

// Mealy machine for converting the input (arriving from LSB) to 2's complement

module complement(
    output reg out,                             // output bit
    input inp,                                  // input but; arrives from LSB 
    input reset,                                // reset bit
    input clk                                   // clock
);
reg PS, NS;                                     // define present state (PS) and next state (NS)
    always @(posedge clk) begin
        PS = NS;                                // transfer the NS to PS
        if (reset) begin                        // if reset is true, reset the mealy machine
            out = 0;                            // assign 0 to out
            NS = 0;                             // assign 0 to new state
        end else begin
            case (PS)                           // transfer control with respect to Present State
                0: begin                        // if present state is 0
                    out = (inp) ? 1 : 0;        // if input bit is 1, then output bit is 1, else 0
                    NS = (inp) ? 1 : 0;         // if input bit is 1, then new state is 1, else 0 
                end 
                1: begin                        // if present state is 1
                    out = (inp) ? 0 : 1;        // if input bit is 1, then output bit is 0, else 1
                    NS = 1;                     // always remains in the state 1 
                end
            endcase
        end
    end
endmodule

