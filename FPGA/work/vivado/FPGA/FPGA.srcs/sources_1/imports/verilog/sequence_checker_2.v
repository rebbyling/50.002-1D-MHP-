/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module sequence_checker_2 (
    input [3:0] buttons,
    input clk,
    input rst,
    output reg [2:0] out_result,
    output reg [3:0] out_buttonseq
  );
  
  
  
  reg [3:0] M_sequence_d, M_sequence_q = 1'h0;
  
  reg [2:0] M_result_d, M_result_q = 1'h0;
  
  localparam MATCH = 4'hb;
  
  
  localparam WAITFIRSTPRESS_check = 2'd0;
  localparam WAITSECONDPRESS_check = 2'd1;
  localparam CHECKPRESS_check = 2'd2;
  
  reg [1:0] M_check_d, M_check_q = WAITFIRSTPRESS_check;
  
  always @* begin
    M_check_d = M_check_q;
    M_result_d = M_result_q;
    M_sequence_d = M_sequence_q;
    
    
    case (M_check_q)
      WAITFIRSTPRESS_check: begin
        if (buttons[3+0-:1] | buttons[2+0-:1] | buttons[1+0-:1] | buttons[0+0-:1]) begin
          if (buttons[3+0-:1]) begin
            M_sequence_d[0+1-:2] = 2'h3;
          end else begin
            if (buttons[2+0-:1]) begin
              M_sequence_d[0+1-:2] = 2'h2;
            end else begin
              if (buttons[1+0-:1]) begin
                M_sequence_d[0+1-:2] = 2'h1;
              end else begin
                if (buttons[0+0-:1]) begin
                  M_sequence_d[0+1-:2] = 2'h0;
                end
              end
            end
          end
          M_check_d = WAITSECONDPRESS_check;
          M_result_d = 3'h0;
        end else begin
          M_check_d = WAITFIRSTPRESS_check;
        end
      end
      WAITSECONDPRESS_check: begin
        if (buttons[3+0-:1] | buttons[2+0-:1] | buttons[1+0-:1] | buttons[0+0-:1]) begin
          if (buttons[3+0-:1]) begin
            M_sequence_d[2+1-:2] = 2'h3;
          end else begin
            if (buttons[2+0-:1]) begin
              M_sequence_d[2+1-:2] = 2'h2;
            end else begin
              if (buttons[1+0-:1]) begin
                M_sequence_d[2+1-:2] = 2'h1;
              end else begin
                if (buttons[0+0-:1]) begin
                  M_sequence_d[2+1-:2] = 2'h0;
                end
              end
            end
          end
          M_check_d = CHECKPRESS_check;
        end else begin
          M_check_d = WAITSECONDPRESS_check;
        end
      end
      CHECKPRESS_check: begin
        if (M_sequence_q[0+1-:2] == 2'h3 && M_sequence_q[2+1-:2] == 2'h2) begin
          M_result_d = 3'h7;
        end else begin
          M_result_d = 3'h4;
        end
        M_check_d = CHECKPRESS_check;
      end
    endcase
    out_result = M_result_q;
    out_buttonseq = M_sequence_q;
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_result_q <= 1'h0;
    end else begin
      M_result_q <= M_result_d;
    end
  end
  
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_check_q <= 1'h0;
    end else begin
      M_check_q <= M_check_d;
    end
  end
  
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_sequence_q <= 1'h0;
    end else begin
      M_sequence_q <= M_sequence_d;
    end
  end
  
endmodule
