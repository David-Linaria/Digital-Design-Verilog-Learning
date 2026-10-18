module test (
    input logic [3:0] a,
    b,
    c,
    d,
    output logic y,
    input logic clk
);
    always_comb begin
        y = a & b;
    end
endmodule
