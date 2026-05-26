# FPGA CNN Accelerator for MNIST Digit Classification

## Overview

This project is a complete handwritten CNN accelerator implemented entirely in Verilog for FPGA-based inference on the MNIST handwritten digit dataset.

The accelerator performs:
- Convolution
- Multi-channel feature extraction
- Max Pooling
- ReLU activation
- Flattening
- Fully Connected inference
- Argmax digit prediction

using only fixed-point integer arithmetic.

The design takes a 28×28 grayscale image as input and outputs the predicted digit (0–9).

---

# Features

- Pure RTL Verilog implementation
- No HLS or framework-generated hardware
- Signed fixed-point quantized inference
- Multi-channel convolution architecture
- Sequential MAC-based accelerator
- Saturation arithmetic support
- End-to-end FPGA-compatible pipeline
- MNIST digit classification
- Fully parameterized memory-based weights

---

# CNN Architecture

## Block 1
- Input: 28×28 image
- 3 convolution filters (5×5)
- Output feature maps: 24×24×3
- Max Pooling (2×2)
- ReLU activation
- Output: 12×12×3

---

## Block 2
- Multi-channel convolution
- 3 output channels
- 5×5 kernels

Channel accumulation:

$$
y_k = \sum_{c=0}^{2} (x_c * w_{k,c})
$$

- Output feature maps: 8×8×3
- Max Pooling (2×2)
- ReLU activation
- Output: 4×4×3

---

## Fully Connected Layer
- Flattened input: 48 features
- 10 output neurons
- Produces logits for digits 0–9
- Argmax comparator generates final prediction

---

# Quantization

The accelerator uses:
- Signed 8-bit weights
- Signed 32-bit activations
- Signed 64-bit MAC accumulation
- Arithmetic right-shift scaling
- Saturation clamping

All weights and biases are loaded from `.mem` files using `$readmemh`.

---

# Performance

Current implementation latency:
- ~169 µs per inference in simulation

Approximate throughput:
- ~5900 inferences/sec

> Note:
> The measured latency depends on the clock period used in the testbench simulation.
> Since the architecture is sequential MAC-based, the accelerator can be significantly sped up by increasing clock frequency and introducing parallel MAC units or pipelining.

---

# Project Structure

```text
top_module.v
block_1.v
block_2.v
conv2d.v
conv_chunk.v
conv_chunk_base.v
max_pooling.v
relu.v
full_nn.v
mac.v
```

---

# Memory Files

```text
weight_1_0.mem
weight_1_1.mem
weight_1_2.mem

weight_2_0_0.mem
...
weight_2_2_2.mem

full_nn_weight.mem

bias_1.mem
bias_2.mem
bias_3.mem
```

---

# Result

The accelerator successfully performs:
- End-to-end CNN inference
- Correct MNIST digit prediction
- FPGA-compatible quantized execution

using a completely handwritten RTL implementation.
