# Digital Audio Echo Generator in MATLAB

A MATLAB-based Digital Signal Processing (DSP) application that applies a configurable, time-delayed echo effect to discrete audio signals, featuring automatic amplitude normalization to prevent audio clipping.

## 📁 Project Overview
This project implements a core DSP function, `echo_gen`, which takes an input audio signal vector and superimposes a time-delayed, attenuated version of itself to simulate a physical acoustic echo. 

The implementation handles discrete signal padding, offset calculations based on sampling frequencies, and includes an optimization layer to scale the final mixed signal if its magnitude exceeds standard audio bounds ($[-1, 1]$).

### Key Engineering Features
* **Time-to-Sample Vector Mapping:** Computes exact sample delays from continuous time parameters using discrete sampling rates ($f_s$).
* **Signal Zero-Padding:** Dynamically extends audio vectors to accommodate delayed signals without data loss.
* **Peak Amplitude Normalization:** Implements clipping protection by dynamically scaling the unified audio matrix relative to its absolute peak value ($\text{max}(|O_1|)$).

---

## ⚙️ How It Works (Mathematical Approach)

Given an input signal $y[n]$, a sampling frequency $Fs$, a time delay $\Delta t$, and an amplification factor $\alpha$:

1. **Sample Delay Calculation:** 
   $$r = \text{round}(\Delta t \cdot Fs)$$
2. **Signal Mixing:** The original signal is zero-padded at the end, and the echo signal is zero-padded at the beginning by $r$ samples to align them perfectly in time:
   $$O_1 = y_{\text{padded}} + \alpha \cdot y_{\text{delayed}}$$
3. **Clipping Prevention:** If $\max(|O_1|) > 1$, the signal is normalized:
   $$O = \frac{O_1}{\max(|O_1|)}$$

---

## 💻 Code Structure

### 1. The Core Function: `echo_gen.m`
```matlab
function o = echo_gen(y, fs, delay, amp)
    dt = 1/fs;
    t = 0:dt:dt*(length(y)-1);
    r = round(delay*fs);
    d = zeros(r,1);
    
    % Pad vectors to align signals in time
    p_y = [y; d];
    p_echo = [d; y * amp];
    
    o1 = p_y + p_echo;
    
    % Peak amplitude checking & normalization
    m = max(abs(o1));
    if m > 1
        o = o1 / m;
    else
        o = o1;
    end
end
