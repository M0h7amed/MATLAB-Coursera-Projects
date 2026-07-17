# Digital Image Blurring (Spatial Mean Filter)

A MATLAB-based digital image processing tool that applies a customizable blur effect to grayscale images using a dynamically sizing spatial mean filter.

## 📁 Project Overview
In computer vision and image processing, blurring (or smoothing) is utilized to reduce image noise and detail. This project implements a core local averaging algorithm from scratch. 

The `blur` function processes a 2D matrix of `uint8` grayscale pixels. It calculates the mean value of neighboring pixels within a $(2w+1) \times (2w+1)$ sliding window, where $w$ is a user-defined parameter controlling the intensity of the blur. 

### Key Engineering Features
* **Customizable Kernel Sizing:** The user dictates the size of the blurring window dynamically via the input parameter $w$.
* **Dynamic Boundary Handling:** The algorithm intelligently handles edge and corner pixels. Instead of failing or requiring artificial image padding, it uses boundary clamping (`max` and `min` bounds) to average only the valid pixels available within the image dimensions.
* **Data Type Management:** Ensures matrix outputs are strictly recast to `uint8` format to maintain standard image encoding protocols.

---

## ⚙️ Mathematical Logic

For an image matrix $I$ of size $R \times C$, the output pixel value at row $i$ and column $j$ is the arithmetic mean of the submatrix defined by the window $w$:

$$O(i,j) = \frac{1}{N} \sum_{x=i-w}^{i+w} \sum_{y=j-w}^{j+w} I(x,y)$$

Where $N$ is the total number of valid pixels within the submatrix boundaries. The algorithm constrains the bounds to ensure $1 \le x \le R$ and $1 \le y \le C$.

---

## 💻 Code Structure

### 1. Core Algorithm: `blur.m`
```matlab
function o = blur(img, w)
    % Get image dimensions
    r = size(img,1);
    c = size(img,2);
    
    % Initialize output matrix
    o = zeros(r, c, 'uint8');

    % Apply spatial mean filter with boundary handling
    for i = 1:r
        for j = 1:c
            % Extract valid submatrix using boundary clamping
            sub = img(max(1, i-w) : min(r, i+w), max(1, j-w) : min(c, j+w));
            
            % Calculate mean and assign to output
            o(i,j) = uint8(mean(sub(:)));
        end
    end
end
