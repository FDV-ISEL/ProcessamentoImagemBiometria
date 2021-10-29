import cv2
import numpy as np

name = "boat"
# name = "mandrill"
# name = "squares"

image_path = name + ".tif"

image = cv2.imread(image_path)

cv2.imshow("Original image", image)

brightness_image = cv2.convertScaleAbs(image, alpha=1, beta=-50)
cv2.imshow("Image with brightness variation", brightness_image)
cv2.imwrite(name + "_brightness.tif", brightness_image)

c = 255/(np.log(1 + np.max(image)))
contrast_image = c * np.log(1 + image)

contrast_image = np.array(contrast_image, dtype=np.uint8)
cv2.imshow("Image with contrast variation", contrast_image)
cv2.imwrite(name + "_contrast.tif", contrast_image)

cv2.waitKey(0)
cv2.destroyAllWindows()
