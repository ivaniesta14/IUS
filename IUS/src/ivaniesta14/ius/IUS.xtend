// IUS 0.1. Created by ivaniesta14.

package ivaniesta14.ius

import java.math.BigDecimal
import java.math.BigInteger
import java.util.LinkedHashSet
import java.util.LinkedList
import java.util.Map
import org.apache.commons.math3.special.Gamma
import org.apache.commons.math3.stat.StatUtils
import org.apache.commons.math3.util.ArithmeticUtils
import org.apache.commons.math3.util.CombinatoricsUtils
import org.apache.commons.math3.util.MathUtils

import static extension org.apache.commons.math3.util.FastMath.*

class IUS {
	static var stack = new LinkedList<String>

	static val parseStack = new LinkedList<String>

	public static val Map<String, =>String> nilads = newHashMap
	public static val Map<String, (String)=>String> monads = newHashMap
	public static val Map<String, (String, String)=>String> dyads = newHashMap

	static def Pair<String, Runnable> asNilad(String id, =>String arg) {
		nilads.put(id, arg)
		id -> [arg.apply.put]
	}
	static def <T> Pair<String, Runnable> asNiladn(String id, =>T arg) { id.asNilad[arg.apply.s] }
	static def Pair<String, Runnable> asMonad(String id, (String)=>String arg) {
		monads.put(id, arg)
		id -> [arg.apply(pip).put]
	}
	static def <T> Pair<String, Runnable> asMonadn(String id, (String)=>T arg) { id.asMonad[arg.apply(it).s] }
	static def Pair<String, Runnable> asDyad(String id, (String, String)=>String arg) {
		dyads.put(id, arg)
		id -> [arg.apply(pip, pip).put]
	}
	static def <T> Pair<String, Runnable> asDyadn(String id, (String, String)=>T arg) {
		id.asDyad[arg.apply($0, $1).s]
	}

	@SuppressWarnings("all" /*missing @Override. Xtend issue; some unchecked casts*/ )
	public static val Map<String, Runnable> functions = #{
		'0'.asNiladn[0], // Number 0
		'1'.asNiladn[1],
		'2'.asNiladn[2],
		'3'.asNiladn[3],
		'4'.asNiladn[4],
		'5'.asNiladn[5],
		'6'.asNiladn[6],
		'7'.asNiladn[7],
		'8'.asNiladn[8],
		'9'.asNiladn[9], // Number 9
		'⁰'.asMonad[it + '0'], // Superscript 0
		'¹'.asMonad[it + '1'],
		'²'.asMonad[it + '2'],
		'³'.asMonad[it + '3'],
		'⁴'.asMonad[it + '4'],
		'⁵'.asMonad[it + '5'],
		'⁶'.asMonad[it + '6'],
		'⁷'.asMonad[it + '7'],
		'⁸'.asMonad[it + '8'],
		'⁹'.asMonad[it + '9'], // Superscript 9,
		'+'.asDyadn[($0.bi + $1.bi)], // Plus
		'-'.asDyadn[($0.bi - $1.bi)], // Minus
		'×'.asDyadn[($0.bi * $1.bi)], // Times
		'÷'.asDyadn[($0.bi / $1.bi)], // Obelus
		'%'.asDyadn[($0.bi.remainder($1.bi))], // Percent
		'둪'.asNilad[stack.peek], // Hangul Syllable dup
		'⌫' -> [stack.pop] as Runnable, // Erase to the left
		'뚶' -> [stack.peek.put.put] as Runnable, // HS ddup
		'쇂' -> [pip => [pip => [$0|put $0.put]]] as Runnable, // HS swap
		'♺' -> [pip => [pip => [$0|pip => [$1|put $0.put $1.put]]]] as Runnable, // U+267A
		'′'.asNilad[parseStack.pip], // Prime
		'″'.asNilad[parseStack.pip + parseStack.pip], // Double Prime
		'‴'.asNilad[parseStack.pip + parseStack.pip + parseStack.pip], // Triple prime
		'⁗'.asNilad[parseStack.pip + parseStack.pip + parseStack.pip + parseStack.pip], // Quad Prime
		'"'.asNilad [
			val it = new StringBuilder
			var c = ""
			while((c = parseStack.pip) != '' && c != '"')
				append(c)
			s
		], // Double Quote
		"'".asNilad[''], // Single quote
		'⻑'.asNiladn[stack.size], // CJK Radical Long One
		'⻒'.asMonadn[length], // CJK Radical Long Two
		'í'.asMonadn [
			try {
				new BigInteger(it)
				1
			} catch(NumberFormatException _)
				0
		], // Small I with Acute
		'Í'.asMonadn [
			try {
				new BigInteger(it)
				0
			} catch(NumberFormatException _)
				1
		], // Small I with Acute
		'ŕ'.asMonadn [
			try {
				new BigDecimal(it)
				1
			} catch(NumberFormatException _)
				0
		], // Small I with Acute
		'Ŕ'.asMonadn [
			try {
				new BigDecimal(it)
				0
			} catch(NumberFormatException _)
				1
		], // Small I with Acute
		'é'.asMonad[empty.is], // Small E with Acute
		'É'.asMonad[empty.nis], // Capital E with Acute
		'∖'.asDyad[(new LinkedHashSet($0.toCharArray) => [removeAll($1.toCharArray)]).join], // Set Minus
		'렢'.asDyad[$0.repeat($1.in)], // HS Rep
		'⻓'.asDyad [
			val it = new StringBuilder
			for (i : 0 ..< $1.length)
				append($0.charAt(i % $0.length))
			s
		], // CJK Radical C-Simplified Long
		'운'.asMonad[new LinkedHashSet(toCharArray).join], // HS Un
		'⌋'.asDyadn[ArithmeticUtils.lcm($0.lin, $1.lin)], // Right Floor
		'⌉'.asDyadn[$0.bii.gcd($1.bii)], // Right Ceiling
		'!'.asMonadn[new BigDecimal(CombinatoricsUtils.factorialDouble(in)).toBigInteger], // Exclamation
		'∧'.asDyadn[$0.bii.and($1.bii)], // And
		'∨'.asDyadn[$0.bii.or($1.bii)], // Or
		'⊻'.asDyadn[$0.bii.xor($1.bii)], // Xor
		'⊼'.asDyadn[$0.bii.and($1.bii).not], // Nand
		'⊽'.asDyadn[$0.bii.or($1.bii).not], // Nor
		'<'.asDyad[($0.bi < $1.bi).is], // Lt
		'>'.asDyad[($0.bi > $1.bi).is], // Gt
		'='.asDyad[($0.bi == $1.bi).is], // Eq
		'≤'.asDyad[($0.bi <= $1.bi).is], // Leq
		'≥'.asDyad[($0.bi >= $1.bi).is], // Geq
		'≠'.asDyad[($0.bi != $1.bi).is], // Neq
		'앖'.asMonadn[bi.abs], // HS Abs
		'촛'.asMonadn[di.cos], // HS Cos
		'신'.asMonadn[di.sin], // HS Sin
		'탄'.asMonadn[di.tan], // HS Tan
		'촜'.asMonadn[di.cosh], // HS Coss
		'싢'.asMonadn[di.sinh], // HS Sinh
		'탆'.asMonadn[di.tanh], // HS Tanh
		'최'.asMonadn[di.acos], // HS Coe
		'씬'.asMonadn[di.asin], // HS Sinn
		'탅'.asMonadn[di.atan], // HS Tanj
		'쵝'.asMonadn[di.acosh], // HS Coeg
		'싱'.asMonadn[di.asinh], // HS Sing
		'탕'.asMonadn[di.atanh], // HS Tang
		'🗚'.asMonadn[bi + 1bd], // Increase Font Size
		'🗛'.asMonadn[bi - 1bd], // Decrease Font Size
		'⌊'.asMonadn[bi.toBigInteger], // Left Floor
		'⌈'.asMonadn[di.ceil], // Left Ceiling
		'🗕'.asDyadn[$0.bi.min($1.bi)], // Minimize
		'🗖'.asDyadn[$0.bi.max($1.bi)], // Maximize
		'렙'.asMonadn[new StringBuilder(it)], // HS Reb
		'㏒'.asMonadn[di.log10], // Square Log
		'㏑'.asMonadn[di.log], // Square Ln
		'⏨'.asMonadn[10.pow(di)], // Decimal Exponent Symbol
		'ℯ'.asMonadn[E.pow(di)], // Script Small E
		'√'.asMonadn[di.sqrt], // Square Root
		'∛'.asMonadn[di.cbrt], // Cube Root
		'∜'.asMonadn[di.pow(0.25d)], // Fourth Root
		'⨰' -> [pip => [(0 ..< pipInt).forEach[_|put]]] as Runnable, // Times, Dot Above
		'탛'.asDyadn[$0.di.atan2($1.di)], // HS Tah
		'↑'.asMonad[toUpperCase], // Upwards Arrow
		'↓'.asMonad[toLowerCase], // Downwards Arrow
		'⇑'.asMonad[toFirstUpper], // Upwards Double Arrow
		'⇓'.asMonad[toFirstLower], // Downwards Double Arrow
		'☛'.asDyadn[$0.charAt($1.in)], // Black Right Pointing Index
		'α'.asNilad['abcdefghijklmnopqrstuvwxyz'], // Greek Alpha
		'Α'.asNilad['ABCDEFGHIJKLMNOPQRSTUVWXYZ'], // Greek Capital Alpha
		'ƨ'.asMonadn[bi - 2bd], // Tone 2
		'Ƨ'.asMonadn[bi + 2bd], // Capital Tone 2
		'༫'.asMonadn[bi / 2bd], // Tibetan Half 2
		'༬'.asMonadn[bi / 3bd],
		'༭'.asMonadn[bi / 4bd],
		'༮'.asMonadn[bi / 5bd],
		'༯'.asMonadn[bi / 6bd],
		'༰'.asMonadn[bi / 7bd],
		'༱'.asMonadn[bi / 8bd],
		'༲'.asMonadn[bi / 9bd], // Tibetan Half 9
		'༳'.asMonadn[bi / 10bd], // Tibetan Half 0
		'ℼ'.asNiladn[PI], // Double-struck pi
		'ⅇ'.asNiladn[E], // Double-struck e
		'𝜑'.asNiladn[((1d + 5.sqrt) / 2)], // Mathematical Italic Small Phi
		'↊'.asMonadn[2.log(di)], // Turned Digit Two
		'ƻ'.asMonadn[2.pow(di)], // Latin Letter Two with Stroke
		'𝐂'.asDyadn[CombinatoricsUtils.binomialCoefficientDouble($0.in, $1.in)], // Mathematical Bold Capital C
		'Γ'.asMonadn[Gamma.gamma(di)], // Greek Gamma
		'Ϝ'.asMonadn[Gamma.digamma(di)], // Greek Digamma
		'𝜏'.asNiladn[MathUtils.TWO_PI], // Mathematical Italic Small Tau
		'닶'.asDyadn[($0.bi - $1.bi).abs], // HS Dabs
		'≺' -> [
			new StringBuilder => [
				for (c : pip.toCharArray)
					append(c).put
			]
		] as Runnable, // Precedes
		'Ⴊ'.asMonadn[charAt(length - 1)], // Georgian Capital Las
		'ლ'.asMonadn[charAt(0)], // Georgian Las
		'º'.asMonad[toCharArray.sortWith[$0 <=> $1].join], // Masculine Ord. Ind
		'ª'.asMonad[toCharArray.sortWith[$1 <=> $0].join], // Feminine Ord. Ind
		'䷖' -> [pip.split('\\s').forEach[put]] as Runnable, // Hexagram: Splitting apart
		'−'.asMonadn[bi.negate], // Minus Sign
		'→' -> [(0 ..< pipInt).forEach[put]] as Runnable, // Rightwards Arrow
		'↣' -> [(0 .. pipInt).forEach[put]] as Runnable, // Rightwards Arrow with Tail
		'↦' -> [(1 ..< pipInt).forEach[put]] as Runnable, // Rightwards Arrow from Bar
		'↪' -> [(1 .. pipInt).forEach[put]] as Runnable, // Rightwards Arrow with Hook
		'⏻'.asDyadn[ArithmeticUtils.pow($0.bii, $1.bii)], // Power Symbol
		'Ⅹ'.asNiladn[10], // Uppercase Roman Numerals
		'Ⅺ'.asNiladn[11],
		'Ⅻ'.asNiladn[12],
		'Ⅼ'.asNiladn[50],
		'Ⅽ'.asNiladn[100],
		'Ⅾ'.asNiladn[500],
		'Ⅿ'.asNiladn[1000],
		'ↁ'.asNiladn[5000],
		'ↂ'.asNiladn[10000],
		'ↇ'.asNiladn[50000],
		'ↈ'.asNiladn[100000],
		'ⅳ'.asNiladn[16], // Lowercase Roman Numerals
		'ⅴ'.asNiladn[32],
		'ⅵ'.asNiladn[64],
		'ⅶ'.asNiladn[128],
		'ⅷ'.asNiladn[256],
		'ⅸ'.asNiladn[512],
		'ⅹ'.asNiladn[1024],
		'ⅺ'.asNiladn[2048],
		'ⅻ'.asNiladn[4096],
		'ⅼ'.asNiladn[1125899906842624l],
		'ⅽ'.asNiladn[1267650600228229401496703205376bi],
		'ⅾ'.asNiladn[(2bi ** 500)],
		'ⅿ'.asNiladn[(2bi ** 1000)],
		'３'.asNiladn[13], // Fullwidth characters
		'４'.asNiladn[14],
		'５'.asNiladn[15],
		'６'.asNiladn[16],
		'７'.asNiladn[17],
		'８'.asNiladn[18],
		'９'.asNiladn[19],
		'Ａ'.asNiladn[20],
		'Ｂ'.asNiladn[21],
		'Ｃ'.asNiladn[22],
		'Ｄ'.asNiladn[23],
		'Ｅ'.asNiladn[24],
		'Ｆ'.asNiladn[25],
		'Ｇ'.asNiladn[26],
		'Ｈ'.asNiladn[27],
		'Ｉ'.asNiladn[28],
		'Ｊ'.asNiladn[29],
		'Ｋ'.asNiladn[30],
		'Ｌ'.asNiladn[31],
		'Ｍ'.asNiladn[32],
		'Ｎ'.asNiladn[33],
		'Ｏ'.asNiladn[34],
		'Ｐ'.asNiladn[35],
		'Ｑ'.asNiladn[36],
		'Ｒ'.asNiladn[40],
		'Ｓ'.asNiladn[50],
		'Ｔ'.asNiladn[60],
		'Ｕ'.asNiladn[70],
		'Ｖ'.asNiladn[80],
		'Ｗ'.asNiladn[90],
		'Ｘ'.asNiladn[200],
		'Ｙ'.asNiladn[300],
		'Ｚ'.asNiladn[400],
		'０'.asNiladn[600],
		'１'.asNiladn[700],
		'２'.asNiladn[800],
		'ａ'.asNiladn[900],
		'ｂ'.asNiladn[1100],
		'ｃ'.asNiladn[1200],
		'ｄ'.asNiladn[1300],
		'ｅ'.asNiladn[1400],
		'ｆ'.asNiladn[95],
		'ｇ'.asNiladn[63],
		'ｈ'.asNiladn[127],
		'ｉ'.asNiladn[255],
		'ｊ'.asNiladn[511],
		'ｋ'.asNiladn[1023],
		'ｌ'.asNiladn[2047],
		'ｍ'.asNiladn[4095],
		'ｎ'.asNiladn[8191],
		'ｏ'.asNiladn[(2bi ** 14 - 1bi)],
		'ｐ'.asNiladn[(2bi ** 15 - 1bi)],
		'ｑ'.asNiladn[(2bi ** 16 - 1bi)],
		'ｒ'.asNiladn[(2bi ** 17 - 1bi)],
		'ｓ'.asNiladn[(2bi ** 18 - 1bi)],
		'ｔ'.asNiladn[(2bi ** 19 - 1bi)],
		'ｕ'.asNiladn[(2bi ** 20 - 1bi)],
		'ｖ'.asNiladn[(2bi ** 20)],
		'ｗ'.asNiladn[(2bi ** 30)],
		'ｘ'.asNiladn[(2bi ** 40)],
		'ｙ'.asNiladn[(2bi ** 50)],
		'ｚ'.asNiladn[(2bi ** 60)],
		'½'.asNiladn[0.5bd], // Fractions
		'⅓'.asNiladn[(1bd / 3bd)],
		'¼'.asNiladn[0.25bd],
		'⅕'.asNiladn[0.2bd],
		'⅙'.asNiladn[(1bd / 6bd)],
		'⅐'.asNiladn[(1bd / 7bd)],
		'⅛'.asNiladn[0.125bd],
		'⅑'.asNiladn[(1bd / 9bd)],
		'⅒'.asNiladn[0.1bd],
		'⅔'.asNiladn[(2bd / 3bd)],
		'⅖'.asNiladn[0.4bd],
		'¾'.asNiladn[0.75bd],
		'⅗'.asNiladn[0.6bd],
		'⅘'.asNiladn[0.8bd],
		'⅜'.asNiladn[0.375bd],
		'⅝'.asNiladn[0.625bd],
		'⅞'.asNiladn[0.875bd],
		'∑' -> [stack.map[new BigDecimal(it)].reduce[$0 + $1].put] as Runnable, // N-ary summation sign
		'⓪'.asMonadn[(bi == 0bd).is], // Circled numerals
		'①'.asMonadn[(bi == 1bd).is],
		'②'.asMonadn[(bi == 2bd).is],
		'③'.asMonadn[(bi == 3bd).is],
		'④'.asMonadn[(bi == 4bd).is],
		'⑤'.asMonadn[(bi == 5bd).is],
		'⑥'.asMonadn[(bi == 6bd).is],
		'⑦'.asMonadn[(bi == 7bd).is],
		'⑧'.asMonadn[(bi == 8bd).is],
		'⑨'.asMonadn[(bi == 9bd).is],
		'⑩'.asMonadn[(bi == 0bd).is],
		'⓿'.asMonadn[(bi == 0bd).nis], // Circled numerals (black)
		'❶'.asMonadn[(bi == 1bd).nis],
		'❷'.asMonadn[(bi == 2bd).nis],
		'❸'.asMonadn[(bi == 3bd).nis],
		'❹'.asMonadn[(bi == 4bd).nis],
		'❺'.asMonadn[(bi == 5bd).nis],
		'❻'.asMonadn[(bi == 6bd).nis],
		'❼'.asMonadn[(bi == 7bd).nis],
		'❽'.asMonadn[(bi == 8bd).nis],
		'❾'.asMonadn[(bi == 9bd).nis],
		'❿'.asMonadn[(bi == 0bd).nis],
		'⟕'.asDyad[$0 + $1], // Left outer join
		'⟖' -> [(pip + pip + pip).put] as Runnable, // Right outer join
		'⟗' -> [stack.reduce[$0 + $1].put] as Runnable, // Full outer join
		'⧾' -> [stack.map[new BigDecimal(it)].max[$0 <=> $1].put] as Runnable, // Tiny
		'⧿' -> [stack.map[new BigDecimal(it)].min[$0 <=> $1].put] as Runnable, // Miny
		'ᾀ'.asMonad[matches('[a-zA-Z]*').is], // Alpha with Psili and Ypogegrammeni
		'ᾈ'.asMonad[matches('[a-zA-Z]*').nis], // Alpha with Psili and Ypogegrammeni (Capital)
		'ᾁ'.asMonad[matches('[a-z]*').is], // Alpha with Dasia and Ypogegrammeni
		'ᾉ'.asMonad[matches('[a-z]*').nis], // Alpha with Dasia and Ypogegrammeni (Capital)
		'ᾂ'.asMonad[matches('[A-Z]*').is], // Alpha with Psili, Varia and Ypogegrammeni
		'ᾊ'.asMonad[matches('[A-Z]*').nis], // Alpha with Psili, Varia and Ypogegrammeni (Capital)
		'ẋ' -> [StatUtils.mean(stack.map[new BigDecimal(it).doubleValue]).put] as Runnable, // X with dot above
		'‰' -> [bip.divideAndRemainder(bip).forEach[put]] as Runnable, // Permille
		// '↢' -> [pip.charAt(0).put] as Runnable, // Left arrow with tail
		'⬹'.asMonad[substring(1)], // Left arrow with tail and stroke
		'⬺' -> [pip => [charAt(0).put substring(1).put]] as Runnable, // Ditto, two strokes
		'♳'.asMonad[substring(1) + substring(0, 1)], // Recycling symbol, type-1 plastic
		'♴'.asMonad[substring(2) + substring(0, 2)], // Recycling symbol, type-2 plastic
		'♵'.asMonad[substring(3) + substring(0, 3)], // Recycling symbol, type-3 plastic
		'♶'.asMonad[substring(4) + substring(0, 4)], // Recycling symbol, type-4 plastic
		'♷'.asMonad[substring(5) + substring(0, 5)], // Recycling symbol, type-5 plastic
		'♸'.asMonad[substring(6) + substring(0, 6)], // Recycling symbol, type-6 plastic
		'♹'.asMonad[substring(7) + substring(0, 7)], // Recycling symbol, type-7 plastic
		'⁼' -> [stack.filter[stack.peek == it].empty.pit] as Runnable, // Superscript equals
		'₌' -> [stack.filter[stack.peek == it].empty.nit] as Runnable, // Subscript equals
		'∏' -> [stack.map[new BigDecimal(it)].reduce[$0 * $1].put] as Runnable, // N-ary product
		'䷪' -> [pip.toCharArray.forEach[put]] as Runnable, // Hexagram: Breakthrough
		'ℹ'.asDyad[$0.matches($1).is], // Information sign
		'렚' -> [
			stack => [
				val $0 = stack.map[new StringBuilder(it).reverse.toString].toArray(<String>newArrayOfSize(0))
				clear
				addAll($0)
			]
		] as Runnable, // HS Rebs
		'±'.asMonadn[bi.signum], // Plus-Minus
		'߹' -> [bip.max(bip).min(bip).put] as Runnable, // Nko Exclamation Mark
		'☚' -> [
			pip => [val idx = pipInt put(substring(0, idx) + pip + substring(idx + 1))]
		] as Runnable, // Left idx
		'S' -> [pip => [dyads.get(pip).apply(it, monads.get(pip).apply(it)).put]] as Runnable,
		's' ->
			[pip => [dyads.get(parseStack.pip).apply(it, monads.get(parseStack.pip).apply(it)).put]] as Runnable,
		'' -> [] as Runnable
	}

	@SuppressWarnings('unchecked' /*array->iterable */ )
	def static void main(String[] args) {
		args => [head.addToParse tail.forEach[put]]
		parse
		stack.forEach[println(it)]
	}

	def static addToParse(String arg) {
		for (int i : 0 ..< arg.length)
			parseStack.add(arg.charAt(i) + "")
	}

	static def parse() {
		while(!parseStack.isEmpty)
			functions.get(parseStack.pop)?.run
	}
	/* CHARACTERS USED: currently between 256 and 512, 9/8 bytes per char
	 * 0123456789: (Number literals)
	 * ⁰¹²³⁴⁵⁶⁷⁸⁹	: (Append number)
	 * +-*%/−‰±	: (Basic mathematical operations)
	 * 둪⌫뚶쇂♺	: (Basic stack manipulations)
	 * ′″‴⁗"'	: (Basic String literals)
	 * íÍŕŔéÉ	: (Basic type checks)
	 * ⻑⻒		: (Stack and head sizes)
	 * ∖렢⻓운		: (String Operations I)
	 * ⌋⌉!값		: (LCM, GCD, Factorial, Abs)
	 * ∧∨⊻<>=≤≥≠	: (Logical operations)
	 * 촛신탄촜싢탆	: (Trigonometry)
	 * 최씬탅쵝싱탕	: (Inverse trigonometry)
	 * ⇒🗚🗛⎣🗕🗖߹	: (Inc, Dec, Floor, Ceil, Min, Max, Clam)
	 * 렙렚		: (Reverse)
	 * ㏒㏑⏨ℯ√∛∜탛	: (General Math I)
	 * ⨰↑↓⇑⇓☛☚	: (String Operations II)
	 * αΑ		: (Constants I: Alphabet)
	 * ƨƧ༫༬༭༮༯걊	: (Shorthands I: Math)
	 * ℼⅇ𝜑𝜏		: (Constants II: Math)
	 * ⇒↊ƻ			: (Binary log and exp)
	 * ⇒𝐂ΓϜ		: (Combinatorics)
	 * ≺Ⴊლºª⇒䷖		: (String Operations III)
	 * →↣↦↪		: (Ranges)
	 * ䷡⅟èÈ		: (General Math II)
	 * ⅩⅪⅫⅬⅭⅮⅯↁↂ	: (Constants III: Numbers I)
	 * ↇↈⅳⅴⅵⅶⅷⅸⅹ	: (Constants IV: Numbers II)
	 * ⅺⅻⅼⅽⅾⅿ３４５６７	: (Constants V: Numbers III)
	 * ８９ＡＢＣＤＥＦ	: (Constants VI: Numbers IV)
	 * ＧＨＩＪＫＬＭＮＯＰ	: (Constants VII: Numbers V)
	 * ＱＲＳＴＵＶＷＸＹＺ	: (Constants VIII: Numbers VI)
	 * ０１２ａｂｃｄｅｆｇｈ	: (Constants IX: Numbers VII)
	 * ｉｊｋｌｍｎｏｐｑｒｓｔｕｖ	: (Constants X: Numbers VIII)
	 * ｗｘｙｚ½⅓¼⅕⅙⅐⅛	: (Constants XI: Numbers IX)
	 * ⅑⅒⅔⅖¾⅗⅘⅜	: (Constants XII: Numbers X)
	 * ⅝⅞		: (Constants XIII: Numbers XI)
	 * ⇒∑⧾⧿ẋ⁼₌∏	: (Iterations and reductions)
	 * ⓪①②③④⑤⑥⑦⑧	: (Equality Checks I)
	 * ⑨⑩⓿❶❷❸❹❺❻	: (Equality Checks II)
	 * ❼❽❾❿		: (Equality Checks III)
	 * ⟕⟖⟗		: (Joins)
	 * ᾀᾈᾁᾉᾂᾊℹ	: (Regex Checks)
	 * ↢⬹⬺䷪		: (Head Splitting)
	 * ♳♴♵♶♷♸♹	: (Head Rotation)
	 * Ss		: S combinator (Sxyz->x(y,z(x)))
	 */
	/**Pop if present, else return an empty string */
	@Pure static def pip(LinkedList<? extends String> arg) {
		if(arg.isEmpty) "" else arg.pop
	}

	static def <T> put(T s) {
		stack.push(s.s)
		s
	}

	@Pure private static def bi(String s) { new BigDecimal(s) }
	@Pure private static def bii(String s) { new BigInteger(s) }
	@Pure private static def di(String s) { s.bi.doubleValue }
	@Pure private static def in(String s) { s.bi.intValue }
	@Pure private static def lin(String s) { s.bi.longValue }

	@Pure private static def pip() { stack.pip }

	@Pure private static def bip() { pip.bi }

	@Pure private static def pipInt() { bip.intValue }

	@Pure private static def <T> s(T t) { t.toString }

	private static def pit(Boolean it) {
		(if(it) '1' else '0').put
	}

	private static def nit(Boolean it) {
		(if(it) '0' else '1').put
	}

	@Pure private static def is(Boolean it) {
		it ? '1' : '0'
	}
	@Pure private static def nis(Boolean it) {
		it ? '0' : '1'
	}
}
