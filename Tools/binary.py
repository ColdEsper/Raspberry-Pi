class BinaryPoint:
	def __init__ (self,value,precision):
		self.bp = precision
		self.integer = int(value*2**precision)
		self.actual = value
	def binary (self):
		return bin(self.integer)
	def display (self):
		print(self.actual)
		print(self.binary())
		print("bp "+str(-self.bp))
