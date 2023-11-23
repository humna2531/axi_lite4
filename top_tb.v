module top_tb();
    reg clk;
    reg rst;
    reg [31:0] mread_address;
    reg [31:0] mwrite_address;
    reg [31:0] mwrite_data;
    reg [31:0] sread_data;
    reg [1:0] response;
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

    axi_top test (
    .clk(clk),
    .rst(rst),
    .mread_address(mread_address),
    .sread_data(sread_data),
    .mwrite_address(mwrite_address),
    .mwrite_data(mwrite_data),
    .response(response),
    .rdaddr_enb(rdaddr_enb),
    .resp_enb(resp_enb),
    .rddata_enb(rddata_enb),
    .wraddr_enb(wraddr_enb),
    .wrdata_enb(wrdata_enb)
    );
   
   
   
   always #5 clk=~clk;

   initial begin
       clk = 1'b0;
        rst = 1'b1;
        mread_address= 32'b0;
        sread_data=32'b0;
        mwrite_data=32'b0;
        mwrite_address=32'b0;
        response=2'b00;
        rdaddr_enb=1'b0;
        resp_enb=1'b0;
        rddata_enb=1'b0;
        wraddr_enb=1'b0;
        wrdata_enb=1'b0;
        #5;
        rst = 0;
        mread_address= 32'b00000111;
        sread_data=32'b111111;
        mwrite_address=32'b111001;
        mwrite_data=32'b111111111111;
        response=2'b11;
        rdaddr_enb=1'b1;
        resp_enb=1'b1;
        rddata_enb=1'b1;
        wraddr_enb=1'b1;
        wrdata_enb=1'b1;
        #50;
    $finish();
   end

   initial begin
        $dumpfile("axi_top.vcd");
        $dumpvars(0, top_tb);
   end


endmodule