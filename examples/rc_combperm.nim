# Solution for http://rosettacode.org/wiki/Combinations_and_permutations
import bigints

const
  zero = 0.initBigInt

proc perm(n, k: int32): BigInt =
  result = initBigInt 1
  var
    k = initBigInt(n - k)
    n = initBigInt(n)
  while n > k:
    result *= n
    dec n

proc comb(n, k: int32): BigInt =
  result = perm(n, k)
  var k = initBigInt(k)
  while k > zero:
    result = result div k
    dec k

echo "P(1000, 969) = ", perm(1000, 969)
echo "C(1000, 969) = ", comb(1000, 969)
