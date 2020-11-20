`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2020 20:38:52
// Design Name: 
// Module Name: gcdControlpath
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
// Problem No.: 3 [Sequential GCD Calculator]
// Semester No.: 5
// Group No.: G50
// Group Members: Debajyoti Dasgupta (18CS30051) & Siba Smarak Panigrahi (18CS10069)
// 
//////////////////////////////////////////////////////////////////////////////////


module gcdControlPath(
         input clk,
         input reset,
       
         // Data signals
         input input_available,
         output reg result_rdy,
         input result_taken,
       
         // Control signals (ctrl->dpath)
         output reg A_en,
         output reg B_en,
         output reg [1:0] A_mux_sel,
         output reg B_mux_sel,
       
         // Control signals (dpath->ctrl)
         input B_zero,
         input A_lt_B
    );
    
    // three states - WAIT, CALC, and DONE
    localparam WAIT = 2'd0;
    localparam CALC = 2'd1;
    localparam DONE = 2'd2;
    
    reg [1:0] state_next;
    wire [1:0] state;
    
    // call the reset DFF
    RDFF state_ff
    (
     .clk (clk),
     .reset (reset),
     .D (state_next),
     .Q (state)
    ); 
    
    always @(*)
        begin
            // Default
            A_en = 1'b0;
            B_en = 1'b0;
            result_rdy = 1'b0;
                
                case ( state )
                    WAIT :                                              // if present state (PS) is wait
                        begin
                            A_mux_sel = 0;                              
                            A_en = 1'b1;
                            B_mux_sel = 0;
                            B_en = 1'b1;
                        end
                    CALC :                                              // if PS is CALC
                        begin
                            if ( A_lt_B ) begin                         // if A less than B
                                A_mux_sel = 1;
                                A_en = 1'b1;
                                B_mux_sel = 1;
                                B_en = 1'b1;
                            end
                            else if ( !B_zero ) begin                   // if B is not zero
                                A_mux_sel = 2;
                                A_en = 1'b1;
                            end
                        end
                    DONE :                                              // if PS is DONE (result is ready)
                        result_rdy = 1'b1;
                endcase
        end          
        
        always @(*)
        begin
        // Default is to stay in the same state
        state_next = state;
        case ( state )
            WAIT :
                if ( input_available )                                  // if present state (PS) is WAIT and input is available 
                state_next = CALC;                                      // then next state (NS) is CALC
            CALC :
                if ( B_zero )                                           // if PS is CALC and B_zero is True
                state_next = DONE;                                      // then NS is DONE
            DONE :
                if ( result_taken )                                     // if PS is DONE and result taken is True
                state_next = WAIT;                                      // then NS is WAIT
        endcase
        end 
        
       initial $monitor("state=%d, next state=%d",state, state_next);   // print the current state and next state
endmodule
