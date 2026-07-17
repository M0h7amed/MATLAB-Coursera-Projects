# Digital Audio Echo Generator in MATLAB

A MATLAB-based Digital Signal Processing (DSP) application that applies a configurable, time-delayed echo effect to discrete audio signals, featuring automatic amplitude normalization to prevent audio clipping.

## 📁 Project Overview
This project implements a core DSP function, `echo_gen`, which takes an input audio signal vector and superimposes a time-delayed, attenuated version of itself to simulate a physical acoustic echo. 

The implementation handles discrete signal padding, offset calculations based on sampling frequencies, and includes an optimization layer to scale the final mixed signal if its magnitude exceeds standard audio bounds ($[-1, 1]$).

### Key Engineering Features
* **Time-to-Sample Vector Mapping:** Computes exact sample delays from continuous time parameters using discrete sampling rates ($fs$).
* **Signal Zero-Padding:** Dynamically extends audio vectors to accommodate delayed signals without data loss.
* **Peak Amplitude Normalization:** Implements clipping protection by dynamically scaling the unified audio matrix relative to its absolute peak value ($\text{max}(|\text{echo}|)$).

---

## ⚙️ How It Works (Mathematical Approach)

Given an input signal $y[n]$, a sampling frequency $fs$, a time delay $\Delta t$, and an amplification factor $\alpha$:

1. **Sample Delay Calculation:** 
   $$r = \text{round}(\Delta t \cdot fs)$$
2. **Signal Mixing:** The original signal is zero-padded at the end, and the echo signal is zero-padded at the beginning by $r$ samples to align them perfectly in time:
   $$\text{echo} = y_{\text{padded}} + \alpha \cdot y_{\text{delayed}}$$
3. **Clipping Prevention:** If $\max(|\text{echo}|) > 1$, the final output $oP$ is normalized:
   $$oP = \frac{\text{echo}}{\max(|\text{echo}|)}$$

---

## 💻 Code Structure

### 1. The Core Function: `echo_gen.m`
```matlab
function oP=echo_gen(y, fs, delay, amp)
    %% ECHO GENERATION FUNCTION
    % (y) sound data
    % (fs) sampling rate : number of rows in 1 second
    % (delay) : delay time needed
    
    r=round(delay*fs);
    d=zeros(r,1);
    
    % Pad vectors to align signals in time
    p_y = [y; d];
    p_echo = [d; y * amp];
    
    echo=p_y+p_echo; 
    
    % Peak amplitude checking & normalization
    m=max(abs(echo));
    if m>1
        oP=(echo)/m;
    else
        oP= echo ;
    end
end
