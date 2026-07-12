# generate_maps.py
import cv2
import numpy as np
from pathlib import Path
from PIL import Image

def generate_maps(input_path):
    img = cv2.imread(str(input_path), cv2.IMREAD_GRAYSCALE)
    name = input_path.stem

    # Generate bump map (grayscale height)
    bump = cv2.GaussianBlur(img, (9, 9), 0)
    cv2.imwrite(f"{name}-bump.png", bump)

    # Generate roughness map (invert contrast)
    rough = 255 - cv2.equalizeHist(img)
    cv2.imwrite(f"{name}-roughness.png", rough)

    # Generate normal map (basic Sobel approach)
    dx = cv2.Sobel(bump, cv2.CV_32F, 1, 0, ksize=5)
    dy = cv2.Sobel(bump, cv2.CV_32F, 0, 1, ksize=5)
    dz = np.ones_like(dx) * 255
    normals = cv2.merge((dx, dy, dz))
    normals = cv2.normalize(normals, None, 0, 255, cv2.NORM_MINMAX)
    cv2.imwrite(f"{name}-normal.png", normals)

if __name__ == "__main__":
    base_dir = Path("../egohygiene.io/public/assets/textures/planets")
    for file in base_dir.glob("*.png"):
        if "-bump" not in file.stem and "-normal" not in file.stem and "-roughness" not in file.stem:
            print(f"Processing {file.name}...")
            generate_maps(file)
