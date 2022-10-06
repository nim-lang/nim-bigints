import ../bigints
import std/sequtils
import std/options
import std/random

proc rand*(r: var Rand, x: Slice[BigInt]): BigInt =
  assert(x.a <= x.b, "invalid range")
  let
    spread = x.b - x.a
    # number of bits *not* including leading bit
    nbits = spread.fastLog2
    # number of limbs to generate completely randomly
    nFullLimbs = max(nbits div 32 - 1, 0)
    # highest possible value of the top two limbs.
    hi64Max = (spread shr (nFullLimbs*32)).toInt[:uint64].get()
  while true:
    # these limbs can be generated completely randomly
    var limbs = newSeqWith(nFullLimbs, r.rand(uint32.low..uint32.high))
    # generate the top two limbs more carefully. This all but guarantees
    # that the entire number is in the correct range
    let hi64 = r.rand(uint64.low..hi64Max)
    limbs.add(cast[uint32](hi64))
    limbs.add(cast[uint32](hi64 shr 32))
    result = initBigInt(limbs)
    if result <= spread:
      break
  result += x.a

proc rand*(r: var Rand, max: BigInt): BigInt =
  rand(r, 0'bi..max)

proc rand*(x: Slice[BigInt]): BigInt = rand(randState(), x)
proc rand*(max: BigInt): BigInt = rand(randState(), max)

