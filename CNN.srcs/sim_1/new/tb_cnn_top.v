`timescale 1ns / 1ps

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

//--------------------------------------------------
// Task
//--------------------------------------------------
task run_test;
    input [71:0] img;
    input [71:0] ker;
    input [255:0] test_name;
begin

    $display("\n================================");
    $display("Running Test: %s", test_name);
    $display("================================");

    rst = 1;
    enable = 0;
    #20;

    rst = 0;
    image = img;
    kernel = ker;

    #10;
    enable = 1;

    wait(done);

    $display("Result = %d", result);

    #10;
    enable = 0;

end
endtask

//--------------------------------------------------
// Main Test Sequence
//--------------------------------------------------
initial begin

    clk = 0;
    rst = 0;
    enable = 0;

    //--------------------------------------------------
    // Test 1
    //--------------------------------------------------
    run_test(
        {
            8'd9,8'd8,8'd7,
            8'd6,8'd5,8'd4,
            8'd3,8'd2,8'd1
        },
        {
            8'd1,8'd0,8'd1,
            8'd0,8'd1,8'd0,
            8'd1,8'd0,8'd1
        },
        "Cross Kernel"
    );

    //--------------------------------------------------
    // Test 2
    //--------------------------------------------------
    run_test(
        {
            8'd1,8'd2,8'd3,
            8'd4,8'd5,8'd6,
            8'd7,8'd8,8'd9
        },
        {
            8'd1,8'd1,8'd1,
            8'd1,8'd1,8'd1,
            8'd1,8'd1,8'd1
        },
        "All Ones Kernel"
    );

    //--------------------------------------------------
    // Test 3
    //--------------------------------------------------
    run_test(
        {
            8'd10,8'd20,8'd30,
            8'd40,8'd50,8'd60,
            8'd70,8'd80,8'd90
        },
        {
            8'd0,8'd0,8'd0,
            8'd0,8'd1,8'd0,
            8'd0,8'd0,8'd0
        },
        "Center Pixel Kernel"
    );

    //--------------------------------------------------
    // Test 4
    //--------------------------------------------------
    run_test(
        {
            8'd1,8'd1,8'd1,
            8'd1,8'd1,8'd1,
            8'd1,8'd1,8'd1
        },
        {
            8'd1,8'd2,8'd1,
            8'd2,8'd4,8'd2,
            8'd1,8'd2,8'd1
        },
        "Gaussian-like Kernel"
    );

    $display("\nAll tests completed.");

    #50;
    $finish;

end

endmodule