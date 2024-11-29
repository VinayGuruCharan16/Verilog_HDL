//Design RTL to detect the pattern, 1011. If the sequence is detected, push the 32-bit data from input to output, otherwise, hold the previous data.

`timescale 1ns / 1ps

module moore_1011_fsmd(
    input d_in,
    input clk,rst,
    output reg y_out,
    input [15:0] bit_in,
    output reg [15:0] bit_out
    );
   
    
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    
    
    reg [2:0] ps,ns;
    
    // state logic
    always @(posedge clk, negedge rst)
    begin
    if(~rst)
        ps <= s0;
    else
        ps <= ns;
     end
     always @(*)
     begin
        case(ps)
            s0 : begin
                    if(d_in)
                      ns = s1;
                    else
                       ns = s0;
                  end
             s1 : begin
                    if(~d_in)
                        ns = s2;
                    else
                        ns = s1;
                   end
             s2 : begin
                    if(d_in)
                        ns = s3;
                    else
                        ns = s0;
                    end
               s3   : begin
                        if(d_in)
                            ns = s4;
                        else
                            ns = s2;
                      end
               s4   : begin
                        if(~d_in)
                            ns = s2;
                        else
                            ns = s1;
                      end
               
              default : ns = s0;
           endcase
       end
       
   //output logic
 always @(*)
 begin
    case(ps)
        s0 : y_out = 0;
        s1 : y_out = 0;
        s2 : y_out = 0;
        s3 : y_out = 0;
        s4 : y_out = 1;
        default : y_out = 0;
     endcase
 end  
 
 always @(posedge clk, negedge rst)
 begin
    if(~rst)
        bit_out <= 0;
    else begin
        if(y_out)
            bit_out <= bit_in;
      end
  end
endmodule
