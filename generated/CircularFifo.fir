circuit CircularFifo :
  module CircularFifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { enq : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>, flip dinValid : UInt<1>}, deq : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>, doutValid : UInt<1>}}

    wire readIncr : UInt<1> @[CircularFifo.scala 42:29]
    readIncr <= UInt<1>("h0") @[CircularFifo.scala 42:29]
    wire writeIncr : UInt<1> @[CircularFifo.scala 43:30]
    writeIncr <= UInt<1>("h0") @[CircularFifo.scala 43:30]
    reg readPointer : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[CircularFifo.scala 34:28]
    node _nextValue_T = sub(UInt<3>("h4"), UInt<1>("h1")) @[CircularFifo.scala 35:47]
    node _nextValue_T_1 = tail(_nextValue_T, 1) @[CircularFifo.scala 35:47]
    node _nextValue_T_2 = eq(readPointer, _nextValue_T_1) @[CircularFifo.scala 35:35]
    node _nextValue_T_3 = add(readPointer, UInt<1>("h1")) @[CircularFifo.scala 35:69]
    node _nextValue_T_4 = tail(_nextValue_T_3, 1) @[CircularFifo.scala 35:69]
    node nextReadPointer = mux(_nextValue_T_2, UInt<1>("h0"), _nextValue_T_4) @[CircularFifo.scala 35:24]
    node _currValue_T = mux(readIncr, nextReadPointer, readPointer) @[CircularFifo.scala 36:21]
    readPointer <= _currValue_T @[CircularFifo.scala 36:15]
    reg writePointer : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[CircularFifo.scala 34:28]
    node _nextValue_T_5 = sub(UInt<3>("h4"), UInt<1>("h1")) @[CircularFifo.scala 35:47]
    node _nextValue_T_6 = tail(_nextValue_T_5, 1) @[CircularFifo.scala 35:47]
    node _nextValue_T_7 = eq(writePointer, _nextValue_T_6) @[CircularFifo.scala 35:35]
    node _nextValue_T_8 = add(writePointer, UInt<1>("h1")) @[CircularFifo.scala 35:69]
    node _nextValue_T_9 = tail(_nextValue_T_8, 1) @[CircularFifo.scala 35:69]
    node nextWritePointer = mux(_nextValue_T_7, UInt<1>("h0"), _nextValue_T_9) @[CircularFifo.scala 35:24]
    node _currValue_T_1 = mux(writeIncr, nextWritePointer, writePointer) @[CircularFifo.scala 36:21]
    writePointer <= _currValue_T_1 @[CircularFifo.scala 36:15]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[CircularFifo.scala 48:25]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[CircularFifo.scala 49:24]
    reg storage : UInt<8>[4], clock with :
      reset => (UInt<1>("h0"), storage) @[CircularFifo.scala 50:20]
    node _T = eq(stateReg, UInt<1>("h0")) @[CircularFifo.scala 52:17]
    when _T : @[CircularFifo.scala 52:27]
      node _T_1 = and(io.enq.write, io.enq.dinValid) @[CircularFifo.scala 54:23]
      when _T_1 : @[CircularFifo.scala 54:42]
        stateReg <= UInt<1>("h1") @[CircularFifo.scala 55:16]
        storage[writePointer] <= io.enq.din @[CircularFifo.scala 56:29]
        writeIncr <= UInt<1>("h1") @[CircularFifo.scala 57:17]
    else :
      node _T_2 = eq(stateReg, UInt<1>("h1")) @[CircularFifo.scala 60:24]
      when _T_2 : @[CircularFifo.scala 60:38]
        node _T_3 = and(io.enq.write, io.enq.dinValid) @[CircularFifo.scala 61:23]
        when _T_3 : @[CircularFifo.scala 61:42]
          node _T_4 = eq(readPointer, nextWritePointer) @[CircularFifo.scala 64:25]
          when _T_4 : @[CircularFifo.scala 64:48]
            stateReg <= UInt<2>("h2") @[CircularFifo.scala 65:18]
          storage[writePointer] <= io.enq.din @[CircularFifo.scala 67:29]
          writeIncr <= UInt<1>("h1") @[CircularFifo.scala 68:17]
        when io.deq.read : @[CircularFifo.scala 70:22]
          node _T_5 = eq(nextReadPointer, writePointer) @[CircularFifo.scala 72:29]
          when _T_5 : @[CircularFifo.scala 72:48]
            stateReg <= UInt<1>("h0") @[CircularFifo.scala 73:18]
          readIncr <= UInt<1>("h1") @[CircularFifo.scala 75:16]
      else :
        node _T_6 = eq(stateReg, UInt<2>("h2")) @[CircularFifo.scala 78:25]
        when _T_6 : @[CircularFifo.scala 78:35]
          when io.deq.read : @[CircularFifo.scala 79:22]
            readIncr <= UInt<1>("h1") @[CircularFifo.scala 80:16]
            stateReg <= UInt<1>("h1") @[CircularFifo.scala 81:16]
        else :
          readIncr <= UInt<1>("h0") @[CircularFifo.scala 84:14]
          writeIncr <= UInt<1>("h0") @[CircularFifo.scala 85:15]
    node _io_enq_full_T = eq(stateReg, UInt<2>("h2")) @[CircularFifo.scala 89:28]
    io.enq.full <= _io_enq_full_T @[CircularFifo.scala 89:15]
    node _io_deq_empty_T = eq(stateReg, UInt<1>("h0")) @[CircularFifo.scala 90:29]
    io.deq.empty <= _io_deq_empty_T @[CircularFifo.scala 90:16]
    io.deq.dout <= storage[readPointer] @[CircularFifo.scala 91:15]
    node _io_deq_doutValid_T = eq(stateReg, UInt<1>("h0")) @[CircularFifo.scala 92:36]
    node _io_deq_doutValid_T_1 = mux(_io_deq_doutValid_T, UInt<1>("h0"), UInt<1>("h1")) @[CircularFifo.scala 92:26]
    io.deq.doutValid <= _io_deq_doutValid_T_1 @[CircularFifo.scala 92:20]

