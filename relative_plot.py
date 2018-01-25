import matplotlib.pyplot as plt
import os, subprocess
import numpy

def getKey(item):
	return int(item[0])

def getKey2(item):
        return int(item.split('c')[1])


colors=[(0,0,0),(1,0,0),(0,1,0),(0,0,1),(0.6,0.2,0.6),(0.4,0.4,0.2)]

lgd=[]
k=0
b=[]




size=[]
bw=[]
for file in os.listdir("/tmp/calc/vec1"):
	nfile= "/tmp/calc/vec1/" + file
	iof = open(nfile,"r")
	lines = iof.readlines()
	if (len(lines) > 0):
		txt= lines[1].split(" ")
		txt[:] = (value for value in txt if value != "")
		iof.close()
		size.append(int(txt[0]))
		bw.append(float(txt[3]))
	else:
		print("Missing: vec %s" % NUM)
both=sorted(zip(size,bw),key=getKey)
b = [bw for (NULL,bw) in both]

for dir in sorted(os.listdir('/tmp/calc'),key=getKey2):
	size=[]
	bw=[]
	NUM=dir.split('c')[1]
	for file in os.listdir("/tmp/calc/" + dir):
		nfile= "/tmp/calc/" + dir + "/" + file
		iof = open(nfile,"r")
		lines = iof.readlines()
		if (len(lines) > 0):
                	txt= lines[1].split(" ")
			txt[:] = (value for value in txt if value != "")
			iof.close()
                        size.append(int(txt[0]))
                        bw.append(float(txt[3]))
		else:
			print("Missing: vec %s" % NUM)
	both=sorted(zip(size,bw),key=getKey)
	size = [size for (size,NULL) in both]
        bw = [bw for (NULL,bw) in both]

	rel_bw = [Bw/B for (Bw,B) in zip(bw,b)]
	plt.semilogx(size, rel_bw, c=colors[k], basex=2)
	k= k+1
	lgd.append(NUM)
	plt.xlabel("Size [byte]")
	plt.ylabel("Normalized BW")	
        colors.append(numpy.random.rand(3,))



plt.title("Vector Calc results, Add Float32")
plt.legend(lgd)
plt.show()
