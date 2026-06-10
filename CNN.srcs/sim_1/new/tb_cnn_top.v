`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 10:06:33 AM
// Design Name: 
// Module Name: tb_cnn_top
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


module tb_cnn_top();

reg clk;
reg rst;
reg enable;

reg [71:0] image;
reg [71:0] kernel;

wire done;
wire [19:0] result;

cnn_top dut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .image(image),
    .kernel(kernel),
    .done(done),
    .result(result)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    enable = 0;

    #20;
    rst = 0;

    // Image:
    // 1 2 3
    // 4 5 6
    // 7 8 9

    image = {
        8'd9,8'd8,8'd7,
        8'd6,8'd5,8'd4,
        8'd3,8'd2,8'd1
    };

    // Kernel:
    // 1 0 1
    // 0 1 0
    // 1 0 1

    kernel = {
        8'd1,8'd0,8'd1,
        8'd0,8'd1,8'd0,
        8'd1,8'd0,8'd1
    };

    enable = 1;

    wait(done);

    $display("CNN Output = %d", result);

    #20;
    $finish;

end
endmodule
