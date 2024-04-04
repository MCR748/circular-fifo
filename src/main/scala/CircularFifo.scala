//Use namespaces if required

import chisel3._
import chisel3.util._
import os.truncate

class WriterIO(size: Int) extends Bundle {
  val write = Input(Bool())
  val full = Output(Bool())
  val din = Input(UInt(size.W))
  val dinValid = Input(Bool())
}

class ReaderIO(size: Int) extends Bundle {
  val read = Input(Bool())
  val empty = Output(Bool())
  val dout = Output(UInt(size.W))
  val doutValid = Output(Bool())
}

// Change the module name
class CircularFifo(size: Int, depth: Int) extends Module {
  val io = IO(new Bundle{
      //Add input output ports
      val enq = new WriterIO(size)
      val deq = new ReaderIO(size)
  })
  object State extends ChiselEnum{
    val empty, available, full = Value
  }
  import State._

  //One additional bit is needed to distinguish between empty state and full state
  val readPointer = RegInit(0.U((log2Ceil(depth)).W))
  val writePointer = RegInit(0.U((log2Ceil(depth)).W))
  val readWrapBit = RegInit(false.B)
  val writeWrapBit = RegInit(false.B)
  //Need to write in a different way
  val stateReg = RegInit(empty)
  val dataReg = RegInit(0.U(size.W))
  val storage = Reg(Vec(depth,UInt(size.W)))

  when(stateReg === empty){
    
    when(io.enq.write && io.enq.dinValid){
      writePointer := Mux(writePointer === depth.U - 1.U,0.U,writePointer + 1.U)
      writeWrapBit := Mux(writePointer === depth.U - 1.U,!writeWrapBit,writeWrapBit)
      stateReg := available
      storage(writePointer) := io.enq.din
    }

  } .elsewhen(stateReg === available){
    when(io.enq.write && io.enq.dinValid){
      //logic to full state
      
      when((readPointer === writePointer) && (readWrapBit === !writeWrapBit)){
        stateReg := full
      }
      storage(writePointer) := io.enq.din
      writePointer := Mux(writePointer === depth.U - 1.U,0.U,writePointer + 1.U)
      writeWrapBit := Mux(writePointer === depth.U - 1.U,!writeWrapBit,writeWrapBit)
    }
    when(io.deq.read){
      //logic to empty state
      when((readPointer === writePointer) && (readWrapBit === writeWrapBit)){
        stateReg := empty
      }
      readPointer := Mux(readPointer === depth.U - 1.U,0.U,readPointer + 1.U)
      readWrapBit := Mux(readPointer === depth.U - 1.U,!readWrapBit,readWrapBit)
    }

  } .elsewhen((stateReg === full)){
    when(io.deq.read){
      readPointer := Mux(readPointer === depth.U - 1.U,0.U,readPointer + 1.U)
      readWrapBit := Mux(readPointer === depth.U - 1.U,!readWrapBit,readWrapBit)
      stateReg := available
    }
  }
  
  io.enq.full := (stateReg === full)
  io.deq.empty := (stateReg === empty)
  io.deq.dout := storage(readPointer)
  io.deq.doutValid := Mux(stateReg === empty, false.B, true.B)
}

// To generate the verilog hardware
// Change the module name as required
object MemModuleMain extends App {
  println("Generating the adder hardware")
  //Hardware files will be out into generated
  emitVerilog(new CircularFifo(size = 8, depth = 4), Array("--target-dir", "generated"))
}
