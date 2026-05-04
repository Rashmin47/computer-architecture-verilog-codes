module tb_SignedAddSub;
    reg signed [7:0] A, B;          // 8-bit signed numbers
    reg signed [7:0] SUM, DIFF;
    reg signed [7:0] test_values [0:5][0:1]; // Test value array
    integer i;
    // Initialize Test Values
    initial begin
        test_values[0][0] =  8'd20;   test_values[0][1] =  8'd10;
        test_values[1][0] = -8'd15;   test_values[1][1] =  8'd7;
        test_values[2][0] =  8'd50;   test_values[2][1] = -8'd20;
        test_values[3][0] = -8'd30;   test_values[3][1] = -8'd10;
        test_values[4][0] =  8'd127;  test_values[4][1] =  8'd1;
        test_values[5][0] = -8'd128;  test_values[5][1] = -8'd1;
    end
    // Testbench Logic
    initial begin
        $dumpfile("signed_addsub.vcd");
        $dumpvars(0, tb_SignedAddSub);
        for (i = 0; i < 6; i = i + 1) begin
            #10;
            A = test_values[i][0];
            B = test_values[i][1];
            // Perform addition and subtraction
            SUM  = A + B;
            DIFF = A - B;
            // Display results in decimal and binary
            $display("A=%0d (%b), B=%0d (%b) | A+B=%0d (%b), A-B=%0d (%b)",
                      A, A, B, B, SUM, SUM, DIFF, DIFF);
        end
        #20;
        $finish;
    end
endmodule