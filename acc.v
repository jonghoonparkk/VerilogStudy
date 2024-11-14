`timescale 1ns /1ps

module acc(
    input clk,
    input rst,
    input ld,
    input [7:0] acc_in,
    output reg [7:0] acc_out
);

always @(posedge clk or posedge reset) begin
    if(reset)
        acc_out <= 8'b0;
    else if(ld)
        acc_out <= acc_in;
end

endmodule

module acc_TB_version100908_v;
    // Inputs
    reg clk;
    reg rst;
    reg ld;
    reg [7:0] acc_in;

    // Outputs
    wire [7:0] acc_out;

    // Instantiate the Unit Under Test (UUT)
    acc uut (
        .clk(clk), 
        .rst(rst), 
        .ld(ld), 
        .acc_in(acc_in), 
        .acc_out(acc_out)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        ld = 0;
        acc_in = 8'b0;

        // Wait 100 ns for global reset to finish
        #100;
        rst = 1;

        // Add stimulus here
        ld = 1;
        acc_in = 8'b10101010;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b01010101;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b11110000;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b00001111;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b11001100;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b00110011;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b11111111;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b00000000;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b10101010;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b01010101;
        #100;
        ld = 0;
        #100;
        ld = 1;
        acc_in = 8'b11110000;
        #100;
        ld = 0;
        #100;