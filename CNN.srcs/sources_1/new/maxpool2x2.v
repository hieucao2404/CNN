`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 10:01:04 AM
// Design Name: 
// Module Name: maxpool2x2
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


module maxpool2x2(
    input [19:0] a,
    input [19:0] b,
    input [19:0] c,
    input [19:0] d,
    output reg [19:0] max_out
    );
    
    always @(*)
    begin
        max_out = a;
        
        if(b > max_out) max_out = b;
        if(c > max_out) max_out = c;
        if(d > max_out) max_out = d;
    end
endmodule
