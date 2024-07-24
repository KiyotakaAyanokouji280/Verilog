`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2024 11:11:22
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input [3:0] Opcode,
    input [1:0] ALUOp,
    output reg [2:0] ALU_Cnt
    );
    
    wire [5:0] ALUControlIn;
    //wire ALUControlInput
    assign ALUControlIn = {ALUOp, Opcode};
    
    //check alucontrol input and assign 3 bit control accordingly
    always @ (ALUControlIn) begin
        casex (ALUControlIn)
            6'b10xxxx: ALU_Cnt=3'b000;
            6'b01xxxx: ALU_Cnt=3'b001;
            6'b000010: ALU_Cnt=3'b000;
            6'b000011: ALU_Cnt=3'b001;
            6'b000100: ALU_Cnt=3'b010;
            6'b000101: ALU_Cnt=3'b011;
            6'b000110: ALU_Cnt=3'b100;
            6'b000111: ALU_Cnt=3'b101;
            6'b001000: ALU_Cnt=3'b110;
            6'b001001: ALU_Cnt=3'b111;
            //add :  by default
            default: ALU_Cnt=3'b000;
        endcase
    end
    
endmodule
