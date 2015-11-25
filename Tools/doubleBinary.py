import sys
if int(sys.version_info[0]) < 3:
	input = raw_input
print("What is the value you wish to convert?")
val = input()
if val.find("/") != -1:
	operands= val.split("/")
	val = float(operands[0])/float(operands[1])
else:
	val = float(val)
if (val>= 0):
	sign = '0'
else:
	val=-val
	sign = '1'
print("intermediary steps:")
print("  value:"+str(val))
result = bin(int(val))[2:]
print("  binary: "+result)
power = 0
shiftedVal = val
while (int(shiftedVal) < 1):
	power-=4
	shiftedVal*=16
while (int(shiftedVal) > 1):
	power+=1
	shiftedVal/=2
assert(int(shiftedVal)==1)
val-=int(val)
while len(result) < 52-power:
	val *= 16
	print("  value:"+str(val))
	clip = int(val)
	if int(clip) & 8:
		result+="1"
	else:
		result+="0"
	if int(clip) & 4:
		result+="1"
	else:
		result+="0"
	if int(clip) & 2:
		result+="1"
	else:
		result+="0"
	if int(clip) & 1:
		result+="1"
	else:
		result+="0"
	print("  binary: "+result[-4::])
	val -= clip
while result[0] != '1':
	result = result[1:]
result = result[1:53]
assert(len(result) == 52)
power+=1023
power=bin(power)[2:]
while len(power) < 11:
	power = '0'+power
assert(len(power)==11)
print("Displaying value...")
bitForm = sign+power+result
assert(len(bitForm)==64)
print(bitForm+"b")
hexForm=""
bitPlace=0
highHex = ["A","B","C","D","E","F"]
for (eight,four,two,one) in list(zip(bitForm[0::4],bitForm[1::4],
		bitForm[2::4],bitForm[3::4])):
	val = 0
	if eight == '1':
		val+=8
	if four == '1':
		val+=4
	if two == '1':
		val+=2
	if one == '1':
		val+=1
	if val > 9:
		val-=10
		hexForm+=highHex[val]
	else:
		hexForm+=str(val)
assert(len(hexForm) == 16)
print("0x"+hexForm)
