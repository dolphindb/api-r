import sys

if __name__ == '__main__':
    if len(sys.argv)<2:
        print("Usage: python Rsummary.py <ROut.txt>")
    total = 0
    failed = 0
    failedList = []
    failedIdx = -1
    with open(sys.argv[1]) as fin:
        for idx, line in enumerate(fin):
            if idx == failedIdx:
                failedList.append(line.strip())
                failedIdx = -1
            k = line.find("Build Failed:")
            if k >= 0:
                ff, ss  = line[(k+len("Build Failed:")):].strip().split("/")
                ff = int(ff.strip())
                ss = int(ss.strip())
                failed += ff
                total += ss
                if ff>0:
                    failedIdx = idx + 1

    print("Total failed: " + str(failed) + " / " + str(total))

    if len(failedList):
        toPrint = 0
        with open(sys.argv[1]) as fin:
            for idx, line in enumerate(fin):
                if line.strip() in failedList:
                    if toPrint == 0:
                        print(line.strip()+"\n")
                    toPrint += 1
                    if toPrint>1:
                        toPrint = 0
                    else:
                        continue
                if toPrint == 1:
                    print(line.strip()+"\n")
