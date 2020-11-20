`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2020 14:57:26
// Design Name: 
// Module Name: carrysaveadder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Assignment No.: 5
// Problem No.: 4 [Carry-Save Adder]
// Semester No.: 5
// Group No.: G50
// Group Members: Siba Smarak Panigrahi (18CS10069) & Debajyoti Dasgupta (18CS30051)
// 
//////////////////////////////////////////////////////////////////////////////////

// carry save adder module: first layer of Wallace Tree
// input is 16 bits
// output is 17 bits
module carrysaveadder1617(
    input [15:0] a,             // first 16-bit input
    input [15:0] b,             // second 16-bit input
    input [15:0] c,             // third 16-bit input      
    output [16:0] C,            // 17-bit carry output
    output [16:0] S             // 17-bit sum output
    );
    
    fullAdder fa(1'b0, 1'b0, 1'b0, C[0], S[16]);                            // both MSB and LSB of sum and carry are 0

    // evaluate the sum bits and carry bits with the aid of fullAdders 
    fullAdder fa1(a[0], b[0], c[0], C[1], S[0]);
    fullAdder fa2(a[1], b[1], c[1], C[2], S[1]);
    fullAdder fa3(a[2], b[2], c[2], C[3], S[2]);
    fullAdder fa4(a[3], b[3], c[3], C[4], S[3]);
    
    fullAdder fa5(a[4], b[4], c[4], C[5], S[4]);
    fullAdder fa6(a[5], b[5], c[5], C[6], S[5]);
    fullAdder fa7(a[6], b[6], c[6], C[7], S[6]);
    fullAdder fa8(a[7], b[7], c[7], C[8], S[7]);
    
    fullAdder fa9(a[8], b[8], c[8], C[9], S[8]);
    fullAdder fa10(a[9], b[9], c[9], C[10], S[9]);
    fullAdder fa11(a[10], b[10], c[10], C[11], S[10]);
    fullAdder fa12(a[11], b[11], c[11], C[12], S[11]);
    
    fullAdder fa13(a[12], b[12], c[12], C[13], S[12]);
    fullAdder fa14(a[13], b[13], c[13], C[14], S[13]);
    fullAdder fa15(a[14], b[14], c[14], C[15], S[14]);
    fullAdder fa16(a[15], b[15], c[15], C[16], S[15]);
    
endmodule

// carry save adder module: second layer of Wallace Tree
// input is 17 bits
// output is 18 bits
module carrysaveadder1718(
    input [16:0] a,                         // first 17-bit input
    input [16:0] b,                         // second 17-bit input
    input [16:0] c,                         // third 17-bit input      
    output [17:0] C,                        // 18-bit carry output
    output [17:0] S                         // 18-bit sum output
    );
    
    fullAdder fa(1'b0, 1'b0, 1'b0, C[0], S[17]);                            // both MSB and LSB of sum and carry are 0

    // evaluate the sum bits and carry bits with the aid of fullAdders 
    fullAdder fa1(a[0], b[0], c[0], C[1], S[0]);
    fullAdder fa2(a[1], b[1], c[1], C[2], S[1]);
    fullAdder fa3(a[2], b[2], c[2], C[3], S[2]);
    fullAdder fa4(a[3], b[3], c[3], C[4], S[3]);
    
    fullAdder fa5(a[4], b[4], c[4], C[5], S[4]);
    fullAdder fa6(a[5], b[5], c[5], C[6], S[5]);
    fullAdder fa7(a[6], b[6], c[6], C[7], S[6]);
    fullAdder fa8(a[7], b[7], c[7], C[8], S[7]);
    
    fullAdder fa9(a[8], b[8], c[8], C[9], S[8]);
    fullAdder fa10(a[9], b[9], c[9], C[10], S[9]);
    fullAdder fa11(a[10], b[10], c[10], C[11], S[10]);
    fullAdder fa12(a[11], b[11], c[11], C[12], S[11]);
    
    fullAdder fa13(a[12], b[12], c[12], C[13], S[12]);
    fullAdder fa14(a[13], b[13], c[13], C[14], S[13]);
    fullAdder fa15(a[14], b[14], c[14], C[15], S[14]);
    fullAdder fa16(a[15], b[15], c[15], C[16], S[15]);
    
    fullAdder fa17(a[16], b[16], c[16], C[17], S[16]);
    
endmodule

// carry save adder module: third layer of Wallace Tree
// input is 18 bits
// output is 19 bits
module carrysaveadder1819(
    input [17:0] a,                         // first 18-bit input
    input [17:0] b,                         // second 18-bit input
    input [17:0] c,                         // third 18-bit input
    output [18:0] C,                        // 19-bit carry output
    output [18:0] S                         // 19-bit sum output
    );
    
    fullAdder fa(1'b0, 1'b0, 1'b0, C[0], S[18]);                            // both MSB and LSB of sum and carry are 0

    // evaluate the sum bits and carry bits with the aid of fullAdders 
    fullAdder fa1(a[0], b[0], c[0], C[1], S[0]);
    fullAdder fa2(a[1], b[1], c[1], C[2], S[1]);
    fullAdder fa3(a[2], b[2], c[2], C[3], S[2]);
    fullAdder fa4(a[3], b[3], c[3], C[4], S[3]);
    
    fullAdder fa5(a[4], b[4], c[4], C[5], S[4]);
    fullAdder fa6(a[5], b[5], c[5], C[6], S[5]);
    fullAdder fa7(a[6], b[6], c[6], C[7], S[6]);
    fullAdder fa8(a[7], b[7], c[7], C[8], S[7]);
    
    fullAdder fa9(a[8], b[8], c[8], C[9], S[8]);
    fullAdder fa10(a[9], b[9], c[9], C[10], S[9]);
    fullAdder fa11(a[10], b[10], c[10], C[11], S[10]);
    fullAdder fa12(a[11], b[11], c[11], C[12], S[11]);
    
    fullAdder fa13(a[12], b[12], c[12], C[13], S[12]);
    fullAdder fa14(a[13], b[13], c[13], C[14], S[13]);
    fullAdder fa15(a[14], b[14], c[14], C[15], S[14]);
    fullAdder fa16(a[15], b[15], c[15], C[16], S[15]);
    
    fullAdder fa17(a[16], b[16], c[16], C[17], S[16]);
    fullAdder fa18(a[17], b[17], c[17], C[18], S[17]);
    
endmodule


// carry save adder module: fourth layer of Wallace Tree
// input is 19 bits
// output is 20 bits
module carrysaveadder1920(
    input [18:0] a,                         // first 19-bit input 
    input [18:0] b,                         // second 19-bit input
    input [18:0] c,                         // third 19-bit input
    output [19:0] C,                        // 20-bit carry output
    output [19:0] S                         // 20-bit sum output
    );
    
    fullAdder fa(1'b0, 1'b0, 1'b0, C[0], S[19]);                            // both MSB and LSB of sum and carry are 0

    // evaluate the sum bits and carry bits with the aid of fullAdders     
    fullAdder fa1(a[0], b[0], c[0], C[1], S[0]);
    fullAdder fa2(a[1], b[1], c[1], C[2], S[1]);
    fullAdder fa3(a[2], b[2], c[2], C[3], S[2]);
    fullAdder fa4(a[3], b[3], c[3], C[4], S[3]);
    
    fullAdder fa5(a[4], b[4], c[4], C[5], S[4]);
    fullAdder fa6(a[5], b[5], c[5], C[6], S[5]);
    fullAdder fa7(a[6], b[6], c[6], C[7], S[6]);
    fullAdder fa8(a[7], b[7], c[7], C[8], S[7]);
    
    fullAdder fa9(a[8], b[8], c[8], C[9], S[8]);
    fullAdder fa10(a[9], b[9], c[9], C[10], S[9]);
    fullAdder fa11(a[10], b[10], c[10], C[11], S[10]);
    fullAdder fa12(a[11], b[11], c[11], C[12], S[11]);
    
    fullAdder fa13(a[12], b[12], c[12], C[13], S[12]);
    fullAdder fa14(a[13], b[13], c[13], C[14], S[13]);
    fullAdder fa15(a[14], b[14], c[14], C[15], S[14]);
    fullAdder fa16(a[15], b[15], c[15], C[16], S[15]);
    
    fullAdder fa17(a[16], b[16], c[16], C[17], S[16]);
    fullAdder fa18(a[17], b[17], c[17], C[18], S[17]);
    fullAdder fa19(a[18], b[18], c[18], C[19], S[18]);
    
endmodule


