module AXI_SlAVE (
    //global signals
    input wire clk,
    input wire rst,
    // this input taken from testbanch
    input wire [31:0] sread_data,
    input wire rddata_enb,
    // this inpput is taken from testbench
    input wire [1:0] response,
    input wire resp_enb,
    //read address channel
    input wire ARVALID,
    input wire [31:0] ARADDR,
    input wire [2:0]  ARPROT,
    output reg ARREADY,
    //read data channel
    input wire RREADY,
    output reg [31:0] RDATA,
    output reg [1:0] RRESP,
    output reg RVALID,
    // write address channel
    input wire AWVALID,
    input wire [31:0] AWADDR,
    input wire [2:0] AWPROT,
    output reg AwREADY,
    // Write data channel
    input wire [31:0] WDATA,
    input wire WVALID,
    input wire [3:0] WSTRB,
    output reg WREADY,
    //write response channel
    input wire BREADY,
    output reg [1:0] BRESP,
    output reg BVALID
);
   // this register is used to hold address
   reg [31:0] sread_address;
   // this register is used to hold write address
   reg [31:0] swrite_address;
   //this register is used to hold write data
   reg [31:0] swrite_data;
   //this register is used to hold write strobe value
   reg [3:0]  write_stobe;


   //read_address slave block
   always @(posedge clk) begin
    if (rst) begin
      ARREADY<=1'b0;
      sread_address<=32'b0;
    end
    else begin
        ARREADY<=1'b1;
        if (ARVALID && ARREADY) begin
            sread_address<=ARADDR;
        end
    end
   end

   //read_data slave block
   always @(posedge clk) begin
        if (rst) begin
            RVALID <= 1'b0;
            RRESP<=2'b00;
        end 
        else begin
            RDATA<=sread_data;
            RRESP<=2'b11;
            if (rdaddr_enb==1'b1)begin
                RVALID <=1'b1;
                if (RREADY)begin
                  RVALID<=1'b0;
                end
            end
       end
    end

   //write address slave block
   always @(posedge clk) begin
    if (rst) begin
      AwREADY<=1'b0;
      swrite_address<=1'b0;
    end
    else begin
      AwREADY<=1'b1;
      if (AWVALID && AwREADY) begin
        swrite_address<=AWADDR;
      end
    end
   end

   //write data slave block
   always @(posedge clk) begin 
    if (rst) begin
      write_stobe<=4'b0000;
      WREADY<=1'b0;
      swrite_data<=32'b0;
    end
    else begin
      WREADY<=1'b1;
      if (WREADY && WVALID) begin
         swrite_data<=WDATA;
         write_stobe<=WSTRB;
      end
    end
   end

   //write response slave block
   always@(posedge clk) begin
     if (rst) begin
        BRESP<=2'b00;
     end
     else begin
       BRESP<=response;
       if(resp_enb==1'b1) begin
         BVALID<=1'b1;
         if (BREADY) begin
           BVALID<=1'b0;
         end
       end
     end
   end
endmodule