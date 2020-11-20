`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2020 16:42:18
// Design Name: 
// Module Name: three_multiple
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
// Problem No.: 2 [Multiple-of-three Detector FSM]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////


// Mealy machine for converting the input (arriving from LSB) to 2's complement

module three_multiple(
    output reg out,                             // output bit
    input inp,                                  // input but; arrives from LSB 
    input reset,                                // reset bit
    input clk                                   // clock
);
reg [1:0] PS, NS;                               // define present state (PS) and next state (NS)
parameter S0 = 0, S1 = 1, S2 = 2;               // define states                                   
    always @(posedge clk) begin
        PS = NS;                                // transfer the NS to PS
        if (reset) begin                        // if reset is true, reset the mealy machine
            out = 0;                            // assign 0 to out
            NS = S0;                            // assign 0 to new state
        end else begin
            case (PS)                           // transfer control with respect to Present State
                S0: begin                       // if present state is 0
                    case (inp)                  // move to certain NS depending on input
                        0: begin                // if input is 0           
                            out = 1;            // output is 1
                            NS = S0;            // next state is S0
                            end
                        1: begin                // if input is 1            
                            out = 0;            // output is 0
                            NS = S1;            // next state is S1
                            end  
                    endcase 
                end 
                S1: begin                       // if present state is 1
                    case (inp)                  // move to certain NS depending on input                                
                        0: begin                // if input is 0
                            out = 0;            // output is 0
                            NS = S2;            // next state is S2
                            end
                        1: begin                // if input is 1
                            out = 1;            // output is 1
                            NS = S0;            // next state is S0
                            end  
                    endcase 
                end 
                S2: begin                       // if present state is 2
                    case (inp)                  // move to certain NS depending on input  
                        0: begin                // if input is 0
                            out = 0;            // output is 0
                            NS = S1;            // next state is S1 
                            end
                        1: begin                // if input is 1
                            out = 0;            // output is 0          
                            NS = S2;            // next state is S2
                            end  
                    endcase 
                end 
            endcase
        end
    end
endmodule
