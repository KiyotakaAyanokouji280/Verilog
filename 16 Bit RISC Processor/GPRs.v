`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2024 10:56:54
// Design Name: 
// Module Name: GPRs
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


module GPRs(
    input clk,
    input [2:0] reg_write_dest,
    input [15:0] reg_read_addr_1,
    input [15:0] reg_read_addr_2,
    input reg_write_en,
    output [15:0] reg_read_data_1,
    output [15:0] reg_read_data_2,
    input [15:0] reg_write_data
    );
    //define the register array
    reg [15:0] reg_array [7:0];
    integer i;
    //initialize the data with zeroes
    initial begin
     for(i=0;i<8;i=i+1)
      reg_array[i] <= 16'd0;
    end
    //write data at the posedge
    always @ (posedge clk ) begin
      if(reg_write_en) begin
       reg_array[reg_write_dest] <= reg_write_data;
      end
    end
    //output data
    assign reg_read_data_1 = reg_array[reg_read_addr_1];
    assign reg_read_data_2 = reg_array[reg_read_addr_2];

endmodule
