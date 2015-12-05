def sqrt (value):
	xGuess = value/2.0
	xNext = None
	xPrev = xGuess
	#another previous term added for a value that jumps back and forth
	xPrevTwo = xGuess
	while xNext != xPrev and xNext != xPrevTwo:
		xNext = xGuess - (xGuess*xGuess-value)/(2*xGuess)
		xPrevTwo = xPrev
		xPrev = xGuess
		xGuess = xNext
	return xNext

if __name__=="__main__":
	print("What is the weight of the object?")
	weight = float(input())
	print("What is the coefficient of drag of the object?")
	coefficient = float(input())
	print("What is the area of the object?")
	area = (float(input())
	print("What is the density of the object?")
	density = float(input())
	velocity = sqrt((2*weight)/(coefficient*density*area))
	print("terminal velocity is "+str(velocity))
	dynamicPressure = 0.5*density*velocity**2
	print("Dynamic pressure at terminal velocity is "+str(dynamicPressure))
