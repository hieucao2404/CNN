`timescale 1ns / 1ps

module tb_conv3x3();

    // Inputs
    reg Clock;
    reg reset;
    reg Enable;
    reg [71:0] Image;
    reg [71:0] Kernel;

    // Outputs
    wire signed [19:0] Result;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    conv3x3 uut (
        .clk(Clock),
        .rst(reset),
        .enable(Enable),
        .image(Image),
        .kernel(Kernel),
        .result(Result),
        .done(done)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 Clock = ~Clock;

    initial begin
        // Initialize Inputs
        Clock = 0;
        reset = 1;
        Enable = 0;
        Image = 72'd0;
        Kernel = 72'd0;

        // Apply reset
        #20 reset = 0;
        
        // Setup inputs: 3x3 matrices
        // Image: 1, 2, 3, 4, 5, 6, 7, 8, 9
        // Kernel: 1, 0, 1, 0, 1, 0, 1, 0, 1
        Image  = {8'd9, 8'd8, 8'd7, 8'd6, 8'd5, 8'd4, 8'd3, 8'd2, 8'd1};
        Kernel = {8'd1, 8'd0, 8'd1, 8'd0, 8'd1, 8'd0, 8'd1, 8'd0, 8'd1};

        // Start operation
        #10 Enable = 1;
        
        // Wait for completion
        wait(done);
        $display("Calculation complete! Result: %d", Result);
        
        #10 Enable = 0;
        #20 $finish;
    end

endmodule