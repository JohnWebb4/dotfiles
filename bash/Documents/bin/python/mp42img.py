import cv2
import sys

filename = sys.argv[1] if len(sys.argv) > 1 else ""

if not filename.strip():
    sys.exit("Missing video to read");


video = cv2.VideoCapture(filename)

success, image = video.read()
count = 0

if not success:
    sys.exit("Failed to open file")

while success:
    cv2.imwrite("image{:03d}.jpg".format(count), image)
    success, image = video.read()

    print("Completed frame ", count)
    count += 1
