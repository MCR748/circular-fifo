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

  def counter(incr: Bool, depth: Int): (UInt, UInt) = {
    val currValue = RegInit(0.U((log2Ceil(depth)).W))
    val nextValue = Mux(currValue === depth.U - 1.U, 0.U, currValue + 1.U)
    currValue := Mux(incr, nextValue, currValue)
    //Returning UInt values
    (currValue, nextValue)
  }

  //One additional bit is needed to distinguish between empty state and full state
  val readIncr = WireDefault(false.B)
  val writeIncr = WireDefault(false.B)
  val (readPointer, nextReadPointer) = counter(readIncr, depth)
  val (writePointer, nextWritePointer) =  counter(writeIncr, depth)

  //Need to write in a different way
  val stateReg = RegInit(empty)
  val dataReg = RegInit(0.U(size.W))
  val storage = Reg(Vec(depth,UInt(size.W)))

  when(stateReg === empty){
    
    when(io.enq.write && io.enq.dinValid){
      stateReg := available
      storage(writePointer) := io.enq.din
      writeIncr := true.B
    }

  } .elsewhen(stateReg === available){
    when(io.enq.write && io.enq.dinValid){
      //logic to full state
      
      when((readPointer === nextWritePointer) ){
        stateReg := full
      }
      storage(writePointer) := io.enq.din
      writeIncr := true.B
    }
    when(io.deq.read){
      //logic to empty state
      when((nextReadPointer === writePointer) ){
        stateReg := empty
      }
      readIncr := true.B
    }

  } .elsewhen((stateReg === full)){
    when(io.deq.read){
      readIncr := true.B
      stateReg := available
    }
  } .otherwise{
    readIncr := false.B
    writeIncr := false.B

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
