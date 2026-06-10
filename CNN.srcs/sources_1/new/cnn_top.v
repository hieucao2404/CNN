`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 10:05:39 AM
// Design Name: 
// Module Name: cnn_top
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


module cnn_top(
   input clk,
    input rst,
    input enable,

    input [71:0] image,
    input [71:0] kernel,

    output done,
    output [19:0] result
);

wire conv_done;
wire signed [19:0] conv_out;
wire [19:0] relu_out;
wire [19:0] pool_out;

conv3x3 u_conv(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .image(image),
    .kernel(kernel),
    .done(conv_done),
    .result(conv_out)
);

relu u_relu(
    .in(conv_out),
    .out(relu_out)
);

// fake pooling inputs for demo
maxpool2x2 u_pool(
    .a(relu_out),
    .b(20'd12),
    .c(20'd18),
    .d(20'd30),
    .max_out(pool_out)
);

assign result = pool_out;
assign done = conv_done;

endmodule
