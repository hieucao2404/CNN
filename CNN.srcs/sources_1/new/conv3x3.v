`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 09:33:26 AM
// Design Name: 
// Module Name: conv3x3
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


module conv3x3(
    input clk,
    input rst,
    input enable,
    
    input wire [71:0] image,
    input wire [71:0] kernel,
    
    output reg done,
    output reg signed [19:0] result
    );
    
    reg [7:0] image_mat [0:2][0:2];
    reg [7:0] kernel_mat [0:2][0:2];
    
    integer row;
    integer col;
    
    reg first_cycle;
    reg signed [19:0] acc;
    reg [3:0] count;
    
    reg signed [15:0] mult_temp;
    
    always @(posedge clk or posedge rst) 
    begin 
        if(rst)
            begin 
                first_cycle <= 1'b1;
                done <= 1'b0;
                acc <= 20'd0;
                count <= 4'd0;
                result <= 20'd0;
                
                for(row = 0; row < 3; row = row + 1)
                    begin
                        for(col = 0; col < 3; col = col + 1)
                        begin
                        image_mat[row][col] <= 8'd0;
                        kernel_mat[row][col] <= 8'd0;
                        end
                     end
                 end
         else if (enable)
         begin 
            //Load matrices on first cycle
            if(first_cycle)
                begin
                     for(row = 0; row < 3; row = row + 1)
                    begin
                        for(col = 0; col < 3; col = col + 1)
                        begin
                        image_mat[row][col] <= image[(row*3+col)*8 +: 8];
                         kernel_mat[row][col]
                            <= kernel[(row*3+col)*8 +: 8];
                         end
                      end
                  acc <= 20'd0;
                  count <= 4'd0;
                  done <= 1'b0;
                  first_cycle <= 1'b0;
                end
               //perform convolution
               else if(count < 9)
                begin
                    row = count /3;
                    col = count %3;
                    mult_temp = image_mat[row][col] * kernel_mat[row][col];
                    
                    acc <= acc + mult_temp;
                    
                    count <= count + 1'b1;
                end
                
                //Finished
                else 
                begin
                    result <= acc;
                    done <= 1'b1;
                end
                end
                else
                begin
                    first_cycle <= 1'b1;
                    done <= 1'b0;
                 end
              end
   
    
    
endmodule
