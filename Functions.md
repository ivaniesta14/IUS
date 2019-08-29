# List of functions

Warning: This file contains unicode characters. Some of them may not appear depending on the font you are using.

Arity means how many strings are popped from the stack.
An asterisk in the arity column means that the function cannot be used as a nilad/monad/dyad in combinators
A pilcrow (¶) in the arity column means that the function does not pop any element from the stack

| Character | Arity | Description |
|:---------:|:-----:|-------------|
| `0` → `9` | 0     | Push number literal |
| `둪`       | 0   ¶ | Duplicate top of stack |
| `′`       | 0     | Push the next instruction |
| `″`       | 0     | Push the next 2 instructions |
| `‴`       | 0     | Ditto, 3 instructions |
| `⁗`       | 0     | Ditto, 4 instructions |
| `"`       | 0     | Push all instructions until the next " |
| `'`       | 0     | Push an empty string |
| `⻑`       | 0     | Push the size of the stack |
| `α`       | 0     | Push the lowercase alphabet |
| `Α`       | 0     | Push the uppercase alphabet |
| `ℼ`, `ⅇ`  | 0     | Push Pi/E |
| `𝜑`, `𝜏`  | 0     | Push Phi/Tau |
| `Ⅹ`, `Ⅺ`  | 0     | Push 10/11 |
| `Ⅻ`, `Ⅼ`  | 0     | Push 12/50 |
| `Ⅽ`, `Ⅾ`  | 0     | Push 100/500 |
| `Ⅿ`, `ↁ`  | 0     | Push 1000/5000 |
| `ↂ`, `ↇ`  | 0     | Push 10000/50000 |
| `ↈ`       | 0     | Push 100000 |
| `ⅳ` → `ⅻ` | 0     | Push powers of 2 (16 → 4096) |
| `ⅼ`, `ⅽ`  | 0     | Push 2^50/2^100 |
| `ⅾ`, `ⅿ`  | 0     | Push 2^500/2^1000 |
| `３` → `９` | 0     | Push 13 → 19 |
| `Ａ` → `Ｑ` | 0     | Push 20 → 36 |
| `Ｒ` → `Ｗ` | 0     | Push 40 → 90 (steps of 10) |
| `Ｘ` → `Ｚ` | 0     | Push 200 → 400 (steps of 100) |
| `０` → `２` | 0     | Push 600 → 800 (steps of 100) |
| `ａ`       | 0     | Push 900 |
| `ｂ` → `ｅ` | 0     | Push 1100 → 1400 (steps of 100) |
| `ｆ`       | 0     | Push 95 |
| `ｇ` → `ｕ` | 0     | Push powers of 2 minus 1 (63 → 2^20-1) |
| `ｖ` → `ｚ` | 0     | Push powers of 2 (2^20 → 2^60 in steps of 10) |
| Fractions (`½`...)  | 0     | Push the fraction's value |
| `⁰`, `⁹`  | 1     | Append value to head |
| `⻒`       | 1     | Push length of head |
| `í`, `Í`  | 1     | Push 1 if head is an integer or 0 otherwise. Viceversa for uppercase |
| `ŕ`, `Ŕ`  | 1     | Push 1 if head is a real number or 0 otherwise. Viceversa for uppercase |
| `é`, `É`  | 1     | Push 1 if head is an empty string or 0 otherwise. Viceversa for uppercase |
| `운`       | 1     | Push unique characters of head (stable order) |
| `!`       | 1     | Pop an int, push its factorial as a BigInteger |
| `앖`       | 1     | Pop an number, push its absolue value |
| `촛신탄`     | 1     | Pop a number, push its cosine/sine/tangent |
| `촜싢탆`     | 1     | Pop a number, push its hyperbolic cosine/sine/tangent |
| `최씬탅`     | 1     | Pop a number, push its inverse cosine/sine/tangent |
| `쵝싱탕`     | 1     | Pop a number, push its inverse hyperbolic cosine/sine/tangent |
| `🗚`, `🗛`  | 1     | Increment/decrement head by 1 |
| `⌊`, `⌈`  | 1     | Apply floor/ceil to head |
| `렙`       | 1     | Pop a string, push it in reverse order |
| `㏒`, `㏑`  | 1     | Pop a number, push its logarithm in base 10/e |
| `⏨`, `ℯ`  | 1     | Pop a number, push its antilogarithm in base 10/e |
| `√∛∜`     | 1     | Pop a number, push its square/cube/fourth root |
| `↑`, `↓`  | 1     | Pop a string, push it in uppercase/lowercase |
| `⇑`, `⇓`  | 1     | Pop a string, push it with its first character in uppercase/lowercase |
| `ƨ`, `Ƨ`  | 1     | Increment/decrement head by 1 |
| `༫` → `༲` | 1     | Pop a number, push it divided by 2 → 9 |
| `༳`       | 1     | Pop a number, push it divided by 10 |
| `↊`       | 1     | Pop a number, push its logarithm in base 2 |
| `ƻ`       | 1     | Replace head by 2^head |
| `Γ`, `Ϝ`  | 1     | Replace head by Γ(head)/Digamma(head) |
| `ლ`, `Ⴊ`  | 1     | Replace head by its first/last character |
| `º`, `ª`  | 1     | Sort head in lexicographical/inverse lexicographical order |
| `−`       | 1     | Replace head by -head |
| `⓪`, `⑩`  | 1     | Replace head by 1 if equal to 0 → 10 or by 0 otherwise |
| `⓿`, `❿`  | 1     | Replace head by 0 if equal to 0 → 10 or by 1 otherwise |
| `ᾀ`, `ᾈ`  | 1     | Replace head by 1/0 if it matches `/[a-zA-Z]*/` or by 0/1 otherwise |
| `ᾁ`, `ᾉ`  | 1     | Replace head by 1/0 if it matches `/[a-z]*/` or by 0/1 otherwise |
| `ᾂ`, `ᾊ`  | 1     | Replace head by 1/0 if it matches `/[A-Z]*/` or by 0/1 otherwise |
| `⬹`       | 1     | Remove the first character from head |
| `♳` → `♹` | 1     | Cyclically rotate head by 1 → 7 characters (putting first characters at the end) |
| `±`       | 1     | Replace head by sgn(head) |
| `+-×÷`    | 2     | Standard mathematical operations (addition, substraction, product, division over numbers) |
| `%`       | 2     | Pop numbers a,b; push a%b |
| `∖`       | 2     | Pop strings a,b; push characters from a not in b (stable order) |
| `렢`       | 2     | Pop string a, integer b; push a repeated b times |
| `⻓`       | 2     | Pop string a, integer b; push a repeated character by character until it has length b |
| `⌋`, `⌉`  | 2     | Pop numbers a,b; push their lcm/gcd |
| `∧∨⊻`     | 2     | Pop numbers a,b; push `a&b` / `a|b` / `a^b` (bitwise operation) |
| `⊼`, `⊽`  | 2     | Pop numbers a,b; push `~(a&b)`/`~(a|b)` (bitwise operation) |
| `<>=`     | 2     | Pop numbers a,b; push 1 if a is less than/greater than/equal to b or 0 otherwise|
| `≥≤≠`     | 2     | Pop numbers a,b; push 0 if a is less than/greater than/equal to b or 1 otherwise |
| `🗕`, `🗖`  | 2     | Pop numbers a,b; push the minimum/maximum of the two |
| `☛`       | 2     | Pop string a, int b; push the b-th character from a |
| `𝐂`       | 2     | Pop ints a,b; push `aCb` (a choose b) |
| `닶`       | 2     | Pop numbers a,b; push the distance between them (`abs(a-b)`) |
| `⏻`       | 2     | Pop numbers a,b; push a^b |
| `⟕`       | 2     | Pop strings a,b; push a+b (string concatenation) |
| `ℹ`       | 2     | Pop strings a,b; push 1 if a matches b as a regular expression, or 0 otherwise |
| `⌫`       | 1 *   | Remove head |
| `뚶`       | 1 *   | Duplicate head |
| `쇂`       | 2 *   | Swap top two elements |
| `♺`       | 3 *   | Rotate top 3 elements (a,b,c → c,b,a) |
| `⨰`       | 2 *   | Pop string a, int b; push a b times |
| `≺`       | 1 *   | Push the prefixes of head (example: abc → a,ab,abc) |
| `䷖`       | 1 *   | Push each of the words of head (split at `/\s/`) |
| `→`, `↣`  | 1 *   | Exclusive/Inclusive range from 0 to head |
| `↦`, `↪`  | 1 *   | Exclusive/Inclusive range from 1 to head |
| `⟖`       | 3 *   | Pop strings a,b,c; push them concatenated |
| `⟗`       | ∞ * ¶ | Push the result of concatenating the stack (without popping) |
| `⧾`, `⧿`  | ∞ * ¶ | Push the minimum/maximum of the stack (without popping) |
| `ẋ`       | ∞ * ¶ | Push the arithmetic mean of the stack (without popping) |
| `‰`       | 2 *   | Push the divmod of the top two elements (quotient first) |
| `⬺`       | 1 *   | Pop string a; push its first character, then the rest |
| `⁼`, `₌`  | ∞ * ¶ | Push 1/0 if all elements of the stack are equal to head or 0/1 otherwise (without popping) |
| `∏`, `∑`  | ∞ * ¶ | Push the product/sum of the stack (without popping) |
| `䷪`       | 1 *   | Push each of the characters of head |
| `렚`       | ∞ *   | Reverse each of the elements of the stack |
| `߹`       | 3 *   | Pop numbers a,b,c; push min(max(a,b),c) |
| `☚`       | 3 *   | Pop string a, int b, string c; push c inserted in a at position b |

<!---
| `____`    | _     |  |
| `___`     | _     |  |
| `_`, `_`  | _     |  |
| `_`       | _     |  |
-->

## Combinators

Each combinator has two variants: uppercase and lowercase. The former uses functions from the stack whereas the latter consumes tokens from the parsing stack.

In the structure column, D is a dyad, M is a monad and E are elements popped from the stack

| Combinator | Structure | Result | Description |
|:----------:|:---------:|:------:|-------------|
| `S`        | sDME      | D(E,M(E))| Equivalent to Haskell's `<*>` operator on functions |
