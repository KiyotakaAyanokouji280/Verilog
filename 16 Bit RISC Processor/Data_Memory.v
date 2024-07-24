`timescale 1ns / 1ps
`include "Parameters.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2024 11:00:59
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input [15:0] mem_access_addr,
    input [15:0] mem_write_data,
    output [15:0] mem_read_data,
    input clk,
    input mem_write_en,
    input mem_read
    );
    //define the memory
    reg [`col - 1:0] memory [`row_d - 1:0];
    integer f;
    //relevant bits of address bus to access memory
    wire [2:0] ram_addr=mem_access_addr[2:0];
    initial
     begin
    //fill the memory with test file data
      $readmemb("./test/test.data", memory);
      
      f = $fopen(`filename);
      $fmonitor(f, "time = %d\n", $time, 
      "\tmemory[0] = %b\n", memory[0],   
      "\tmemory[1] = %b\n", memory[1],
      "\tmemory[2] = %b\n", memory[2],
      "\tmemory[3] = %b\n", memory[3],
      "\tmemory[4] = %b\n", memory[4],
      "\tmemory[5] = %b\n", memory[5],
      "\tmemory[6] = %b\n", memory[6],
      "\tmemory[7] = %b\n", memory[7]);
      `simulation_time;
      $fclose(f);
     end
 
 //write into memory at clock edges
   always @(posedge clk) begin
    if (mem_write_en)
     memory[ram_addr] <= mem_write_data;
   end
   
   //give out data from memory when read is enabled
   assign mem_read_data = (mem_read==1'b1) ? memory[ram_addr]: 16'd0;
endmodule
