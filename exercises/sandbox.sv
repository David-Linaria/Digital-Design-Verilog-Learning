module sevenseg (
    input  logic [3:0] data,
    output logic [6:0] segments
);
    always_comb
        case (data)
            // abc_defg
            0: segments = 7'b111_1110;
            1: segments = 7'b011_0000;
            2: segments = 7'b110_1101;
            3: segments = 7'b111_1001;
            4: segments = 7'b011_0011;
            5: segments = 7'b101_1011;
            6: segments = 7'b101_1111;
            7: segments = 7'b111_0000;
            8: segments = 7'b111_1111;
            9: segments = 7'b111_0011;
            default: segments = 7'b000_0000;
        endcase
endmodule

module priorityckt (
    input  logic [3:0] a,
    output logic [3:0] y
);
    always_comb
        if (a[3]) y = 4'b1000;
        else if (a[2]) y = 4'b0100;
        else if (a[1]) y = 4'b0010;
        else if (a[0]) y = 4'b0001;
        else y = 4'b0000;
endmodule

module pri (
    input  logic [3:0] a,
    output logic [3:0] y
);

    always_comb begin
        case (a)
            4'b1???: y = 4'b1000;
            4'b01??: y = 4'b0100;
            4'b001?: y = 4'b0010;
            4'b0001: y = 4'b0001;
            default: y = 4'b0000;
        endcase
    end
endmodule

module divideby3FSM (
    input  logic clk,
    input  logic reset,
    output logic y
);

    typedef enum logic [1:0] {
        S0,
        S1,
        S2
    } statetype;

    statetype state, nextstate;

    // state register
    always_ff @(posedge clk, posedge reset) begin
        if (reset) state <= S0;
        else state <= nextstate;
    end

    // next state logic
    always_comb begin
        case (state)
            S0: nextstate = S1;
            S1: nextstate = S2;
            S2: nextstate = S0;
            default: nextstate = S0;
        endcase
    end

    // output logic
    assign y = (state == S0);

endmodule


module patternMealy (
    input  logic clk,
    input  logic reset,
    input  logic a,
    output logic y
);

    // define states
    typedef enum logic {
        S0,
        S1
    } statetype;
    statetype state, nextstate;

    // register
    always_ff @(posedge clk, posedge reset) begin
        if (reset) state <= S0;
        else state <= nextstate;
    end

    // next state logic
    always_comb begin
        case (state)
            S0: begin
                if (a) nextstate = S0;
                else nextstate = S1;
            end
            S1: begin
                if (a) nextstate = S0;
                else nextstate = S1;
            end
            default: nextstate = S0;
        endcase
    end

    // output logic
    assign y = (a & state == S1);

endmodule

module lint_test (
    input  logic a,
    b,
    output logic y
);
    assign y = a & b;
endmodule


module mux2 #(
    parameter width = 8
) (
    input logic [width-1:0] d0,
    d1,
    input logic s,
    output logic [width-1:0] y
);
    assign y = s ? d1 : d0;
endmodule

module mux4_12 (
    input  logic [11:0] d0,
    d1,
    d2,
    d3,
    input  logic [ 1:0] s,
    output logic [11:0] y
);
    logic [11:0] low, hi;
    mux2 #(12) lowmux (
        d0,
        d1,
        s[0],
        low
    );
    mux2 #(12) himux (
        d2,
        d3,
        s[0],
        hi
    );
    mux2 #(12) outmux (
        low,
        hi,
        s[1],
        y
    );
endmodule

module andN #(
    parameter width = 8
) (
    input logic [width-1:0] a,
    output logic y
);
    genvar i;
    logic [width-1:0] x;
    generate
        assign x[0] = a[0];
        for (i = 1; i < width; i = i + 1) begin : forloop
            assign x[i] = a[i] & x[i-1];
        end
    endgenerate
    assign y = x[width-1];
endmodule
