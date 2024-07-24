`timescale 1ns / 1ps
`include "Parameters.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2024 10:50:15
// Design Name: 
// Module Name: Instruction_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Memory(
    input [15:0] pc,
    output [15:0] instruction
    );
    //define the memory
    reg [`col - 1:0] memory [`row_i - 1:0];
    //pick up the address from the pc to access relevant memory
    wire [3 : 0] rom_addr = pc[4 : 1];
    initial
    begin
    //load the memory with the instructions given in test file
     $readmemb("./test/test.prog", memory,0,14);
    end
    assign instruction =  memory[rom_addr]; 
endmodule
