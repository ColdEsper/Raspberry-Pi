class BinaryPoint:
	def __init__ (self,value,precision):
		self.bp = precision
		self.integer = int(value*2**precision)
		self.actual = value
	def binary (self):
		return bin(self.integer)
	def hex (self):
		return hex(self.integer)
	def display (self):
		print(self.actual)
		print(self.binary())
		print(self.hex())
		print("bp "+str(-self.bp))

if __name__ == "__main__":
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
	print("How many bits to left shift?")
	precision = int(input())
	bp = BinaryPoint(val,precision)
	print("Displaying value...")
	bp.display()
