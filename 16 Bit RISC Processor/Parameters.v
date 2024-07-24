`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2024 10:48:21
// Design Name: 
// Module Name: Parameters
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


`ifndef PARAMETER_H_
`define PARAMETER_H_
`define col 16 // 16 bits instruction memory, data memory
`define row_i 15 // instruction memory, instructions number, this number can be changed. Adding more instructions to verify your design is a good idea.
`define row_d 8 // The number of data in data memory. We only use 8 data. Do not change this number. You can change the value of each data inside test.data file. Total number is fixed at 8. 
`define filename "./test/50001111_50001212.o"
`define simulation_time #160

`endif
