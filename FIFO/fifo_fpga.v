//creating a fifo module for fpga device:

//target: memory block, read module, write module, status module, top level module

//design written on paper

/*
Model of a 16 stage, 8 bit data bus width fifo memory
Status signals:
    Full: 1 when fifo is full, 0 otherwise
    Empty: 1 when fifo is empty, 0 otherwise
    Overflow: 1 when fifo is full and wr_en is asserted, 0 otherwise
    Underflow: 1 when fifo is empty and rd_en is asserted, 0 otherwise
*/

//top level module
module topLevelFifo (rd_en, wr_en, is_full, is_empty, overflow, underflow, data_in, data_out, clk, reset);
    input clk, reset, rd_en, wr_en;
    output is_full, is_empty, overflow, underflow;
    input [7:0] data_in;
    output [7:0] data_out;

    wire [4:0] rd_ptr, wr_ptr;
    wire fifo_wr, fifo_rd;

    memoryBlock main_memory (wr_en, rd_en, wr_ptr, rd_ptr, clk, data_out, data_in);
    readPointer main_read (fifo_rd, rd_en, clk, reset, rd_ptr, is_empty);
    writePointer main_write (wr_en, wr_ptr, clk, reset, fifo_wr, is_full);
    statusModule main_status(is_full, is_empty, overflow, underflow, fifo_rd, fifo_wr, rd_en, wr_en, clk, reset, rd_ptr, wr_ptr);
endmodule


//memory block
module memoryBlock (wr_en, rd_en, wr_ptr, rd_ptr, clk, data_out, data_in);
input wr_en, rd_en;
input [4:0] wr_ptr, rd_ptr;
input [7:0] data_in;
input clk;
output reg [7:0] data_out;

reg [7:0] data_16_stage[15:0];

always @ (posedge clk) begin
    if(rd_en & wr_en & (rd_ptr[3:0] != wr_ptr[3:0])) begin
         data_out <= data_16_stage[rd_ptr[3:0]];
         data_16_stage[wr_ptr[3:0]] <= data_in;
    end
    else if (rd_en & wr_en & (rd_ptr[3:0] == wr_ptr[3:0])) begin
    end
    else if (rd_en) begin
        data_out <= data_16_stage[rd_ptr[3:0]];
    end
    else if (wr_en) begin
        data_16_stage[wr_ptr[3:0]] <= data_in;
    end
    else begin
    end
end
endmodule


// read module
module readPointer (fifo_rd, rd_en, clk, reset, rd_ptr, is_empty);
input rd_en;
input clk, reset;
input is_empty;
output fifo_rd;
output reg [4:0] rd_ptr;

assign fifo_rd = rd_en & ~is_empty;
always @ (posedge clk) begin
    if (reset) begin
        rd_ptr <= 5'b00000;
    end
    else if (fifo_rd) begin
        rd_ptr <= rd_ptr + 5'b00001;
    end
    else begin
        rd_ptr <= rd_ptr;
    end
end
endmodule

// write module
module writePointer(wr_en, wr_ptr, clk, reset, fifo_wr, is_full);
input wr_en, clk, reset;
input is_full;
output fifo_wr;
output reg [4:0] wr_ptr;

assign fifo_wr = wr_en & ~is_full;

always @ (posedge clk) begin
    if (reset) begin
        wr_ptr <= 5'b00000;
    end
    else if (fifo_wr) begin
        wr_ptr <= wr_ptr + 5'b00001;
    end
    else begin
        wr_ptr <= wr_ptr;
    end
end
endmodule

// status module for status signals
module statusModule (is_full, is_empty, overflow, underflow, fifo_rd, fifo_wr, rd_en, wr_en, clk, reset, rd_ptr, wr_ptr);
    input clk, reset, rd_en, wr_en, fifo_rd, fifo_wr;
    input [4:0] rd_ptr, wr_ptr;
    output reg is_full, is_empty, overflow, underflow;

    wire comparision_bit, set_overflow, set_underflow;
    wire pointers_equal;
    wire [4:0] pointer_result;


    assign set_overflow = is_full & wr_en;
    assign set_underflow = is_empty & rd_en;

    always @ (*) begin
        is_full = pointers_equal & comparision_bit;
        is_empty = pointers_equal & ~comparision_bit;
    end

    always @ (posedge clk) begin
        if (reset) overflow <= 1'b0;
        else if (set_overflow==1 && fifo_rd==0) overflow <= 1;
        else overflow <= overflow;
    end

    always @ (posedge clk) begin
        if (reset) underflow <= 0;
        else if (set_underflow == 1 && fifo_wr == 0) underflow <= 1;
        else underflow <= underflow;
    end


endmodule

