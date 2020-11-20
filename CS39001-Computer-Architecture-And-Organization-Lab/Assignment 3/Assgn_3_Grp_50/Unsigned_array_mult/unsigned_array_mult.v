`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2020 02:53:49
// Design Name: 
// Module Name: unsigned_array_mult
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

module unsigned_array_mult(
    input [5:0] a,                  // first unsigned binary number
    input [5:0] b,                  // second unsigned binary number
    output reg [11:0] product       // product of a and b
    );
    reg w[50:0];
    
    always @(a, b) begin
        product[0] = a[0] & b[0];
        
        {w[0], product[1]} = (a[1] & b[0]) + (a[0] & b[1]);     // obtain the last bit (LSB) of the product
        
        {w[3], w[1]} = (a[2] & b[0]) + (a[1] & b[1]) + w[0];
        {w[4], product[2]} = (a[0] & b[2]) + w[1];              // obtain the second last bit of the product
            
        {w[7], w[5]} = (a[3] & b[0]) + (a[2] & b[1]) + w[3];
        {w[8], w[6]} = (a[1] & b[2]) + w[5] + w[4]; 
        {w[9], product[3]} = (a[0] & b[3]) + w[6];              // obtain the third last bit of the product
        
        {w[13], w[10]} = (a[4] & b[0]) + (a[3] & b[1]) + w[7];
        {w[14], w[11]} = (a[2] & b[2]) + w[10] + w[8]; 
        {w[15], w[12]} = (a[1] & b[3]) + w[11] + w[9];
        {w[16], product[4]} = (a[0] & b[4]) + w[12];            // obtain the fourth last bit of the product
        
        {w[21], w[17]} = (a[5] & b[0]) + (a[4] & b[1]) + w[13];
        {w[22], w[18]} = (a[3] & b[2]) + w[17] + w[14]; 
        {w[23], w[19]} = (a[2] & b[3]) + w[18] + w[15]; 
        {w[24], w[20]} = (a[1] & b[4]) + w[19] + w[16];
        {w[25], product[5]} = (a[0] & b[5]) + w[20];            // obtain the fifth last bit of the product
        
        {w[30], w[26]} = (a[5] & b[1]) + w[21] + w[22];
        {w[31], w[27]} = (a[4] & b[2]) + w[23] + w[26];
        {w[32], w[28]} = (a[3] & b[3]) + w[24] + w[27]; 
        {w[33], w[29]} = (a[2] & b[4]) + w[25] + w[28];
        {w[34], product[6]} = (a[1] & b[5]) + w[29];            // obtain the sixth last bit of the product
        
        {w[38], w[35]} = (a[5] & b[2]) + w[30] + w[31];
        {w[39], w[36]} = (a[4] & b[3]) + w[32] + w[35];
        {w[40], w[37]} = (a[3] & b[4]) + w[33] + w[36];
        {w[41], product[7]} = (a[2] & b[5]) + w[34] + w[37];    // obtain the seventh last bit of the product
        
        {w[44], w[42]} = (a[5] & b[3]) + w[38] + w[39];
        {w[45], w[43]} = (a[4] & b[4]) + w[40] + w[42];
        {w[46], product[8]} = (a[3] & b[5]) + w[41] + w[43];    // obtain the fourth bit from first of the product
        
        {w[48], w[47]} = (a[5] & b[4]) + w[44] + w[45];
        {w[49], product[9]} = (a[4] & b[5]) + w[46] + w[47];    // obtain the third bit from first of the product
        
        {w[50], product[10]} = (a[5] & b[5]) + w[48] + w[49];   // obtain the second bit from first of the product
        
        product[11] = w[50];                                    // obtain the first bit (MSB) of the product
    end
endmodule
