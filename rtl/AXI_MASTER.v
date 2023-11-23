module master(
    // global signals
    input wire clk,
    input wire rst,
    //these input are taken from test bench
    input wire [31:0] mread_address,
    input wire rdaddr_enb,
    input wire [31:0] mwrite_address,
    input wire wraddr_enb,
    input wire [31:0] mwrite_data,
    input wire wrdata_enb,
    //read address channel
    input wire ARREADY,
    output reg ARVALID,
    output reg [31:0] ARADDR,
    output reg [2:0] ARPROT,
    //read data channel
    input wire [31:0] RDATA,
    input wire [1:0] RRESP,
    input wire RVALID,
    output reg RREADY,
    //write address channal
    input wire AWREADY,
    output reg AWVALID,
    output reg [31:0] AWADDR,
    output reg [2:0] AWPROT,
    // Write data channel
    input  wire WREADY,
    output reg [31:0] WDATA,
    output reg WVALID,
    output reg [3:0]WSTRB,
    //write response channel
    input wire [1:0] BRESP,
    input wire BVALID,
    output reg BREADY
);
    //this register is used to hold read_data
    reg [31:0] mread_data;
    //this register is used to hold res_valid
    reg  res_valid;

    //read_address  master block  
    always @(posedge clk) begin
        if (rst) begin
            ARVALID <= 1'b0;
        end
        else begin
            ARADDR<=mread_address;
            ARPROT<=3'b000;
            if (rdaddr_enb==1'b1)begin
                ARVALID<=1'b1;
               if(ARREADY)begin
                ARVALID<=1'b0;
               end
            end
       end
    end

    //read_data master block
    always@(posedge clk) begin
        if (rst) begin
           RREADY<=1'b0;
        end
        else begin
          RREADY<=1'b1;
          if (RVALID && RREADY)begin
            mread_data<=RDATA;
          end        
        end
    end
   
    //write address master block
    always @(posedge clk) begin
        if (rst) begin
            AWVALID <= 1'b0;
        end
        else begin
            AWADDR<=mwrite_address;
            AWPROT<=3'b000;
            if (wraddr_enb==1'b1)begin
                AWVALID<=1'b1;
                if(AWREADY)begin
                    AWVALID<=1'b0;
                end
            end
       end
    end

    //write data master block
    always@(posedge clk) begin
        if (rst) begin
           WVALID<=1'b0;
        end
        else begin
          WDATA<=mwrite_data;
          WSTRB<=3'b111;
          if (wrdata_enb==1'b1) begin
            WVALID<=1'b1;
            if (WREADY) begin
              WVALID<=1'b0;
            end
          end        
        end
    end

   //write response master block
   always @(posedge clk) begin
    if (rst) begin
        BREADY<=1'b0;
        res_valid<=1'b0;
    end
    else begin
        BREADY<=1'b1;
        if(BREADY && BRESP!=2'b00) begin
            res_valid<=BVALID;
        end
    end
   end
endmodule

