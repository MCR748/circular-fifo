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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] readPointer; // @[CircularFifo.scala 34:28]
  wire [2:0] _nextValue_T_1 = 3'h4 - 3'h1; // @[CircularFifo.scala 35:47]
  wire [2:0] _GEN_46 = {{1'd0}, readPointer}; // @[CircularFifo.scala 35:35]
  wire [1:0] _nextValue_T_4 = readPointer + 2'h1; // @[CircularFifo.scala 35:69]
  wire [1:0] nextReadPointer = _GEN_46 == _nextValue_T_1 ? 2'h0 : _nextValue_T_4; // @[CircularFifo.scala 35:24]
  reg [1:0] stateReg; // @[CircularFifo.scala 48:25]
  wire  _T = stateReg == 2'h0; // @[CircularFifo.scala 52:17]
  wire  _GEN_25 = stateReg == 2'h2 & io_deq_read; // @[CircularFifo.scala 78:35 84:14]
  wire  _GEN_34 = stateReg == 2'h1 ? io_deq_read : _GEN_25; // @[CircularFifo.scala 60:38]
  wire  readIncr = stateReg == 2'h0 ? 1'h0 : _GEN_34; // @[CircularFifo.scala 52:27 42:29]
  reg [1:0] writePointer; // @[CircularFifo.scala 34:28]
  wire [2:0] _GEN_47 = {{1'd0}, writePointer}; // @[CircularFifo.scala 35:35]
  wire [1:0] _nextValue_T_9 = writePointer + 2'h1; // @[CircularFifo.scala 35:69]
  wire [1:0] nextWritePointer = _GEN_47 == _nextValue_T_1 ? 2'h0 : _nextValue_T_9; // @[CircularFifo.scala 35:24]
  wire  _T_1 = io_enq_write & io_enq_dinValid; // @[CircularFifo.scala 54:23]
  wire  _GEN_33 = stateReg == 2'h1 & _T_1; // @[CircularFifo.scala 60:38]
  wire  writeIncr = stateReg == 2'h0 ? _T_1 : _GEN_33; // @[CircularFifo.scala 52:27]
  reg [7:0] storage_0; // @[CircularFifo.scala 50:20]
  reg [7:0] storage_1; // @[CircularFifo.scala 50:20]
  reg [7:0] storage_2; // @[CircularFifo.scala 50:20]
  reg [7:0] storage_3; // @[CircularFifo.scala 50:20]
  wire [7:0] _GEN_0 = 2'h0 == writePointer ? io_enq_din : storage_0; // @[CircularFifo.scala 50:20 56:{29,29}]
  wire [7:0] _GEN_1 = 2'h1 == writePointer ? io_enq_din : storage_1; // @[CircularFifo.scala 50:20 56:{29,29}]
  wire [7:0] _GEN_2 = 2'h2 == writePointer ? io_enq_din : storage_2; // @[CircularFifo.scala 50:20 56:{29,29}]
  wire [7:0] _GEN_3 = 2'h3 == writePointer ? io_enq_din : storage_3; // @[CircularFifo.scala 50:20 56:{29,29}]
  wire [7:0] _GEN_5 = io_enq_write & io_enq_dinValid ? _GEN_0 : storage_0; // @[CircularFifo.scala 50:20 54:42]
  wire [7:0] _GEN_6 = io_enq_write & io_enq_dinValid ? _GEN_1 : storage_1; // @[CircularFifo.scala 50:20 54:42]
  wire [7:0] _GEN_7 = io_enq_write & io_enq_dinValid ? _GEN_2 : storage_2; // @[CircularFifo.scala 50:20 54:42]
  wire [7:0] _GEN_8 = io_enq_write & io_enq_dinValid ? _GEN_3 : storage_3; // @[CircularFifo.scala 50:20 54:42]
  wire [1:0] _GEN_10 = readPointer == nextWritePointer ? 2'h2 : stateReg; // @[CircularFifo.scala 64:48 65:18 48:25]
  wire [1:0] _GEN_15 = _T_1 ? _GEN_10 : stateReg; // @[CircularFifo.scala 48:25 61:42]
  wire [1:0] _GEN_21 = nextReadPointer == writePointer ? 2'h0 : _GEN_15; // @[CircularFifo.scala 72:48 73:18]
  wire [1:0] _GEN_24 = io_deq_read ? 2'h1 : stateReg; // @[CircularFifo.scala 79:22 81:16 48:25]
  wire [7:0] _GEN_43 = 2'h1 == readPointer ? storage_1 : storage_0; // @[CircularFifo.scala 91:{15,15}]
  wire [7:0] _GEN_44 = 2'h2 == readPointer ? storage_2 : _GEN_43; // @[CircularFifo.scala 91:{15,15}]
  assign io_enq_full = stateReg == 2'h2; // @[CircularFifo.scala 89:28]
  assign io_deq_empty = stateReg == 2'h0; // @[CircularFifo.scala 90:29]
  assign io_deq_dout = 2'h3 == readPointer ? storage_3 : _GEN_44; // @[CircularFifo.scala 91:{15,15}]
  assign io_deq_doutValid = _T ? 1'h0 : 1'h1; // @[CircularFifo.scala 92:26]
  always @(posedge clock) begin
    if (reset) begin // @[CircularFifo.scala 34:28]
      readPointer <= 2'h0; // @[CircularFifo.scala 34:28]
    end else if (readIncr) begin // @[CircularFifo.scala 36:21]
      if (_GEN_46 == _nextValue_T_1) begin // @[CircularFifo.scala 35:24]
        readPointer <= 2'h0;
      end else begin
        readPointer <= _nextValue_T_4;
      end
    end
    if (reset) begin // @[CircularFifo.scala 48:25]
      stateReg <= 2'h0; // @[CircularFifo.scala 48:25]
    end else if (stateReg == 2'h0) begin // @[CircularFifo.scala 52:27]
      if (io_enq_write & io_enq_dinValid) begin // @[CircularFifo.scala 54:42]
        stateReg <= 2'h1; // @[CircularFifo.scala 55:16]
      end
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 60:38]
      if (io_deq_read) begin // @[CircularFifo.scala 70:22]
        stateReg <= _GEN_21;
      end else begin
        stateReg <= _GEN_15;
      end
    end else if (stateReg == 2'h2) begin // @[CircularFifo.scala 78:35]
      stateReg <= _GEN_24;
    end
    if (reset) begin // @[CircularFifo.scala 34:28]
      writePointer <= 2'h0; // @[CircularFifo.scala 34:28]
    end else if (writeIncr) begin // @[CircularFifo.scala 36:21]
      if (_GEN_47 == _nextValue_T_1) begin // @[CircularFifo.scala 35:24]
        writePointer <= 2'h0;
      end else begin
        writePointer <= _nextValue_T_9;
      end
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 52:27]
      storage_0 <= _GEN_5;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 60:38]
      storage_0 <= _GEN_5;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 52:27]
      storage_1 <= _GEN_6;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 60:38]
      storage_1 <= _GEN_6;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 52:27]
      storage_2 <= _GEN_7;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 60:38]
      storage_2 <= _GEN_7;
    end
    if (stateReg == 2'h0) begin // @[CircularFifo.scala 52:27]
      storage_3 <= _GEN_8;
    end else if (stateReg == 2'h1) begin // @[CircularFifo.scala 60:38]
      storage_3 <= _GEN_8;
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
  stateReg = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  writePointer = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  storage_0 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  storage_1 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  storage_2 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  storage_3 = _RAND_6[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
