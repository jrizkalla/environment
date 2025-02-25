"use strict";
var e = require("vscode"),
  t = require("path"),
  r = require("child_process"),
  n = require("fs"),
  o = require("os");
function i(e) {
  var t = Object.create(null);
  return (
    e &&
      Object.keys(e).forEach(function (r) {
        if ("default" !== r) {
          var n = Object.getOwnPropertyDescriptor(e, r);
          Object.defineProperty(
            t,
            r,
            n.get
              ? n
              : {
                  enumerable: !0,
                  get: function () {
                    return e[r];
                  },
                }
          );
        }
      }),
    (t.default = e),
    Object.freeze(t)
  );
}
var a = i(e);
function c(e, t) {
  if (!(e instanceof t))
    throw new TypeError("Cannot call a class as a function");
}
function s(e, t) {
  for (var r = 0; r < t.length; r++) {
    var n = t[r];
    (n.enumerable = n.enumerable || !1),
      (n.configurable = !0),
      "value" in n && (n.writable = !0),
      Object.defineProperty(e, n.key, n);
  }
}
function u(e, t, r) {
  return (
    t && s(e.prototype, t),
    r && s(e, r),
    Object.defineProperty(e, "prototype", { writable: !1 }),
    e
  );
}
var l =
    "undefined" != typeof globalThis
      ? globalThis
      : "undefined" != typeof window
      ? window
      : "undefined" != typeof global
      ? global
      : "undefined" != typeof self
      ? self
      : {},
  f = function (e) {
    return e && e.Math == Math && e;
  },
  h =
    f("object" == typeof globalThis && globalThis) ||
    f("object" == typeof window && window) ||
    f("object" == typeof self && self) ||
    f("object" == typeof l && l) ||
    (function () {
      return this;
    })() ||
    Function("return this")(),
  p = { exports: {} },
  d = h,
  g = Object.defineProperty,
  v = function (e, t) {
    try {
      g(d, e, { value: t, configurable: !0, writable: !0 });
    } catch (r) {
      d[e] = t;
    }
    return t;
  },
  m = v,
  y = h["__core-js_shared__"] || m("__core-js_shared__", {}),
  b = y;
(p.exports = function (e, t) {
  return b[e] || (b[e] = void 0 !== t ? t : {});
})("versions", []).push({
  version: "3.26.1",
  mode: "global",
  copyright: "© 2014-2022 Denis Pushkarev (zloirock.ru)",
  license: "https://github.com/zloirock/core-js/blob/v3.26.1/LICENSE",
  source: "https://github.com/zloirock/core-js",
});
var w,
  S,
  T = function (e) {
    try {
      return !!e();
    } catch (e) {
      return !0;
    }
  },
  x = !T(function () {
    var e = function () {}.bind();
    return "function" != typeof e || e.hasOwnProperty("prototype");
  }),
  E = x,
  O = Function.prototype,
  P = O.call,
  k = E && O.bind.bind(P, P),
  M = E
    ? k
    : function (e) {
        return function () {
          return P.apply(e, arguments);
        };
      },
  I = function (e) {
    return null == e;
  },
  A = I,
  j = TypeError,
  C = function (e) {
    if (A(e)) throw j("Can't call method on " + e);
    return e;
  },
  L = C,
  _ = Object,
  R = function (e) {
    return _(L(e));
  },
  F = R,
  D = M({}.hasOwnProperty),
  N =
    Object.hasOwn ||
    function (e, t) {
      return D(F(e), t);
    },
  $ = M,
  B = 0,
  V = Math.random(),
  U = $((1).toString),
  W = function (e) {
    return "Symbol(" + (void 0 === e ? "" : e) + ")_" + U(++B + V, 36);
  },
  H = "object" == typeof document && document.all,
  z = { all: H, IS_HTMLDDA: void 0 === H && void 0 !== H },
  G = z.all,
  K = z.IS_HTMLDDA
    ? function (e) {
        return "function" == typeof e || e === G;
      }
    : function (e) {
        return "function" == typeof e;
      },
  Y = h,
  q = K,
  X = function (e) {
    return q(e) ? e : void 0;
  },
  Q = function (e, t) {
    return arguments.length < 2 ? X(Y[e]) : Y[e] && Y[e][t];
  },
  Z = h,
  J = Q("navigator", "userAgent") || "",
  ee = Z.process,
  te = Z.Deno,
  re = (ee && ee.versions) || (te && te.version),
  ne = re && re.v8;
ne && (S = (w = ne.split("."))[0] > 0 && w[0] < 4 ? 1 : +(w[0] + w[1])),
  !S &&
    J &&
    (!(w = J.match(/Edge\/(\d+)/)) || w[1] >= 74) &&
    (w = J.match(/Chrome\/(\d+)/)) &&
    (S = +w[1]);
var oe = S,
  ie = oe,
  ae = T,
  ce =
    !!Object.getOwnPropertySymbols &&
    !ae(function () {
      var e = Symbol();
      return (
        !String(e) ||
        !(Object(e) instanceof Symbol) ||
        (!Symbol.sham && ie && ie < 41)
      );
    }),
  se = ce && !Symbol.sham && "symbol" == typeof Symbol.iterator,
  ue = h,
  le = p.exports,
  fe = N,
  he = W,
  pe = ce,
  de = se,
  ge = le("wks"),
  ve = ue.Symbol,
  me = ve && ve.for,
  ye = de ? ve : (ve && ve.withoutSetter) || he,
  be = function (e) {
    if (!fe(ge, e) || (!pe && "string" != typeof ge[e])) {
      var t = "Symbol." + e;
      pe && fe(ve, e) ? (ge[e] = ve[e]) : (ge[e] = de && me ? me(t) : ye(t));
    }
    return ge[e];
  },
  we = {};
we[be("toStringTag")] = "z";
var Se = "[object z]" === String(we),
  Te = {},
  xe = !T(function () {
    return (
      7 !=
      Object.defineProperty({}, 1, {
        get: function () {
          return 7;
        },
      })[1]
    );
  }),
  Ee = K,
  Oe = z.all,
  Pe = z.IS_HTMLDDA
    ? function (e) {
        return "object" == typeof e ? null !== e : Ee(e) || e === Oe;
      }
    : function (e) {
        return "object" == typeof e ? null !== e : Ee(e);
      },
  ke = Pe,
  Me = h.document,
  Ie = ke(Me) && ke(Me.createElement),
  Ae = function (e) {
    return Ie ? Me.createElement(e) : {};
  },
  je = Ae,
  Ce =
    !xe &&
    !T(function () {
      return (
        7 !=
        Object.defineProperty(je("div"), "a", {
          get: function () {
            return 7;
          },
        }).a
      );
    }),
  Le =
    xe &&
    T(function () {
      return (
        42 !=
        Object.defineProperty(function () {}, "prototype", {
          value: 42,
          writable: !1,
        }).prototype
      );
    }),
  _e = Pe,
  Re = String,
  Fe = TypeError,
  De = function (e) {
    if (_e(e)) return e;
    throw Fe(Re(e) + " is not an object");
  },
  Ne = x,
  $e = Function.prototype.call,
  Be = Ne
    ? $e.bind($e)
    : function () {
        return $e.apply($e, arguments);
      },
  Ve = M({}.isPrototypeOf),
  Ue = Q,
  We = K,
  He = Ve,
  ze = Object,
  Ge = se
    ? function (e) {
        return "symbol" == typeof e;
      }
    : function (e) {
        var t = Ue("Symbol");
        return We(t) && He(t.prototype, ze(e));
      },
  Ke = String,
  Ye = K,
  qe = TypeError,
  Xe = function (e) {
    if (Ye(e)) return e;
    throw qe(
      (function (e) {
        try {
          return Ke(e);
        } catch (e) {
          return "Object";
        }
      })(e) + " is not a function"
    );
  },
  Qe = Xe,
  Ze = I,
  Je = function (e, t) {
    var r = e[t];
    return Ze(r) ? void 0 : Qe(r);
  },
  et = Be,
  tt = K,
  rt = Pe,
  nt = TypeError,
  ot = Be,
  it = Pe,
  at = Ge,
  ct = Je,
  st = TypeError,
  ut = be("toPrimitive"),
  lt = function (e, t) {
    if (!it(e) || at(e)) return e;
    var r,
      n = ct(e, ut);
    if (n) {
      if ((void 0 === t && (t = "default"), (r = ot(n, e, t)), !it(r) || at(r)))
        return r;
      throw st("Can't convert object to primitive value");
    }
    return (
      void 0 === t && (t = "number"),
      (function (e, t) {
        var r, n;
        if ("string" === t && tt((r = e.toString)) && !rt((n = et(r, e))))
          return n;
        if (tt((r = e.valueOf)) && !rt((n = et(r, e)))) return n;
        if ("string" !== t && tt((r = e.toString)) && !rt((n = et(r, e))))
          return n;
        throw nt("Can't convert object to primitive value");
      })(e, t)
    );
  },
  ft = Ge,
  ht = function (e) {
    var t = lt(e, "string");
    return ft(t) ? t : t + "";
  },
  pt = xe,
  dt = Ce,
  gt = Le,
  vt = De,
  mt = ht,
  yt = TypeError,
  bt = Object.defineProperty,
  wt = Object.getOwnPropertyDescriptor;
Te.f = pt
  ? gt
    ? function (e, t, r) {
        if (
          (vt(e),
          (t = mt(t)),
          vt(r),
          "function" == typeof e &&
            "prototype" === t &&
            "value" in r &&
            "writable" in r &&
            !r.writable)
        ) {
          var n = wt(e, t);
          n &&
            n.writable &&
            ((e[t] = r.value),
            (r = {
              configurable:
                "configurable" in r ? r.configurable : n.configurable,
              enumerable: "enumerable" in r ? r.enumerable : n.enumerable,
              writable: !1,
            }));
        }
        return bt(e, t, r);
      }
    : bt
  : function (e, t, r) {
      if ((vt(e), (t = mt(t)), vt(r), dt))
        try {
          return bt(e, t, r);
        } catch (e) {}
      if ("get" in r || "set" in r) throw yt("Accessors not supported");
      return "value" in r && (e[t] = r.value), e;
    };
var St = { exports: {} },
  Tt = xe,
  xt = N,
  Et = Function.prototype,
  Ot = Tt && Object.getOwnPropertyDescriptor,
  Pt = xt(Et, "name"),
  kt = {
    EXISTS: Pt,
    PROPER: Pt && "something" === function () {}.name,
    CONFIGURABLE: Pt && (!Tt || (Tt && Ot(Et, "name").configurable)),
  },
  Mt = K,
  It = y,
  At = M(Function.toString);
Mt(It.inspectSource) ||
  (It.inspectSource = function (e) {
    return At(e);
  });
var jt,
  Ct,
  Lt,
  _t = It.inspectSource,
  Rt = K,
  Ft = h.WeakMap,
  Dt = Rt(Ft) && /native code/.test(String(Ft)),
  Nt = function (e, t) {
    return {
      enumerable: !(1 & e),
      configurable: !(2 & e),
      writable: !(4 & e),
      value: t,
    };
  },
  $t = Te,
  Bt = Nt,
  Vt = xe
    ? function (e, t, r) {
        return $t.f(e, t, Bt(1, r));
      }
    : function (e, t, r) {
        return (e[t] = r), e;
      },
  Ut = p.exports,
  Wt = W,
  Ht = Ut("keys"),
  zt = function (e) {
    return Ht[e] || (Ht[e] = Wt(e));
  },
  Gt = {},
  Kt = Dt,
  Yt = h,
  qt = Pe,
  Xt = Vt,
  Qt = N,
  Zt = y,
  Jt = zt,
  er = Gt,
  tr = Yt.TypeError,
  rr = Yt.WeakMap;
if (Kt || Zt.state) {
  var nr = Zt.state || (Zt.state = new rr());
  (nr.get = nr.get),
    (nr.has = nr.has),
    (nr.set = nr.set),
    (jt = function (e, t) {
      if (nr.has(e)) throw tr("Object already initialized");
      return (t.facade = e), nr.set(e, t), t;
    }),
    (Ct = function (e) {
      return nr.get(e) || {};
    }),
    (Lt = function (e) {
      return nr.has(e);
    });
} else {
  var or = Jt("state");
  (er[or] = !0),
    (jt = function (e, t) {
      if (Qt(e, or)) throw tr("Object already initialized");
      return (t.facade = e), Xt(e, or, t), t;
    }),
    (Ct = function (e) {
      return Qt(e, or) ? e[or] : {};
    }),
    (Lt = function (e) {
      return Qt(e, or);
    });
}
var ir = {
    set: jt,
    get: Ct,
    has: Lt,
    enforce: function (e) {
      return Lt(e) ? Ct(e) : jt(e, {});
    },
    getterFor: function (e) {
      return function (t) {
        var r;
        if (!qt(t) || (r = Ct(t)).type !== e)
          throw tr("Incompatible receiver, " + e + " required");
        return r;
      };
    },
  },
  ar = T,
  cr = K,
  sr = N,
  ur = xe,
  lr = kt.CONFIGURABLE,
  fr = _t,
  hr = ir.enforce,
  pr = ir.get,
  dr = Object.defineProperty,
  gr =
    ur &&
    !ar(function () {
      return 8 !== dr(function () {}, "length", { value: 8 }).length;
    }),
  vr = String(String).split("String"),
  mr = (St.exports = function (e, t, r) {
    "Symbol(" === String(t).slice(0, 7) &&
      (t = "[" + String(t).replace(/^Symbol\(([^)]*)\)/, "$1") + "]"),
      r && r.getter && (t = "get " + t),
      r && r.setter && (t = "set " + t),
      (!sr(e, "name") || (lr && e.name !== t)) &&
        (ur ? dr(e, "name", { value: t, configurable: !0 }) : (e.name = t)),
      gr &&
        r &&
        sr(r, "arity") &&
        e.length !== r.arity &&
        dr(e, "length", { value: r.arity });
    try {
      r && sr(r, "constructor") && r.constructor
        ? ur && dr(e, "prototype", { writable: !1 })
        : e.prototype && (e.prototype = void 0);
    } catch (e) {}
    var n = hr(e);
    return (
      sr(n, "source") || (n.source = vr.join("string" == typeof t ? t : "")), e
    );
  });
Function.prototype.toString = mr(function () {
  return (cr(this) && pr(this).source) || fr(this);
}, "toString");
var yr = K,
  br = Te,
  wr = St.exports,
  Sr = v,
  Tr = function (e, t, r, n) {
    n || (n = {});
    var o = n.enumerable,
      i = void 0 !== n.name ? n.name : t;
    if ((yr(r) && wr(r, i, n), n.global)) o ? (e[t] = r) : Sr(t, r);
    else {
      try {
        n.unsafe ? e[t] && (o = !0) : delete e[t];
      } catch (e) {}
      o
        ? (e[t] = r)
        : br.f(e, t, {
            value: r,
            enumerable: !1,
            configurable: !n.nonConfigurable,
            writable: !n.nonWritable,
          });
    }
    return e;
  },
  xr = M,
  Er = xr({}.toString),
  Or = xr("".slice),
  Pr = function (e) {
    return Or(Er(e), 8, -1);
  },
  kr = Se,
  Mr = K,
  Ir = Pr,
  Ar = be("toStringTag"),
  jr = Object,
  Cr =
    "Arguments" ==
    Ir(
      (function () {
        return arguments;
      })()
    ),
  Lr = kr
    ? Ir
    : function (e) {
        var t, r, n;
        return void 0 === e
          ? "Undefined"
          : null === e
          ? "Null"
          : "string" ==
            typeof (r = (function (e, t) {
              try {
                return e[t];
              } catch (e) {}
            })((t = jr(e)), Ar))
          ? r
          : Cr
          ? Ir(t)
          : "Object" == (n = Ir(t)) && Mr(t.callee)
          ? "Arguments"
          : n;
      },
  _r = Lr,
  Rr = Se
    ? {}.toString
    : function () {
        return "[object " + _r(this) + "]";
      };
Se || Tr(Object.prototype, "toString", Rr, { unsafe: !0 });
var Fr = Ae("span").classList,
  Dr = Fr && Fr.constructor && Fr.constructor.prototype,
  Nr = Dr === Object.prototype ? void 0 : Dr,
  $r = Pr,
  Br = M,
  Vr = function (e) {
    if ("Function" === $r(e)) return Br(e);
  },
  Ur = Xe,
  Wr = x,
  Hr = Vr(Vr.bind),
  zr = T,
  Gr = Pr,
  Kr = Object,
  Yr = M("".split),
  qr = zr(function () {
    return !Kr("z").propertyIsEnumerable(0);
  })
    ? function (e) {
        return "String" == Gr(e) ? Yr(e, "") : Kr(e);
      }
    : Kr,
  Xr = Math.ceil,
  Qr = Math.floor,
  Zr =
    Math.trunc ||
    function (e) {
      var t = +e;
      return (t > 0 ? Qr : Xr)(t);
    },
  Jr = function (e) {
    var t = +e;
    return t != t || 0 === t ? 0 : Zr(t);
  },
  en = Jr,
  tn = Math.min,
  rn = function (e) {
    return e > 0 ? tn(en(e), 9007199254740991) : 0;
  },
  nn = rn,
  on = function (e) {
    return nn(e.length);
  },
  an = Pr,
  cn =
    Array.isArray ||
    function (e) {
      return "Array" == an(e);
    },
  sn = M,
  un = T,
  ln = K,
  fn = Lr,
  hn = _t,
  pn = function () {},
  dn = [],
  gn = Q("Reflect", "construct"),
  vn = /^\s*(?:class|function)\b/,
  mn = sn(vn.exec),
  yn = !vn.exec(pn),
  bn = function (e) {
    if (!ln(e)) return !1;
    try {
      return gn(pn, dn, e), !0;
    } catch (e) {
      return !1;
    }
  },
  wn = function (e) {
    if (!ln(e)) return !1;
    switch (fn(e)) {
      case "AsyncFunction":
      case "GeneratorFunction":
      case "AsyncGeneratorFunction":
        return !1;
    }
    try {
      return yn || !!mn(vn, hn(e));
    } catch (e) {
      return !0;
    }
  };
wn.sham = !0;
var Sn =
    !gn ||
    un(function () {
      var e;
      return (
        bn(bn.call) ||
        !bn(Object) ||
        !bn(function () {
          e = !0;
        }) ||
        e
      );
    })
      ? wn
      : bn,
  Tn = cn,
  xn = Sn,
  En = Pe,
  On = be("species"),
  Pn = Array,
  kn = function (e, t) {
    return new ((function (e) {
      var t;
      return (
        Tn(e) &&
          ((t = e.constructor),
          ((xn(t) && (t === Pn || Tn(t.prototype))) ||
            (En(t) && null === (t = t[On]))) &&
            (t = void 0)),
        void 0 === t ? Pn : t
      );
    })(e))(0 === t ? 0 : t);
  },
  Mn = qr,
  In = R,
  An = on,
  jn = kn,
  Cn = M([].push),
  Ln = function (e) {
    var t = 1 == e,
      r = 2 == e,
      n = 3 == e,
      o = 4 == e,
      i = 6 == e,
      a = 7 == e,
      c = 5 == e || i;
    return function (s, u, l, f) {
      for (
        var h,
          p,
          d = In(s),
          g = Mn(d),
          v = (function (e, t) {
            return (
              Ur(e),
              void 0 === t
                ? e
                : Wr
                ? Hr(e, t)
                : function () {
                    return e.apply(t, arguments);
                  }
            );
          })(u, l),
          m = An(g),
          y = 0,
          b = f || jn,
          w = t ? b(s, m) : r || a ? b(s, 0) : void 0;
        m > y;
        y++
      )
        if ((c || y in g) && ((p = v((h = g[y]), y, d)), e))
          if (t) w[y] = p;
          else if (p)
            switch (e) {
              case 3:
                return !0;
              case 5:
                return h;
              case 6:
                return y;
              case 2:
                Cn(w, h);
            }
          else
            switch (e) {
              case 4:
                return !1;
              case 7:
                Cn(w, h);
            }
      return i ? -1 : n || o ? o : w;
    };
  },
  _n = {
    forEach: Ln(0),
    map: Ln(1),
    filter: Ln(2),
    some: Ln(3),
    every: Ln(4),
    find: Ln(5),
    findIndex: Ln(6),
    filterReject: Ln(7),
  },
  Rn = T,
  Fn = function (e, t) {
    var r = [][e];
    return (
      !!r &&
      Rn(function () {
        r.call(
          null,
          t ||
            function () {
              return 1;
            },
          1
        );
      })
    );
  },
  Dn = _n.forEach,
  Nn = h,
  $n = {
    CSSRuleList: 0,
    CSSStyleDeclaration: 0,
    CSSValueList: 0,
    ClientRectList: 0,
    DOMRectList: 0,
    DOMStringList: 0,
    DOMTokenList: 1,
    DataTransferItemList: 0,
    FileList: 0,
    HTMLAllCollection: 0,
    HTMLCollection: 0,
    HTMLFormElement: 0,
    HTMLSelectElement: 0,
    MediaList: 0,
    MimeTypeArray: 0,
    NamedNodeMap: 0,
    NodeList: 1,
    PaintRequestList: 0,
    Plugin: 0,
    PluginArray: 0,
    SVGLengthList: 0,
    SVGNumberList: 0,
    SVGPathSegList: 0,
    SVGPointList: 0,
    SVGStringList: 0,
    SVGTransformList: 0,
    SourceBufferList: 0,
    StyleSheetList: 0,
    TextTrackCueList: 0,
    TextTrackList: 0,
    TouchList: 0,
  },
  Bn = Nr,
  Vn = Fn("forEach")
    ? [].forEach
    : function (e) {
        return Dn(this, e, arguments.length > 1 ? arguments[1] : void 0);
      },
  Un = Vt,
  Wn = function (e) {
    if (e && e.forEach !== Vn)
      try {
        Un(e, "forEach", Vn);
      } catch (t) {
        e.forEach = Vn;
      }
  };
for (var Hn in $n) $n[Hn] && Wn(Nn[Hn] && Nn[Hn].prototype);
Wn(Bn);
var zn = {},
  Gn = {},
  Kn = {}.propertyIsEnumerable,
  Yn = Object.getOwnPropertyDescriptor,
  qn = Yn && !Kn.call({ 1: 2 }, 1);
Gn.f = qn
  ? function (e) {
      var t = Yn(this, e);
      return !!t && t.enumerable;
    }
  : Kn;
var Xn = qr,
  Qn = C,
  Zn = function (e) {
    return Xn(Qn(e));
  },
  Jn = xe,
  eo = Be,
  to = Gn,
  ro = Nt,
  no = Zn,
  oo = ht,
  io = N,
  ao = Ce,
  co = Object.getOwnPropertyDescriptor;
zn.f = Jn
  ? co
  : function (e, t) {
      if (((e = no(e)), (t = oo(t)), ao))
        try {
          return co(e, t);
        } catch (e) {}
      if (io(e, t)) return ro(!eo(to.f, e, t), e[t]);
    };
var so = {},
  uo = Jr,
  lo = Math.max,
  fo = Math.min,
  ho = function (e, t) {
    var r = uo(e);
    return r < 0 ? lo(r + t, 0) : fo(r, t);
  },
  po = Zn,
  go = ho,
  vo = on,
  mo = function (e) {
    return function (t, r, n) {
      var o,
        i = po(t),
        a = vo(i),
        c = go(n, a);
      if (e && r != r) {
        for (; a > c; ) if ((o = i[c++]) != o) return !0;
      } else
        for (; a > c; c++) if ((e || c in i) && i[c] === r) return e || c || 0;
      return !e && -1;
    };
  },
  yo = { includes: mo(!0), indexOf: mo(!1) },
  bo = N,
  wo = Zn,
  So = yo.indexOf,
  To = Gt,
  xo = M([].push),
  Eo = function (e, t) {
    var r,
      n = wo(e),
      o = 0,
      i = [];
    for (r in n) !bo(To, r) && bo(n, r) && xo(i, r);
    for (; t.length > o; ) bo(n, (r = t[o++])) && (~So(i, r) || xo(i, r));
    return i;
  },
  Oo = [
    "constructor",
    "hasOwnProperty",
    "isPrototypeOf",
    "propertyIsEnumerable",
    "toLocaleString",
    "toString",
    "valueOf",
  ],
  Po = Eo,
  ko = Oo.concat("length", "prototype");
so.f =
  Object.getOwnPropertyNames ||
  function (e) {
    return Po(e, ko);
  };
var Mo = {};
Mo.f = Object.getOwnPropertySymbols;
var Io = Q,
  Ao = so,
  jo = Mo,
  Co = De,
  Lo = M([].concat),
  _o =
    Io("Reflect", "ownKeys") ||
    function (e) {
      var t = Ao.f(Co(e)),
        r = jo.f;
      return r ? Lo(t, r(e)) : t;
    },
  Ro = N,
  Fo = _o,
  Do = zn,
  No = Te,
  $o = T,
  Bo = K,
  Vo = /#|\.prototype\./,
  Uo = function (e, t) {
    var r = Ho[Wo(e)];
    return r == Go || (r != zo && (Bo(t) ? $o(t) : !!t));
  },
  Wo = (Uo.normalize = function (e) {
    return String(e).replace(Vo, ".").toLowerCase();
  }),
  Ho = (Uo.data = {}),
  zo = (Uo.NATIVE = "N"),
  Go = (Uo.POLYFILL = "P"),
  Ko = Uo,
  Yo = h,
  qo = zn.f,
  Xo = Vt,
  Qo = Tr,
  Zo = v,
  Jo = function (e, t, r) {
    for (var n = Fo(t), o = No.f, i = Do.f, a = 0; a < n.length; a++) {
      var c = n[a];
      Ro(e, c) || (r && Ro(r, c)) || o(e, c, i(t, c));
    }
  },
  ei = Ko,
  ti = function (e, t) {
    var r,
      n,
      o,
      i,
      a,
      c = e.target,
      s = e.global,
      u = e.stat;
    if ((r = s ? Yo : u ? Yo[c] || Zo(c, {}) : (Yo[c] || {}).prototype))
      for (n in t) {
        if (
          ((i = t[n]),
          (o = e.dontCallGetSet ? (a = qo(r, n)) && a.value : r[n]),
          !ei(s ? n : c + (u ? "." : "#") + n, e.forced) && void 0 !== o)
        ) {
          if (typeof i == typeof o) continue;
          Jo(i, o);
        }
        (e.sham || (o && o.sham)) && Xo(i, "sham", !0), Qo(r, n, i, e);
      }
  },
  ri = Eo,
  ni = Oo,
  oi =
    Object.keys ||
    function (e) {
      return ri(e, ni);
    },
  ii = R,
  ai = oi;
ti(
  {
    target: "Object",
    stat: !0,
    forced: T(function () {
      ai(1);
    }),
  },
  {
    keys: function (e) {
      return ai(ii(e));
    },
  }
);
var ci = Lr,
  si = String,
  ui = function (e) {
    if ("Symbol" === ci(e))
      throw TypeError("Cannot convert a Symbol value to a string");
    return si(e);
  },
  li = De,
  fi = T,
  hi = h.RegExp,
  pi = fi(function () {
    var e = hi("a", "y");
    return (e.lastIndex = 2), null != e.exec("abcd");
  }),
  di =
    pi ||
    fi(function () {
      return !hi("a", "y").sticky;
    }),
  gi = {
    BROKEN_CARET:
      pi ||
      fi(function () {
        var e = hi("^r", "gy");
        return (e.lastIndex = 2), null != e.exec("str");
      }),
    MISSED_STICKY: di,
    UNSUPPORTED_Y: pi,
  },
  vi = {},
  mi = xe,
  yi = Le,
  bi = Te,
  wi = De,
  Si = Zn,
  Ti = oi;
vi.f =
  mi && !yi
    ? Object.defineProperties
    : function (e, t) {
        wi(e);
        for (var r, n = Si(t), o = Ti(t), i = o.length, a = 0; i > a; )
          bi.f(e, (r = o[a++]), n[r]);
        return e;
      };
var xi,
  Ei = Q("document", "documentElement"),
  Oi = De,
  Pi = vi,
  ki = Oo,
  Mi = Gt,
  Ii = Ei,
  Ai = Ae,
  ji = zt("IE_PROTO"),
  Ci = function () {},
  Li = function (e) {
    return "<script>" + e + "</script>";
  },
  _i = function (e) {
    e.write(Li("")), e.close();
    var t = e.parentWindow.Object;
    return (e = null), t;
  },
  Ri = function () {
    try {
      xi = new ActiveXObject("htmlfile");
    } catch (e) {}
    var e, t;
    Ri =
      "undefined" != typeof document
        ? document.domain && xi
          ? _i(xi)
          : (((t = Ai("iframe")).style.display = "none"),
            Ii.appendChild(t),
            (t.src = String("javascript:")),
            (e = t.contentWindow.document).open(),
            e.write(Li("document.F=Object")),
            e.close(),
            e.F)
        : _i(xi);
    for (var r = ki.length; r--; ) delete Ri.prototype[ki[r]];
    return Ri();
  };
Mi[ji] = !0;
var Fi,
  Di,
  Ni =
    Object.create ||
    function (e, t) {
      var r;
      return (
        null !== e
          ? ((Ci.prototype = Oi(e)),
            (r = new Ci()),
            (Ci.prototype = null),
            (r[ji] = e))
          : (r = Ri()),
        void 0 === t ? r : Pi.f(r, t)
      );
    },
  $i = T,
  Bi = h.RegExp,
  Vi = $i(function () {
    var e = Bi(".", "s");
    return !(e.dotAll && e.exec("\n") && "s" === e.flags);
  }),
  Ui = T,
  Wi = h.RegExp,
  Hi = Ui(function () {
    var e = Wi("(?<a>b)", "g");
    return "b" !== e.exec("b").groups.a || "bc" !== "b".replace(e, "$<a>c");
  }),
  zi = Be,
  Gi = M,
  Ki = ui,
  Yi = function () {
    var e = li(this),
      t = "";
    return (
      e.hasIndices && (t += "d"),
      e.global && (t += "g"),
      e.ignoreCase && (t += "i"),
      e.multiline && (t += "m"),
      e.dotAll && (t += "s"),
      e.unicode && (t += "u"),
      e.unicodeSets && (t += "v"),
      e.sticky && (t += "y"),
      t
    );
  },
  qi = gi,
  Xi = p.exports,
  Qi = Ni,
  Zi = ir.get,
  Ji = Vi,
  ea = Hi,
  ta = Xi("native-string-replace", String.prototype.replace),
  ra = RegExp.prototype.exec,
  na = ra,
  oa = Gi("".charAt),
  ia = Gi("".indexOf),
  aa = Gi("".replace),
  ca = Gi("".slice),
  sa =
    ((Di = /b*/g),
    zi(ra, (Fi = /a/), "a"),
    zi(ra, Di, "a"),
    0 !== Fi.lastIndex || 0 !== Di.lastIndex),
  ua = qi.BROKEN_CARET,
  la = void 0 !== /()??/.exec("")[1];
(sa || la || ua || Ji || ea) &&
  (na = function (e) {
    var t,
      r,
      n,
      o,
      i,
      a,
      c,
      s = this,
      u = Zi(s),
      l = Ki(e),
      f = u.raw;
    if (f)
      return (
        (f.lastIndex = s.lastIndex),
        (t = zi(na, f, l)),
        (s.lastIndex = f.lastIndex),
        t
      );
    var h = u.groups,
      p = ua && s.sticky,
      d = zi(Yi, s),
      g = s.source,
      v = 0,
      m = l;
    if (
      (p &&
        ((d = aa(d, "y", "")),
        -1 === ia(d, "g") && (d += "g"),
        (m = ca(l, s.lastIndex)),
        s.lastIndex > 0 &&
          (!s.multiline || (s.multiline && "\n" !== oa(l, s.lastIndex - 1))) &&
          ((g = "(?: " + g + ")"), (m = " " + m), v++),
        (r = new RegExp("^(?:" + g + ")", d))),
      la && (r = new RegExp("^" + g + "$(?!\\s)", d)),
      sa && (n = s.lastIndex),
      (o = zi(ra, p ? r : s, m)),
      p
        ? o
          ? ((o.input = ca(o.input, v)),
            (o[0] = ca(o[0], v)),
            (o.index = s.lastIndex),
            (s.lastIndex += o[0].length))
          : (s.lastIndex = 0)
        : sa && o && (s.lastIndex = s.global ? o.index + o[0].length : n),
      la &&
        o &&
        o.length > 1 &&
        zi(ta, o[0], r, function () {
          for (i = 1; i < arguments.length - 2; i++)
            void 0 === arguments[i] && (o[i] = void 0);
        }),
      o && h)
    )
      for (o.groups = a = Qi(null), i = 0; i < h.length; i++)
        a[(c = h[i])[0]] = o[c[1]];
    return o;
  });
var fa = na;
ti({ target: "RegExp", proto: !0, forced: /./.exec !== fa }, { exec: fa });
var ha = x,
  pa = Function.prototype,
  da = pa.apply,
  ga = pa.call,
  va =
    ("object" == typeof Reflect && Reflect.apply) ||
    (ha
      ? ga.bind(da)
      : function () {
          return ga.apply(da, arguments);
        }),
  ma = Vr,
  ya = Tr,
  ba = fa,
  wa = T,
  Sa = be,
  Ta = Vt,
  xa = Sa("species"),
  Ea = RegExp.prototype,
  Oa = function (e, t, r, n) {
    var o = Sa(e),
      i = !wa(function () {
        var t = {};
        return (
          (t[o] = function () {
            return 7;
          }),
          7 != ""[e](t)
        );
      }),
      a =
        i &&
        !wa(function () {
          var t = !1,
            r = /a/;
          return (
            "split" === e &&
              (((r = {}).constructor = {}),
              (r.constructor[xa] = function () {
                return r;
              }),
              (r.flags = ""),
              (r[o] = /./[o])),
            (r.exec = function () {
              return (t = !0), null;
            }),
            r[o](""),
            !t
          );
        });
    if (!i || !a || r) {
      var c = ma(/./[o]),
        s = t(o, ""[e], function (e, t, r, n, o) {
          var a = ma(e),
            s = t.exec;
          return s === ba || s === Ea.exec
            ? i && !o
              ? { done: !0, value: c(t, r, n) }
              : { done: !0, value: a(r, t, n) }
            : { done: !1 };
        });
      ya(String.prototype, e, s[0]), ya(Ea, o, s[1]);
    }
    n && Ta(Ea[o], "sham", !0);
  },
  Pa = M,
  ka = Jr,
  Ma = ui,
  Ia = C,
  Aa = Pa("".charAt),
  ja = Pa("".charCodeAt),
  Ca = Pa("".slice),
  La = function (e) {
    return function (t, r) {
      var n,
        o,
        i = Ma(Ia(t)),
        a = ka(r),
        c = i.length;
      return a < 0 || a >= c
        ? e
          ? ""
          : void 0
        : (n = ja(i, a)) < 55296 ||
          n > 56319 ||
          a + 1 === c ||
          (o = ja(i, a + 1)) < 56320 ||
          o > 57343
        ? e
          ? Aa(i, a)
          : n
        : e
        ? Ca(i, a, a + 2)
        : o - 56320 + ((n - 55296) << 10) + 65536;
    };
  },
  _a = (La(!1), La(!0)),
  Ra = function (e, t, r) {
    return t + (r ? _a(e, t).length : 1);
  },
  Fa = M,
  Da = R,
  Na = Math.floor,
  $a = Fa("".charAt),
  Ba = Fa("".replace),
  Va = Fa("".slice),
  Ua = /\$([$&'`]|\d{1,2}|<[^>]*>)/g,
  Wa = /\$([$&'`]|\d{1,2})/g,
  Ha = Be,
  za = De,
  Ga = K,
  Ka = Pr,
  Ya = fa,
  qa = TypeError,
  Xa = function (e, t) {
    var r = e.exec;
    if (Ga(r)) {
      var n = Ha(r, e, t);
      return null !== n && za(n), n;
    }
    if ("RegExp" === Ka(e)) return Ha(Ya, e, t);
    throw qa("RegExp#exec called on incompatible receiver");
  },
  Qa = va,
  Za = Be,
  Ja = M,
  ec = Oa,
  tc = T,
  rc = De,
  nc = K,
  oc = I,
  ic = Jr,
  ac = rn,
  cc = ui,
  sc = C,
  uc = Ra,
  lc = Je,
  fc = function (e, t, r, n, o, i) {
    var a = r + e.length,
      c = n.length,
      s = Wa;
    return (
      void 0 !== o && ((o = Da(o)), (s = Ua)),
      Ba(i, s, function (i, s) {
        var u;
        switch ($a(s, 0)) {
          case "$":
            return "$";
          case "&":
            return e;
          case "`":
            return Va(t, 0, r);
          case "'":
            return Va(t, a);
          case "<":
            u = o[Va(s, 1, -1)];
            break;
          default:
            var l = +s;
            if (0 === l) return i;
            if (l > c) {
              var f = Na(l / 10);
              return 0 === f
                ? i
                : f <= c
                ? void 0 === n[f - 1]
                  ? $a(s, 1)
                  : n[f - 1] + $a(s, 1)
                : i;
            }
            u = n[l - 1];
        }
        return void 0 === u ? "" : u;
      })
    );
  },
  hc = Xa,
  pc = be("replace"),
  dc = Math.max,
  gc = Math.min,
  vc = Ja([].concat),
  mc = Ja([].push),
  yc = Ja("".indexOf),
  bc = Ja("".slice),
  wc = "$0" === "a".replace(/./, "$0"),
  Sc = !!/./[pc] && "" === /./[pc]("a", "$0");
ec(
  "replace",
  function (e, t, r) {
    var n = Sc ? "$" : "$0";
    return [
      function (e, r) {
        var n = sc(this),
          o = oc(e) ? void 0 : lc(e, pc);
        return o ? Za(o, e, n, r) : Za(t, cc(n), e, r);
      },
      function (e, o) {
        var i = rc(this),
          a = cc(e);
        if ("string" == typeof o && -1 === yc(o, n) && -1 === yc(o, "$<")) {
          var c = r(t, i, a, o);
          if (c.done) return c.value;
        }
        var s = nc(o);
        s || (o = cc(o));
        var u = i.global;
        if (u) {
          var l = i.unicode;
          i.lastIndex = 0;
        }
        for (var f = []; ; ) {
          var h = hc(i, a);
          if (null === h) break;
          if ((mc(f, h), !u)) break;
          "" === cc(h[0]) && (i.lastIndex = uc(a, ac(i.lastIndex), l));
        }
        for (var p, d = "", g = 0, v = 0; v < f.length; v++) {
          for (
            var m = cc((h = f[v])[0]),
              y = dc(gc(ic(h.index), a.length), 0),
              b = [],
              w = 1;
            w < h.length;
            w++
          )
            mc(b, void 0 === (p = h[w]) ? p : String(p));
          var S = h.groups;
          if (s) {
            var T = vc([m], b, y, a);
            void 0 !== S && mc(T, S);
            var x = cc(Qa(o, void 0, T));
          } else x = fc(m, a, y, b, S, o);
          y >= g && ((d += bc(a, g, y) + x), (g = y + m.length));
        }
        return d + bc(a, g);
      },
    ];
  },
  !!tc(function () {
    var e = /./;
    return (
      (e.exec = function () {
        var e = [];
        return (e.groups = { a: "7" }), e;
      }),
      "7" !== "".replace(e, "$<a>")
    );
  }) ||
    !wc ||
    Sc
);
var Tc = ti,
  xc = qr,
  Ec = Zn,
  Oc = Fn,
  Pc = M([].join),
  kc = xc != Object,
  Mc = Oc("join", ",");
Tc(
  { target: "Array", proto: !0, forced: kc || !Mc },
  {
    join: function (e) {
      return Pc(Ec(this), void 0 === e ? "," : e);
    },
  }
);
var Ic = T,
  Ac = oe,
  jc = be("species"),
  Cc = function (e) {
    return (
      Ac >= 51 ||
      !Ic(function () {
        var t = [];
        return (
          ((t.constructor = {})[jc] = function () {
            return { foo: 1 };
          }),
          1 !== t[e](Boolean).foo
        );
      })
    );
  },
  Lc = _n.map;
ti(
  { target: "Array", proto: !0, forced: !Cc("map") },
  {
    map: function (e) {
      return Lc(this, e, arguments.length > 1 ? arguments[1] : void 0);
    },
  }
);
var _c = TypeError,
  Rc = ht,
  Fc = Te,
  Dc = Nt,
  Nc = function (e, t, r) {
    var n = Rc(t);
    n in e ? Fc.f(e, n, Dc(0, r)) : (e[n] = r);
  },
  $c = ti,
  Bc = T,
  Vc = cn,
  Uc = Pe,
  Wc = R,
  Hc = on,
  zc = function (e) {
    if (e > 9007199254740991) throw _c("Maximum allowed index exceeded");
    return e;
  },
  Gc = Nc,
  Kc = kn,
  Yc = Cc,
  qc = oe,
  Xc = be("isConcatSpreadable"),
  Qc =
    qc >= 51 ||
    !Bc(function () {
      var e = [];
      return (e[Xc] = !1), e.concat()[0] !== e;
    }),
  Zc = Yc("concat"),
  Jc = function (e) {
    if (!Uc(e)) return !1;
    var t = e[Xc];
    return void 0 !== t ? !!t : Vc(e);
  };
$c(
  { target: "Array", proto: !0, arity: 1, forced: !Qc || !Zc },
  {
    concat: function (e) {
      var t,
        r,
        n,
        o,
        i,
        a = Wc(this),
        c = Kc(a, 0),
        s = 0;
      for (t = -1, n = arguments.length; t < n; t++)
        if (Jc((i = -1 === t ? a : arguments[t])))
          for (o = Hc(i), zc(s + o), r = 0; r < o; r++, s++)
            r in i && Gc(c, s, i[r]);
        else zc(s + 1), Gc(c, s++, i);
      return (c.length = s), c;
    },
  }
);
var es = {
    APP: {
      NAME: "MonokaiPro-VSCode",
      THEMES: [
        "Monokai Pro",
        "Monokai Pro (Filter Octagon)",
        "Monokai Pro (Filter Ristretto)",
        "Monokai Pro (Filter Spectrum)",
        "Monokai Pro (Filter Machine)",
        "Monokai Classic",
      ],
      DESCRIPTION: "Monokai Pro theme and color scheme for Visual Studio Code",
      VERSION: "1.2.0",
      AUTHOR: "Monokai",
      CREATION_DATE: 2022,
      BUILD_DATE: "27-11-2022",
      UUID: "fd330f6f-3f41-421d-9fe5-de742d0c54c0",
      SECONDS_TO_EXPIRE: 172800,
      SECONDS_TO_EXPIRE_FAST: 86400,
      SLOW_PERIOD: 604800,
    },
  },
  ts = Be,
  rs = De,
  ns = I,
  os = rn,
  is = ui,
  as = C,
  cs = Je,
  ss = Ra,
  us = Xa;
Oa("match", function (e, t, r) {
  return [
    function (t) {
      var r = as(this),
        n = ns(t) ? void 0 : cs(t, e);
      return n ? ts(n, t, r) : new RegExp(t)[e](is(r));
    },
    function (e) {
      var n = rs(this),
        o = is(e),
        i = r(t, n, o);
      if (i.done) return i.value;
      if (!n.global) return us(n, o);
      var a = n.unicode;
      n.lastIndex = 0;
      for (var c, s = [], u = 0; null !== (c = us(n, o)); ) {
        var l = is(c[0]);
        (s[u] = l), "" === l && (n.lastIndex = ss(o, os(n.lastIndex), a)), u++;
      }
      return 0 === u ? null : s;
    },
  ];
});
var ls = M([].slice),
  fs = ti,
  hs = cn,
  ps = Sn,
  ds = Pe,
  gs = ho,
  vs = on,
  ms = Zn,
  ys = Nc,
  bs = be,
  ws = ls,
  Ss = Cc("slice"),
  Ts = bs("species"),
  xs = Array,
  Es = Math.max;
fs(
  { target: "Array", proto: !0, forced: !Ss },
  {
    slice: function (e, t) {
      var r,
        n,
        o,
        i = ms(this),
        a = vs(i),
        c = gs(e, a),
        s = gs(void 0 === t ? a : t, a);
      if (
        hs(i) &&
        ((r = i.constructor),
        ((ps(r) && (r === xs || hs(r.prototype))) ||
          (ds(r) && null === (r = r[Ts]))) &&
          (r = void 0),
        r === xs || void 0 === r)
      )
        return ws(i, c, s);
      for (
        n = new (void 0 === r ? xs : r)(Es(s - c, 0)), o = 0;
        c < s;
        c++, o++
      )
        c in i && ys(n, o, i[c]);
      return (n.length = o), n;
    },
  }
);
var Os = be,
  Ps = Ni,
  ks = Te.f,
  Ms = Os("unscopables"),
  Is = Array.prototype;
null == Is[Ms] && ks(Is, Ms, { configurable: !0, value: Ps(null) });
var As,
  js = yo.includes;
ti(
  {
    target: "Array",
    proto: !0,
    forced: T(function () {
      return !Array(1).includes();
    }),
  },
  {
    includes: function (e) {
      return js(this, e, arguments.length > 1 ? arguments[1] : void 0);
    },
  }
),
  (As = "includes"),
  (Is[Ms][As] = !0);
var Cs = Pe,
  Ls = Pr,
  _s = be("match"),
  Rs = TypeError,
  Fs = be("match"),
  Ds = ti,
  Ns = function (e) {
    if (
      (function (e) {
        var t;
        return Cs(e) && (void 0 !== (t = e[_s]) ? !!t : "RegExp" == Ls(e));
      })(e)
    )
      throw Rs("The method doesn't accept regular expressions");
    return e;
  },
  $s = C,
  Bs = ui,
  Vs = M("".indexOf);
Ds(
  {
    target: "String",
    proto: !0,
    forced: !(function (e) {
      var t = /./;
      try {
        "/./"[e](t);
      } catch (r) {
        try {
          return (t[Fs] = !1), "/./"[e](t);
        } catch (e) {}
      }
      return !1;
    })("includes"),
  },
  {
    includes: function (e) {
      return !!~Vs(
        Bs($s(this)),
        Bs(Ns(e)),
        arguments.length > 1 ? arguments[1] : void 0
      );
    },
  }
);
var Us,
  Ws,
  Hs = { exports: {} },
  zs = { exports: {} };
(Us = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"),
  (Ws = {
    rotl: function (e, t) {
      return (e << t) | (e >>> (32 - t));
    },
    rotr: function (e, t) {
      return (e << (32 - t)) | (e >>> t);
    },
    endian: function (e) {
      if (e.constructor == Number)
        return (16711935 & Ws.rotl(e, 8)) | (4278255360 & Ws.rotl(e, 24));
      for (var t = 0; t < e.length; t++) e[t] = Ws.endian(e[t]);
      return e;
    },
    randomBytes: function (e) {
      for (var t = []; e > 0; e--) t.push(Math.floor(256 * Math.random()));
      return t;
    },
    bytesToWords: function (e) {
      for (var t = [], r = 0, n = 0; r < e.length; r++, n += 8)
        t[n >>> 5] |= e[r] << (24 - (n % 32));
      return t;
    },
    wordsToBytes: function (e) {
      for (var t = [], r = 0; r < 32 * e.length; r += 8)
        t.push((e[r >>> 5] >>> (24 - (r % 32))) & 255);
      return t;
    },
    bytesToHex: function (e) {
      for (var t = [], r = 0; r < e.length; r++)
        t.push((e[r] >>> 4).toString(16)), t.push((15 & e[r]).toString(16));
      return t.join("");
    },
    hexToBytes: function (e) {
      for (var t = [], r = 0; r < e.length; r += 2)
        t.push(parseInt(e.substr(r, 2), 16));
      return t;
    },
    bytesToBase64: function (e) {
      for (var t = [], r = 0; r < e.length; r += 3)
        for (
          var n = (e[r] << 16) | (e[r + 1] << 8) | e[r + 2], o = 0;
          o < 4;
          o++
        )
          8 * r + 6 * o <= 8 * e.length
            ? t.push(Us.charAt((n >>> (6 * (3 - o))) & 63))
            : t.push("=");
      return t.join("");
    },
    base64ToBytes: function (e) {
      e = e.replace(/[^A-Z0-9+\/]/gi, "");
      for (var t = [], r = 0, n = 0; r < e.length; n = ++r % 4)
        0 != n &&
          t.push(
            ((Us.indexOf(e.charAt(r - 1)) & (Math.pow(2, -2 * n + 8) - 1)) <<
              (2 * n)) |
              (Us.indexOf(e.charAt(r)) >>> (6 - 2 * n))
          );
      return t;
    },
  }),
  (zs.exports = Ws);
var Gs = {
    utf8: {
      stringToBytes: function (e) {
        return Gs.bin.stringToBytes(unescape(encodeURIComponent(e)));
      },
      bytesToString: function (e) {
        return decodeURIComponent(escape(Gs.bin.bytesToString(e)));
      },
    },
    bin: {
      stringToBytes: function (e) {
        for (var t = [], r = 0; r < e.length; r++)
          t.push(255 & e.charCodeAt(r));
        return t;
      },
      bytesToString: function (e) {
        for (var t = [], r = 0; r < e.length; r++)
          t.push(String.fromCharCode(e[r]));
        return t.join("");
      },
    },
  },
  Ks = Gs,
  Ys = function (e) {
    return (
      null != e &&
      (qs(e) ||
        (function (e) {
          return (
            "function" == typeof e.readFloatLE &&
            "function" == typeof e.slice &&
            qs(e.slice(0, 0))
          );
        })(e) ||
        !!e._isBuffer)
    );
  };
function qs(e) {
  return (
    !!e.constructor &&
    "function" == typeof e.constructor.isBuffer &&
    e.constructor.isBuffer(e)
  );
}
!(function () {
  var e = zs.exports,
    t = Ks.utf8,
    r = Ys,
    n = Ks.bin,
    o = function (i, a) {
      i.constructor == String
        ? (i =
            a && "binary" === a.encoding
              ? n.stringToBytes(i)
              : t.stringToBytes(i))
        : r(i)
        ? (i = Array.prototype.slice.call(i, 0))
        : Array.isArray(i) ||
          i.constructor === Uint8Array ||
          (i = i.toString());
      for (
        var c = e.bytesToWords(i),
          s = 8 * i.length,
          u = 1732584193,
          l = -271733879,
          f = -1732584194,
          h = 271733878,
          p = 0;
        p < c.length;
        p++
      )
        c[p] =
          (16711935 & ((c[p] << 8) | (c[p] >>> 24))) |
          (4278255360 & ((c[p] << 24) | (c[p] >>> 8)));
      (c[s >>> 5] |= 128 << s % 32), (c[14 + (((s + 64) >>> 9) << 4)] = s);
      var d = o._ff,
        g = o._gg,
        v = o._hh,
        m = o._ii;
      for (p = 0; p < c.length; p += 16) {
        var y = u,
          b = l,
          w = f,
          S = h;
        (u = d(u, l, f, h, c[p + 0], 7, -680876936)),
          (h = d(h, u, l, f, c[p + 1], 12, -389564586)),
          (f = d(f, h, u, l, c[p + 2], 17, 606105819)),
          (l = d(l, f, h, u, c[p + 3], 22, -1044525330)),
          (u = d(u, l, f, h, c[p + 4], 7, -176418897)),
          (h = d(h, u, l, f, c[p + 5], 12, 1200080426)),
          (f = d(f, h, u, l, c[p + 6], 17, -1473231341)),
          (l = d(l, f, h, u, c[p + 7], 22, -45705983)),
          (u = d(u, l, f, h, c[p + 8], 7, 1770035416)),
          (h = d(h, u, l, f, c[p + 9], 12, -1958414417)),
          (f = d(f, h, u, l, c[p + 10], 17, -42063)),
          (l = d(l, f, h, u, c[p + 11], 22, -1990404162)),
          (u = d(u, l, f, h, c[p + 12], 7, 1804603682)),
          (h = d(h, u, l, f, c[p + 13], 12, -40341101)),
          (f = d(f, h, u, l, c[p + 14], 17, -1502002290)),
          (u = g(
            u,
            (l = d(l, f, h, u, c[p + 15], 22, 1236535329)),
            f,
            h,
            c[p + 1],
            5,
            -165796510
          )),
          (h = g(h, u, l, f, c[p + 6], 9, -1069501632)),
          (f = g(f, h, u, l, c[p + 11], 14, 643717713)),
          (l = g(l, f, h, u, c[p + 0], 20, -373897302)),
          (u = g(u, l, f, h, c[p + 5], 5, -701558691)),
          (h = g(h, u, l, f, c[p + 10], 9, 38016083)),
          (f = g(f, h, u, l, c[p + 15], 14, -660478335)),
          (l = g(l, f, h, u, c[p + 4], 20, -405537848)),
          (u = g(u, l, f, h, c[p + 9], 5, 568446438)),
          (h = g(h, u, l, f, c[p + 14], 9, -1019803690)),
          (f = g(f, h, u, l, c[p + 3], 14, -187363961)),
          (l = g(l, f, h, u, c[p + 8], 20, 1163531501)),
          (u = g(u, l, f, h, c[p + 13], 5, -1444681467)),
          (h = g(h, u, l, f, c[p + 2], 9, -51403784)),
          (f = g(f, h, u, l, c[p + 7], 14, 1735328473)),
          (u = v(
            u,
            (l = g(l, f, h, u, c[p + 12], 20, -1926607734)),
            f,
            h,
            c[p + 5],
            4,
            -378558
          )),
          (h = v(h, u, l, f, c[p + 8], 11, -2022574463)),
          (f = v(f, h, u, l, c[p + 11], 16, 1839030562)),
          (l = v(l, f, h, u, c[p + 14], 23, -35309556)),
          (u = v(u, l, f, h, c[p + 1], 4, -1530992060)),
          (h = v(h, u, l, f, c[p + 4], 11, 1272893353)),
          (f = v(f, h, u, l, c[p + 7], 16, -155497632)),
          (l = v(l, f, h, u, c[p + 10], 23, -1094730640)),
          (u = v(u, l, f, h, c[p + 13], 4, 681279174)),
          (h = v(h, u, l, f, c[p + 0], 11, -358537222)),
          (f = v(f, h, u, l, c[p + 3], 16, -722521979)),
          (l = v(l, f, h, u, c[p + 6], 23, 76029189)),
          (u = v(u, l, f, h, c[p + 9], 4, -640364487)),
          (h = v(h, u, l, f, c[p + 12], 11, -421815835)),
          (f = v(f, h, u, l, c[p + 15], 16, 530742520)),
          (u = m(
            u,
            (l = v(l, f, h, u, c[p + 2], 23, -995338651)),
            f,
            h,
            c[p + 0],
            6,
            -198630844
          )),
          (h = m(h, u, l, f, c[p + 7], 10, 1126891415)),
          (f = m(f, h, u, l, c[p + 14], 15, -1416354905)),
          (l = m(l, f, h, u, c[p + 5], 21, -57434055)),
          (u = m(u, l, f, h, c[p + 12], 6, 1700485571)),
          (h = m(h, u, l, f, c[p + 3], 10, -1894986606)),
          (f = m(f, h, u, l, c[p + 10], 15, -1051523)),
          (l = m(l, f, h, u, c[p + 1], 21, -2054922799)),
          (u = m(u, l, f, h, c[p + 8], 6, 1873313359)),
          (h = m(h, u, l, f, c[p + 15], 10, -30611744)),
          (f = m(f, h, u, l, c[p + 6], 15, -1560198380)),
          (l = m(l, f, h, u, c[p + 13], 21, 1309151649)),
          (u = m(u, l, f, h, c[p + 4], 6, -145523070)),
          (h = m(h, u, l, f, c[p + 11], 10, -1120210379)),
          (f = m(f, h, u, l, c[p + 2], 15, 718787259)),
          (l = m(l, f, h, u, c[p + 9], 21, -343485551)),
          (u = (u + y) >>> 0),
          (l = (l + b) >>> 0),
          (f = (f + w) >>> 0),
          (h = (h + S) >>> 0);
      }
      return e.endian([u, l, f, h]);
    };
  (o._ff = function (e, t, r, n, o, i, a) {
    var c = e + ((t & r) | (~t & n)) + (o >>> 0) + a;
    return ((c << i) | (c >>> (32 - i))) + t;
  }),
    (o._gg = function (e, t, r, n, o, i, a) {
      var c = e + ((t & n) | (r & ~n)) + (o >>> 0) + a;
      return ((c << i) | (c >>> (32 - i))) + t;
    }),
    (o._hh = function (e, t, r, n, o, i, a) {
      var c = e + (t ^ r ^ n) + (o >>> 0) + a;
      return ((c << i) | (c >>> (32 - i))) + t;
    }),
    (o._ii = function (e, t, r, n, o, i, a) {
      var c = e + (r ^ (t | ~n)) + (o >>> 0) + a;
      return ((c << i) | (c >>> (32 - i))) + t;
    }),
    (o._blocksize = 16),
    (o._digestsize = 16),
    (Hs.exports = function (t, r) {
      if (null == t) throw new Error("Illegal argument " + t);
      var i = e.wordsToBytes(o(t, r));
      return r && r.asBytes
        ? i
        : r && r.asString
        ? n.bytesToString(i)
        : e.bytesToHex(i);
    });
})();
var Xs = (function () {
    function e(t, r) {
      c(this, e),
        (this.extensionContext = t),
        (this.vscode = r),
        (this.isFirstTime = !1),
        (this.globalState = this.extensionContext.globalState),
        this.load();
    }
    return (
      u(e, [
        {
          key: "loadCurrentUserSettings",
          value: function () {
            var e = this.vscode.workspace.getConfiguration("workbench");
            (this.version = es.VERSION),
              (this.colorTheme = e.colorTheme),
              (this.iconTheme = e.iconTheme);
            var t = this.vscode.workspace.getConfiguration("monokaiPro");
            this.fileIconsMonochrome = t.get("fileIconsMonochrome", !1);
          },
        },
        {
          key: "get",
          value: function () {
            return {
              fileIconsMonochrome: this.fileIconsMonochrome,
              iconTheme: this.iconTheme,
              colorTheme: this.colorTheme,
            };
          },
        },
        {
          key: "load",
          value: function () {
            return (
              this.loadCurrentUserSettings(),
              (this.firstTimeStamp = this.globalState.get("firstTimeStamp", 0)),
              (this.lastTimeStamp = this.globalState.get("lastTimeStamp", 0)),
              this.firstTimeStamp ||
                ((this.isFirstTime = !0),
                (this.firstTimeStamp = this.getCurrentTimeStamp()),
                this.update("firstTimeStamp", this.firstTimeStamp)),
              this.lastTimeStamp ||
                ((this.lastTimeStamp = this.getCurrentTimeStamp()),
                this.update("lastTimeStamp", this.lastTimeStamp)),
              (this.thankYouMessageShown = this.globalState.get(
                "thankYouMessageShown",
                !1
              )),
              (this.email = this.globalState.get("email", "")),
              (this.licenseKey = this.globalState.get("licenseKey", "")),
              this.get()
            );
          },
        },
        {
          key: "updateTheme",
          value: function (e) {
            var t =
                arguments.length > 1 && void 0 !== arguments[1]
                  ? arguments[1]
                  : {},
              r = ""
                .concat(e)
                .concat(
                  this.fileIconsMonochrome ? " Monochrome " : " ",
                  "Icons"
                ),
              n = this.vscode.workspace.getConfiguration("workbench"),
              o = n.iconTheme;
            e !== t.colorTheme && n.update("colorTheme", e, !0),
              (this.isValidIconTheme(o) || this.isFirstTime) &&
                r !== t.iconTheme &&
                n.update("iconTheme", r, !0),
              this.load();
          },
        },
        {
          key: "update",
          value: function (e, t) {
            this.globalState.update(e, t);
          },
        },
        {
          key: "getCurrentTimeStamp",
          value: function () {
            return Math.floor(Date.now() / 1e3);
          },
        },
        {
          key: "isValidLicense",
          value: function () {
            var e =
                arguments.length > 0 && void 0 !== arguments[0]
                  ? arguments[0]
                  : "",
              t =
                arguments.length > 1 && void 0 !== arguments[1]
                  ? arguments[1]
                  : "";
            if (!e || !t) return !1;
            var r = Hs.exports("".concat(es.APP.UUID).concat(e)),
              n = r.match(/.{1,5}/g),
              o = n.slice(0, 5).join("-");
            return t === o;
          },
        },
        {
          key: "isValidIconTheme",
          value: function () {
            var e =
              arguments.length > 0 && void 0 !== arguments[0]
                ? arguments[0]
                : "";
            return es.APP.THEMES.includes(
              e.replace(/ (Monochrome )?Icons$/, "")
            );
          },
        },
        {
          key: "hasValidLicense",
          get: function () {
            return this.isValidLicense(this.email, this.licenseKey);
          },
        },
        {
          key: "isExpired",
          get: function () {
            return this.isUsingForAWhile
              ? this.getCurrentTimeStamp() - this.lastTimeStamp >
                  es.APP.SECONDS_TO_EXPIRE_FAST
              : this.getCurrentTimeStamp() - this.lastTimeStamp >
                  es.APP.SECONDS_TO_EXPIRE;
          },
        },
        {
          key: "isUsingForAWhile",
          get: function () {
            return (
              this.lastTimeStamp - this.firstTimeStamp > es.APP.SLOW_PERIOD
            );
          },
        },
        {
          key: "hasActiveMonokaiProColorTheme",
          get: function () {
            return es.APP.THEMES.includes(this.colorTheme);
          },
        },
        {
          key: "hasActiveMonokaiProIconTheme",
          get: function () {
            return this.isValidIconTheme(this.iconTheme);
          },
        },
      ]),
      e
    );
  })(),
  Qs = (function () {
    function e(t, r) {
      c(this, e),
        (this.vscode = t),
        (this.open = r),
        (this.state = null),
        (this.timeout = null);
    }
    return (
      u(e, [
        {
          key: "activate",
          value: function (e) {
            var t = this;
            this.state = new Xs(e, this.vscode);
            var r = {
              "monokai_pro.enter_license": function () {
                return t.enterLicense();
              },
              "monokai_pro.select_theme": function () {
                return t.selectTheme();
              },
              "monokai_pro.activate_icons": function () {
                return t.activateIcons();
              },
            };
            Object.keys(r).forEach(function (n) {
              var o = t.vscode.commands.registerCommand(n, r[n]);
              e.subscriptions.push(o);
            }),
              this.vscode.workspace.onDidChangeConfiguration(function () {
                var e = t.state.get(),
                  r = t.state.load();
                t.state.hasActiveMonokaiProColorTheme &&
                  t.state.updateTheme(r.colorTheme, e);
              }),
              (this.state.hasActiveMonokaiProColorTheme ||
                this.state.hasActiveMonokaiProIconTheme) &&
                this.checkLicense();
          },
        },
        {
          key: "enterLicense",
          value: function () {
            var e = this;
          },
        },
        {
          key: "selectTheme",
          value: function () {
            var e = this,
              t = [];
            es.APP.THEMES.forEach(function (e) {
              t.push({ label: e });
            }),
              this.vscode.window
                .showQuickPick(t, { placeHolder: "Monokai Pro theme" })
                .then(function (t) {
                  t && e.state.updateTheme(t.label);
                });
          },
        },
        {
          key: "activateIcons",
          value: function () {
            this.vscode.workspace
              .getConfiguration("workbench")
              .update("iconTheme", "Monokai Pro Icons", !0);
          },
        },
        {
          key: "checkLicense",
          value: function () {
            var e = this;
            this.state.hasValidLicense
              ? (clearTimeout(this.timeout),
                this.state.thankYouMessageShown ||
                  this.showMessageValidLicense())
              : this.state.isExpired &&
                (this.state.isUsingForAWhile && Math.random() < 0.5
                  ? (clearTimeout(this.timeout),
                    (this.timeout = setTimeout(function () {
                      e.showMessageEvaluation();
                    }, 1e3 * Math.floor(60 * (120 * Math.random() + 5)))))
                  : this.showMessageEvaluation(),
                this.state.update(
                  "lastTimeStamp",
                  this.state.getCurrentTimeStamp()
                ));
          },
        },
        {
          key: "deactivate",
          value: function () {
            clearTimeout(this.timeout);
          },
        },
        {
          key: "showMessageLicenseReset",
          value: function () {
            this.vscode.window.showInformationMessage(
              "Monokai Pro license information is reset"
            );
          },
        },
        {
          key: "showMessageValidLicense",
          value: function () {
            clearTimeout(this.timeout),
              this.vscode.window.showInformationMessage(
                "Thanks for your purchase of Monokai Pro.",
                { modal: !0 }
              ),
              this.state.update("thankYouMessageShown", !0);
          },
        },
        {
          key: "showMessageInvalidLicense",
          value: function () {
            this.vscode.window.showErrorMessage(
              "Invalid license. Please enter your email and license key exactly as in the email."
            );
          },
        },
        {
          key: "showMessageEvaluation",
          value: function () {
            var e = this,
              t = {
                theme: this.state.colorTheme,
                version: es.APP.VERSION,
                name: es.APP.NAME,
              },
              r = Object.keys(t)
                .map(function (e) {
                  return "".concat(e, "=").concat(encodeURIComponent(t[e]));
                })
                .join("&");
          },
        },
        {
          key: "unspace",
          value: function (e) {
            return e.replace(/ /g, "_");
          },
        },
      ]),
      e
    );
  })(),
  Zs = { exports: {} };
const Js = n;
let eu;
var tu = () => (
  void 0 === eu &&
    (eu =
      (function () {
        try {
          return Js.statSync("/.dockerenv"), !0;
        } catch (e) {
          return !1;
        }
      })() ||
      (function () {
        try {
          return Js.readFileSync("/proc/self/cgroup", "utf8").includes(
            "docker"
          );
        } catch (e) {
          return !1;
        }
      })()),
  eu
);
const ru = o,
  nu = n,
  ou = tu,
  iu = () => {
    if ("linux" !== process.platform) return !1;
    if (ru.release().toLowerCase().includes("microsoft")) return !ou();
    try {
      return (
        !!nu
          .readFileSync("/proc/version", "utf8")
          .toLowerCase()
          .includes("microsoft") && !ou()
      );
    } catch (e) {
      return !1;
    }
  };
process.env.__IS_WSL_TEST__ ? (Zs.exports = iu) : (Zs.exports = iu());
const au = t,
  cu = r,
  { promises: su, constants: uu } = n,
  lu = Zs.exports,
  fu = tu,
  hu = (e, t, r) => {
    const n = (r) =>
      Object.defineProperty(e, t, { value: r, enumerable: !0, writable: !0 });
    return (
      Object.defineProperty(e, t, {
        configurable: !0,
        enumerable: !0,
        get() {
          const e = r();
          return n(e), e;
        },
        set(e) {
          n(e);
        },
      }),
      e
    );
  },
  pu = au.join(__dirname, "xdg-open"),
  { platform: du, arch: gu } = process,
  vu = (() => {
    const e = "/mnt/";
    let t;
    return async function () {
      if (t) return t;
      const r = "/etc/wsl.conf";
      let n = !1;
      try {
        await su.access(r, uu.F_OK), (n = !0);
      } catch {}
      if (!n) return e;
      const o = await su.readFile(r, { encoding: "utf8" }),
        i = /(?<!#.*)root\s*=\s*(?<mountPoint>.*)/g.exec(o);
      return i
        ? ((t = i.groups.mountPoint.trim()),
          (t = t.endsWith("/") ? t : `${t}/`),
          t)
        : e;
    };
  })(),
  mu = async (e, t) => {
    let r;
    for (const n of e)
      try {
        return await t(n);
      } catch (e) {
        r = e;
      }
    throw r;
  },
  yu = async (e) => {
    if (
      ((e = {
        wait: !1,
        background: !1,
        newInstance: !1,
        allowNonzeroExitCode: !1,
        ...e,
      }),
      Array.isArray(e.app))
    )
      return mu(e.app, (t) => yu({ ...e, app: t }));
    let t,
      { name: r, arguments: n = [] } = e.app || {};
    if (((n = [...n]), Array.isArray(r)))
      return mu(r, (t) => yu({ ...e, app: { name: t, arguments: n } }));
    const o = [],
      i = {};
    if ("darwin" === du)
      (t = "open"),
        e.wait && o.push("--wait-apps"),
        e.background && o.push("--background"),
        e.newInstance && o.push("--new"),
        r && o.push("-a", r);
    else if ("win32" === du || (lu && !fu())) {
      const a = await vu();
      (t = lu
        ? `${a}c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe`
        : `${process.env.SYSTEMROOT}\\System32\\WindowsPowerShell\\v1.0\\powershell`),
        o.push(
          "-NoProfile",
          "-NonInteractive",
          "–ExecutionPolicy",
          "Bypass",
          "-EncodedCommand"
        ),
        lu || (i.windowsVerbatimArguments = !0);
      const c = ["Start"];
      e.wait && c.push("-Wait"),
        r
          ? (c.push(`"\`"${r}\`""`, "-ArgumentList"),
            e.target && n.unshift(e.target))
          : e.target && c.push(`"${e.target}"`),
        n.length > 0 &&
          ((n = n.map((e) => `"\`"${e}\`""`)), c.push(n.join(","))),
        (e.target = Buffer.from(c.join(" "), "utf16le").toString("base64"));
    } else {
      if (r) t = r;
      else {
        const e = !__dirname || "/" === __dirname;
        let r = !1;
        try {
          await su.access(pu, uu.X_OK), (r = !0);
        } catch {}
        t =
          process.versions.electron || "android" === du || e || !r
            ? "xdg-open"
            : pu;
      }
      n.length > 0 && o.push(...n),
        e.wait || ((i.stdio = "ignore"), (i.detached = !0));
    }
    e.target && o.push(e.target),
      "darwin" === du && n.length > 0 && o.push("--args", ...n);
    const a = cu.spawn(t, o, i);
    return e.wait
      ? new Promise((t, r) => {
          a.once("error", r),
            a.once("close", (n) => {
              e.allowNonzeroExitCode && n > 0
                ? r(new Error(`Exited with code ${n}`))
                : t(a);
            });
        })
      : (a.unref(), a);
  },
  bu = (e, t) => {
    if ("string" != typeof e) throw new TypeError("Expected a `target`");
    return yu({ ...t, target: e });
  };
function wu(e) {
  if ("string" == typeof e || Array.isArray(e)) return e;
  const { [gu]: t } = e;
  if (!t) throw new Error(`${gu} is not supported`);
  return t;
}
function Su({ [du]: e }, { wsl: t }) {
  if (t && lu) return wu(t);
  if (!e) throw new Error(`${du} is not supported`);
  return wu(e);
}
const Tu = {};
hu(Tu, "chrome", () =>
  Su(
    {
      darwin: "google chrome",
      win32: "chrome",
      linux: ["google-chrome", "google-chrome-stable", "chromium"],
    },
    {
      wsl: {
        ia32: "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe",
        x64: [
          "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe",
          "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe",
        ],
      },
    }
  )
),
  hu(Tu, "firefox", () =>
    Su(
      {
        darwin: "firefox",
        win32: "C:\\Program Files\\Mozilla Firefox\\firefox.exe",
        linux: "firefox",
      },
      { wsl: "/mnt/c/Program Files/Mozilla Firefox/firefox.exe" }
    )
  ),
  hu(Tu, "edge", () =>
    Su(
      {
        darwin: "microsoft edge",
        win32: "msedge",
        linux: ["microsoft-edge", "microsoft-edge-dev"],
      },
      {
        wsl: "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe",
      }
    )
  ),
  (bu.apps = Tu),
  (bu.openApp = (e, t) => {
    if ("string" != typeof e) throw new TypeError("Expected a `name`");
    const { arguments: r = [] } = t || {};
    if (null != r && !Array.isArray(r))
      throw new TypeError("Expected `appArguments` as Array type");
    return yu({ ...t, app: { name: e, arguments: r } });
  });
var xu = new Qs(a, bu);
(exports.activate = function (e) {
  xu.activate(e);
}),
  (exports.deactivate = function () {
    xu.deactivate();
  });
