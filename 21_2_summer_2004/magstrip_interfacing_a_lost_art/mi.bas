Public Function SwipeCard() As String

Dim cardOut As String 	'Will hold the final string of Card Characters
Dim cardRaw(1 To 240) As Byte 'array to hold samples each bit on the magcard.

'============================================GATHER RAW BIT STREAM
'Reads the DATA bits from the card by trapping the CLK signal

For k = 1 To 240
    Do
        DoEvents 	'VB specfic statement, lets you yield so programs doesn't
			'hog CPU. On slow/high-loaded machines this could be removed
			'to make sure time critical loop happens

	e = Inp(&H201)		'Read in byte
    Loop Until (e And 32) = 0	'wait until CLK goes high
    'since the CLK is high, DATA is valid, so save
    cardRaw(k) = e


    'wait for CLK to go low again
    Do
        e = Inp(&H201)
    Loop Until (e And 32) = 32
Next

'============================================CONVERT ARRAY TO BITSTREAM
'Since the array cardRaw has the CLK bits, DATA bits, and other junk
'we AND the DATA bit out, and set that entry in the array to the value
'of the DATA bit. All entries in cardRAW will be 0 or 1 after this

For k = 1 To 240
    cardRaw(k) = (cardRaw(k) And 16)
    If cardRaw(k) = 0 Then cardRaw(k) = 1
    If cardRaw(k) = 16 Then cardRaw(k) = 0
Next


'============================================LOCATE START AND END OF BITSTREAM
'Since cards can have any number of leading and trailing zeros, we need
'to find where start character ";" is. Then we will know where the 5 bit
boundries fall to define the characters. We also look for the End character "?"

j = 0 'start at index 0 of the array
'Loop until we find "11010" which is the start character
Do
    j = j + 1
Loop Until (cardRaw(j) = 1 And cardRaw(j + 1) = 1 And cardRaw(j + 2) = 0 And cardRaw(j + 3) = 1 And cardRaw(j + 4) = 0)

starts = j 'save its location

'Now loop through, jumping 5 bits at a time (ie 1 character at a time)
'until we find "11111" which is the end chacter
Do
	j = j + 5
Loop Until (cardRaw(j) = 1 And cardRaw(j + 1) = 1 And cardRaw(j + 2) = 1 And cardRaw(j + 3) = 1 And cardRaw(j + 4) = 1)

ends = j 'save its location

'============================================DECODE BITSTREAM TO OUTPUT STRING
'We walk through the array at 1 character at a time (5 bits at a time)
'from the start character to the end character (this ay we avoid the leading
 and trailing zeros, as well as the LRC checksum)
'We examine those 5 bits and append the appropriate character to the end of the
'string

cardOut = "" 'empty the string

For j = starts To ends Step 5 'for(j=starts;j<=ends;j+=5)

If (cardRaw(j) = 1) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + ";"
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + "="
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "?"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + ":"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "<"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + ">"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "0"
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + "1"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + "2"
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "3"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + "4"
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "5"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "6"
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 1) And (cardRaw(j + 2) = 1) And (cardRaw(j + 3) = 0) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + "7"
If (cardRaw(j) = 0) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 0) Then cardOut = cardOut + "8"
If (cardRaw(j) = 1) And (cardRaw(j + 1) = 0) And (cardRaw(j + 2) = 0) And (cardRaw(j + 3) = 1) And (cardRaw(j + 4) = 1) Then cardOut = cardOut + "9"

Next

'Return the string
SwipeCard = cardOut
End Function
