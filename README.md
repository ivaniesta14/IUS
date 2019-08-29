# IUS
Why not have _all_ the built-ins?

IUS is another stack-based language, like 05AB1E and Seriously, but without the limitation of having a single-byte code page.
This way, the number of built-ins is greatly multiplied at the expense of byte cost per operation.

The stack is a list of Strings; calculations use BigDecimal or BigInteger when possible.

Currently, there are between 256 and 512 (282 especifically) implemented operations.

## How to use?
0. Download this repository (at least the src folder).
1. Install Java 12 and (Xtend)[http://www.eclipse.org/xtend ].
2. Compile the source file using your Xtend/Java IDE of choice.
   This will create both a .java and a .class file.
3. Run either of those files. The first argument passed is the actual program, the rest are the input.
