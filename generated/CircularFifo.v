module CircularFifo(
  input        clock,
  input        reset,
  input        io_enq_write,
  output       io_enq_full,
  input  [7:0] io_enq_din,
  input        io_enq_dinValid,
  input        io_deq_read,
  output       io_deq_empty,
  output [7:0] io_deq_dout,
  output       io_deq_doutValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] readPointer; // @[CircularFifo.scala 34:28]
  reg [1:0] writePointer; // @[CircularFifo.scala 35:29]
  reg  readWrapBit; // @[CircularFifo.scala 36:28]
  reg  writeWrapBit; // @[CircularFifo.scala 37:29]
  reg [1:0] stateReg; // @[CircularFifo.scala 39:25]
  reg [7:0] storage_0; // @[CircularFifo.scala 41:20]
  reg [7:0] storage_1; // @[CircularFifo.scala 41:20]
  reg [7:0] storage_2; // @[CircularFifo.scala 41:20]
  reg [7:0] storage_3; // @[CircularFifo.scala 41:20]
  wire  _T = stateReg == 2'h0; // @[CircularFifo.scala 43:17]
  wire  _T_1 = io_enq_write & io_enq_dinValid; // @[CircularFifo.scala 45:23]
  wire [2:0] _writePointer_T_1 = 3'h4 - 3'h1; // @[CircularFifo.scala 46:52]
  wire [2:0] _GEN_55 = {{1'd0}, writePointer}; // @[CircularFifo.scala 46:40]
  wire  _writePointer_T_2 = _GEN_55 == _writePointer_T_1; // @[CircularFifo.scala 46:40]
  wire [1:0] _writePointer_T_4 = writePointer + 2'h1; // @[CircularFifo.scala 46:75]
  wire [1:0] _writePointer_T_5 = _GEN_55 == _writePointer_T_1 ? 2'h0 : _writePointer_T_4; // @[CircularFifo.scala 46:26]
  wire  _writeWrapBit_T_3 = ~writeWrapBit; // @[CircularFifo.scala 47:58]
  wire  _writeWrapBit_T_4 = _writePointer_T_2 ? ~writeWrapBit : writeWrapBit; // @[CircularFifo.scala 47:26]
  wire [7:0] _GEN_0 = 2'h0 == writePointer ? io_enq_din : storage_0; // @[CircularFifo.scala 41:20 49:{29,29}]
  wire [7:0] _GEN_1 = 2'h1 == writePointer ? io_enq_din : storage_1; // @[CircularFifo.scala 41:20 49:{29,29}]
  wire [7:0] _GEN_2 = 2'h2 == writePointer ? io_enq_din : storage_2; // @[CircularFifo.scala 41:20 49:{29,29}]
  wire [7:0] _GEN_3 = 2'h3 == writePointer ? io_enq_din : storage_3; // @[CircularFifo.scala 41:20 49:{29,29}]
  wire [1:0] _GEN_4 = io_enq_write & io_enq_dinValid ? _writePointer_T_5 : writePointer; // @[CircularFifo.scala 45:42 46:20 35:29]
  wire  _GEN_5 = io_enq_write & io_enq_dinValid ? _writeWrapBit_T_4 : writeWrapBit; // @[CircularFifo.scala 45:42 47:20 37:29]
  wire [7:0] _GEN_7 = io_enq_write & io_enq_dinValid ? _GEN_0 : storage_0; // @[CircularFifo.scala 41:20 45:42]
  wire [7:0] _GEN_8 = io_enq_write & io_enq_dinValid ? _GEN_1 : storage_1; // @[CircularFifo.scala 41:20 45:42]
  wire [7:0] _GEN_9 = io_enq_write & io_enq_dinValid ? _GEN_2 : storage_2; // @[CircularFifo.scala 41:20 45:42]
  wire [7:0] _GEN_10 = io_enq_write & io_enq_dinValid ? _GEN_3 : storage_3; // @[CircularFifo.scala 41:20 45:42]
  wire  _T_4 = readPointer == writePointer; // @[CircularFifo.scala 56:25]
  wire [1:0] _GEN_11 = readPointer == writePointer & readWrapBit == _writeWrapBit_T_3 ? 2'h2 : stateReg; // @[CircularFifo.scala 56:78 57:18 39:25]
  wire [1:0] _GEN_16 = _T_1 ? _GEN_11 : stateReg; // @[CircularFifo.scala 39:25 53:42]
  wire [1:0] _GEN_23 = _T_4 & readWrapBit == writeWrapBit ? 2'h0 : _GEN_16; // @[CircularFifo.scala 65:77 66:18]
  wire [2:0] _GEN_59 = {{1'd0}, readPointer}; // @[CircularFifo.scala 68:38]
  wire  _readPointer_T_2 = _GEN_59 == _writePointer_T_1; // @[CircularFifo.scala 68:38]
  wire [1:0] _readPointer_T_4 = readPointer + 2'h1; // @[CircularFifo.scala 68:72]
  wire [1:0] _readPointer_T_5 = _GEN_59 == _writePointer_T_1 ? 2'h0 : _readPointer_T_4; // @[CircularFifo.scala 68:25]
  wire  _readWrapBit_T_4 = _readPointer_T_2 ? ~readWrapBit : readWrapBit; // @[CircularFifo.scala 69:25]
  wire [1:0] _GEN_25 = io_deq_read ? _readPointer_T_5 : readPointer; // @[CircularFifo.scala 63:22 68:19 34:28]
  wire  _GEN_26 = io_deq_read ? _readWrapBit_T_4 : readWrapBit; // @[CircularFifo.scala 63:22 69:19 36:28]
  wire [1:0] _GEN_29 = io_deq_read ? 2'h1 : stateReg; // @[CircularFifo.scala 73:22 76:16 39:25]
  wire [7:0] _GEN_52 = 2'h1 == readPointer ? storage_1 : storage_0; // @[CircularFifo.scala 82:{15,15}]
  wire [7:0] _GEN_53 = 2'h2 == readPointer ? storage_2 : _GEN_52; // @[CircularFifo.scala 82:{15,15}]
  assign io_enq_full = stateReg == 2'h2; // @[CircularFifo.scala 80:28]
  assign io_deq_empty = stateReg == 2'h0; // @[CircularFifo.scala 81:29]
  assign io_deq_dout = 2'h3 == readPointer ? storage_3 : _GEN_53; // @[CircularFifo.scala 82:{15,15}]
  assign io_deq_doutValid = _T ? 1'h0 : 1'h1; // @[CircularFifo.scala 83:26]
  always @(posedge clock) begin
    if (reset) begin // @[CircularFifo.scala 34:28]
      readPointer <= 2'h0; // @[CircularFifo.scala 34:28]
    end else if (!(stateReg == 2'h0)) begin // @[CircularFifo.scala 43:27]
      if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
        readPointer <= _GEN_25;
      end else if (stateReg == 2'h2) begin // @[CircularFifo.scala 72:35]
        readPointer <= _GEN_25;
      end
    end
    if (reset) begin // @[CircularFifo.scala 35:29]
      writePointer <= 2'h0; // @[CircularFifo.scala 35:29]
    end else if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      writePointer <= _GEN_4;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      writePointer <= _GEN_4;
    end
    if (reset) begin // @[CircularFifo.scala 36:28]
      readWrapBit <= 1'h0; // @[CircularFifo.scala 36:28]
    end else if (!(stateReg == 2'h0)) begin // @[CircularFifo.scala 43:27]
      if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
        readWrapBit <= _GEN_26;
      end else if (stateReg == 2'h2) begin // @[CircularFifo.scala 72:35]
        readWrapBit <= _GEN_26;
      end
    end
    if (reset) begin // @[CircularFifo.scala 37:29]
      writeWrapBit <= 1'h0; // @[CircularFifo.scala 37:29]
    end else if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      writeWrapBit <= _GEN_5;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      writeWrapBit <= _GEN_5;
    end
    if (reset) begin // @[CircularFifo.scala 39:25]
      stateReg <= 2'h0; // @[CircularFifo.scala 39:25]
    end else if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      if (io_enq_write & io_enq_dinValid) begin // @[CircularFifo.scala 45:42]
        stateReg <= 2'h1; // @[CircularFifo.scala 48:16]
      end
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      if (io_deq_read) begin // @[CircularFifo.scala 63:22]
        stateReg <= _GEN_23;
      end else begin
        stateReg <= _GEN_16;
      end
    end else if (stateReg == 2'h2) begin // @[CircularFifo.scala 72:35]
      stateReg <= _GEN_29;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      storage_0 <= _GEN_7;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      storage_0 <= _GEN_7;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      storage_1 <= _GEN_8;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      storage_1 <= _GEN_8;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      storage_2 <= _GEN_9;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      storage_2 <= _GEN_9;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 43:27]
      storage_3 <= _GEN_10;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 52:38]
      storage_3 <= _GEN_10;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  readPointer = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  writePointer = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  readWrapBit = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  writeWrapBit = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  stateReg = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  storage_0 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  storage_1 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  storage_2 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  storage_3 = _RAND_8[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
