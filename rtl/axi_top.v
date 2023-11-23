`include "AXI_MASTER.v"
`include "AXI_SLAVE.v"

module axi_top(
    input wire clk,
    input wire rst,
    input wire [31:0] mread_address,
    input wire [31:0] mwrite_address,
    input wire [31:0] mwrite_data,
    input wire [31:0] sread_data,
    input wire [1:0] response,
    input wire rdaddr_enb,
    input wire resp_enb,
    input wire rddata_enb,
    input wire wraddr_enb,
    input wire wrdata_enb
);

    
    wire ARVALID;
    wire [31:0] ARADDR;
    wire [2:0]  ARPROT;
    wire ARREADY;
    //read data channel
    wire RREADY;
    wire [31:0] RDATA;
    wire [1:0] RRESP;
    wire RVALID;
    // write address channel
    wire AWVALID;
    wire [31:0] AWADDR;
    wire [2:0] AWPROT;
    wire AwREADY;
    // Write data channel
    wire [31:0] WDATA;
    wire WVALID;
    wire [3:0] WSTRB;
    wire WREADY;
    //write response channel
    wire BREADY;
    wire [1:0] BRESP;
    wire BVALID;

   AXI_MASTER master (
    .clk(clk),
    .rst(rst),
    //read address channel
    .ARVALID(ARVALID),
    .mread_address(mread_address),
    .ARADDR(ARADDR),
    .ARPROT(ARPROT),
    .ARREADY(ARREADY),
    //read data channel
    .RREADY(RREADY),
    .RDATA(RDATA),
    .RRESP(RRESP),
    .RVALID(RVALID),
    // write address channel
    .AWVALID(AWVALID),
    .mwrite_address(mwrite_address),
    .AWADDR(AWADDR),
    .AWPROT(AWPROT),
    .AwREADY(AwREADY),
    // Write data channel
    .mwrite_data(mwrite_data),
    .WDATA(WDATA),
    .WVALID(WVALID),
    .WSTRB(WSTRB),
    .WREADY(WREADY),
    //write response channel
    .BREADY(BREADY),
    .BRESP(BRESP),
    .BVALID(BVALID),
    .rdaddr_enb(rdaddr_enb),
    .wraddr_enb(wraddr_enb),
    .wrdata_enb(wrdata_enb)
   );

   AXI_SlAVE slave (
    .clk(clk),
    .rst(rst),
    //read address channel
    .ARVALID(ARVALID),
    .ARADDR(ARADDR),
    .ARPROT(ARPROT),
    .ARREADY(ARREADY),
    //read data channel
    .sread_data(sread_data),
    .RVALID(RVALID),
    .RREADY(RREADY),
    .RDATA(RDATA),
    .RRESP(RRESP),
    // write address channel
    .AWVALID(AWVALID),
    .AWADDR(AWADDR),
    .AWPROT(AWPROT),
    .AwREADY(AwREADY),
    // Write data channel
    .WDATA(WDATA),
    .WVALID(WVALID),
    .WSTRB(WSTRB),
    .WREADY(WREADY),
    //write response channel
    .response(response),
    .BREADY(BREADY),
    .BRESP(BRESP),
    .BVALID(BVALID),
    .rddata_enb(rddata_enb),
    .resp_enb(resp_enb)
   );
endmodule