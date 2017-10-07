<h4 align="center">LuaJIT Genann</h4>

This is a `LuaJIT` FFI wrapper for the artificial neural network library `Genann`.
It should be really simple to use.

#### Installation

The `Makefile` is there to build the `libgenann.so` shared library.
Run `make`, followed by `sudo make install` and the shared library will be placed inside `/usr/local/lib`.

Make sure you clone this repository with the `recursive` flag or `genann` won't get cloned (`git clone --recursive https://github.com/rokf/luajit-genann`).

After that you can install the Lua module via `rockspec` like `sudo luarocks-5.1 install genann-dev-1.rockspec`.
You could also just type `sudo luarocks-5.1 make` and it will get installed from the local files.

Now it should be ready to use.

#### Functions

- `init(inputs,hidden_layers,hidden,outputs)` creates an ANN, arguments are all numbers.
- `read(file)` reads an ANN from file and returns it. `file` can be a string or a readable Lua file object.
- `copy(nn)` returns a copy of the received ANN.
- `free(nn)` cleans up after you're done.
- `run(nn,inputs)` sends the inputs through the ANN, returns outputs in table format.
  `inputs` can be either a table or a `const double[n]` (aka. C array).
- `train(nn,i,o,rate)` trains the ANN. `rate` is a number, `i` and `o` are `const double[n]` arrays.
  The function `trans` is used to convert a table of tables with numbers (ie. inputs, outputs) into
  a table of *double arrays*.
- `write(nn,file)` writes the ANN to a file for later use (so you don't have to train it again).
  `file` can be either a string or a writeable Lua file object.

#### Additional functions

- `trans(t)` converts a table of tables with numbers into a C `const double` array (like mentioned above).
- `trans1(t)` does only the inner conversion, table of numbers into a `const double` array.
- `workout(nn,inputs,outputs,loops,rate)` does the full training for you. Expects the ANN,
  the full transformed input and output tables (same size ofc), the number of loops to do and the rate
  to train at.

#### Notice

I still have to wrap the different activation functions shipped with Genann (it is probably easy).
You're trapped with the defaults for now *hehe*.
