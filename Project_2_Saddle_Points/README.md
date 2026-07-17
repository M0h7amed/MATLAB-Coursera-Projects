# Matrix Saddle Point Finder & 3D Visualization

A MATLAB project that computationally identifies "saddle points" within 2D matrices and visually maps them onto a 3D surface projection. 

## 📁 Project Overview
In mathematics and optimization, a saddle point is a point on the surface of the graph of a function where the slopes in orthogonal directions are all zero, but which is not a local extremum of the function. 

This program evaluates a matrix $M$ to find any element that satisfies two simultaneous conditions:
1. It is the maximum value in its respective row.
2. It is the minimum value in its respective column.

If these conditions are met, the algorithm returns the exact $[row, column]$ indices of the saddle point and plots a 3D topographic representation of the dataset.

---

## ⚙️ Mathematical Logic

An element $M(i,j)$ is identified as a saddle point if and only if:
$$M(i,j) \ge M(i,k) \quad \text{for all } k \text{ (Max in Row)}$$
$$M(i,j) \le M(k,j) \quad \text{for all } k \text{ (Min in Column)}$$

The script uses a nested iterative approach to scan the $M$ matrix, comparing each scalar value against dynamically extracted row-maximums and column-minimums.

---

## 💻 Code Structure

### 1. Core Algorithm: `saddle.m`
```matlab
function in = saddle(M)
    in = [];
    % Iterate through rows and columns to find the minimax point
    for j = 1:size(M,1)
        maX = max(M(j,:));
        for i = 1:size(M,2)
            miN = min(M(:,i));
            % Check if current element satisfies saddle conditions
            if M(j,i) == maX && M(j,i) == miN
                in = [in; j, i];
            end
        end
    end
end
