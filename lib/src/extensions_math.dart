import 'dart:math' as math;

/// Extension for superscript/subscript formatting of integers.
extension ExMathNotation on int {
  /// Converts an integer to its superscript Unicode string (e.g., 12 → ¹²).
  String toSuperscript() {
    const superscripts = {
      '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
      '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹', '-': '⁻'
    };
    return toString().split('').map((c) => superscripts[c] ?? '').join();
  }

  /// Converts an integer to its subscript Unicode string (e.g., 12 → ₁₂).
  String toSubscript() {
    const subscripts = {
      '0': '₀', '1': '₁', '2': '₂', '3': '₃', '4': '₄',
      '5': '₅', '6': '₆', '7': '₇', '8': '₈', '9': '₉', '-': '₋'
    };
    return toString().split('').map((c) => subscripts[c] ?? '').join();
  }
}

/// Extension on [num] for math formatting and calculations.
extension ExNumPower on num {
  /// Returns this^exponent.
  num pow(num exponent) => math.pow(this, exponent);

  /// Returns the square of the number.
  num get squareVal => this * this;

  /// Returns the cube of the number.
  num get cubeVal => this * this * this;

  /// Returns the number with a square (²) symbol.
  String get square => '${this}²';

  /// Returns the number with a cube (³) symbol.
  String get cube => '${this}³';

  /// Returns a plain power string like 2^3.
  String toPower(num exp) => '$this^$exp';

  /// Returns a superscript power string like 2³.
  String toSuperPower(num exp) => '$this${(exp.toInt()).toSuperscript()}';

  /// Returns root notation: √x, ³√x, etc.
  String toRoot(int n) => n == 2 ? '√$this' : '${n.toSuperscript()}√$this';

  /// Returns log notation: log₂(x)
  String logBase(num base) => 'log${base.toInt().toSubscript()}($this)';

  /// Returns the nth root as a double.
  double nthRootValue(int n) => math.pow(this, 1 / n).toDouble();

  /// Returns true if this number is a perfect square.
  bool get isPerfectSquare {
    final root = math.sqrt(this);
    return root == root.floorToDouble();
  }

  /// Returns true if this number is a perfect cube.
  bool get isPerfectCube {
    final root = math.pow(this, 1 / 3);
    return (root - root.round()).abs() < 0.00001;
  }

  /// Converts degrees to radians.
  double get toRadians => this * (math.pi / 180.0);

  /// Converts radians to degrees.
  double get toDegrees => this * (180.0 / math.pi);

  /// Returns factorial (n!), valid only for integers ≥ 0.
  int get factorial {
    if (this is! int || this < 0) throw Exception("Factorial only defined for non-negative integers.");
    return this == 0 ? 1 : List.generate(toInt(), (i) => i + 1).reduce((a, b) => a * b);
  }

  /// Returns value prefixed with a sign symbol.
  String get signWithSymbol => this >= 0 ? '+$this' : this.toString();

  /// Returns sin(this) in radians.
  double get sinRad => math.sin(this.toDouble());

  /// Returns cos(this) in radians.
  double get cosRad => math.cos(this.toDouble());

  /// Returns tan(this) in radians.
  double get tanRad => math.tan(this.toDouble());

  /// Returns LaTeX style power notation: x^{y}
  String toLaTeXPower(num exp) => '$this^{${exp.toInt()}}';

  /// Returns LaTeX root style: \sqrt[n]{x}
  String toLaTeXRoot(int n) =>
      n == 2 ? r'\sqrt{' + '$this}' : r'\sqrt[' + '$n]{' + '$this}';

  /// Returns Markdown-style math: `log_{2}(8)`
  String toMarkdownLog(num base) => r'`log_{$base}($this)`';
}

/// Extension for converting decimal values to Unicode fractions.
extension ExFractionFormat on double {
  /// Returns fraction symbol if matched (e.g., 0.25 → ¼).
  String toFractionSymbol() {
    final fractionMap = {
      0.25: '¼', 0.5: '½', 0.75: '¾',
      0.333: '⅓', 0.666: '⅔',
      0.2: '⅕', 0.4: '⅖', 0.6: '⅗', 0.8: '⅘',
      0.125: '⅛', 0.375: '⅜', 0.625: '⅝', 0.875: '⅞',
    };
    for (final entry in fractionMap.entries) {
      if ((this - entry.key).abs() < 0.01) return entry.value;
    }
    return toStringAsFixed(2);
  }

  /// Converts decimal to mixed fraction (e.g., 1.25 → 1¼).
  String toMixedFraction() {
    final whole = truncate();
    final frac = (this - whole).toFractionSymbol();
    return whole == 0 ? frac : '$whole$frac';
  }
}

/// Extension to create UI-friendly formula strings.
extension ExFormulaHelpers on num {
  /// Returns square formula: x² = y
  String asSquareFormula() => '$this² = $squareVal';

  /// Returns cube formula: x³ = y
  String asCubeFormula() => '$this³ = $cubeVal';

  /// Returns power formula: x^y = result
  String asPowerFormula(num exp) => '$this^$exp = ${pow(exp)}';

  /// Returns superscript power formula: xʸ = result
  String asSuperPowerFormula(num exp) => '${toSuperPower(exp)} = ${pow(exp)}';

  /// Returns root formula: √x = y
  String asRootFormula(int root) =>
      '${toRoot(root)} = ${nthRootValue(root).toStringAsFixed(4)}';

  /// Returns logarithmic formula.
  String asLogFormula(num base) {
    final logDisplay = logBase(base);
    final value = (math.log(this) / math.log(base)).toStringAsFixed(4);
    return '$logDisplay = $value';
  }

  /// Returns factorial formula.
  String asFactorialFormula() => '$this! = $factorial';

  /// Returns degree to radian conversion formula.
  String asDegreeToRadianFormula() =>
      '$this° = ${toRadians.toStringAsFixed(4)} rad';

  /// Returns radian to degree conversion formula.
  String asRadianToDegreeFormula() =>
      '$this rad = ${toDegrees.toStringAsFixed(2)}°';

  /// Returns sine formula.
  String asSinFormula() => 'sin($this) = ${sinRad.toStringAsFixed(4)}';

  /// Returns cosine formula.
  String asCosFormula() => 'cos($this) = ${cosRad.toStringAsFixed(4)}';

  /// Returns tangent formula.
  String asTanFormula() => 'tan($this) = ${tanRad.toStringAsFixed(4)}';
}
