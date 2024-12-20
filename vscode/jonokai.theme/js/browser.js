"use strict";
function e(e) {
  var t = Object.create(null);
  return (
    e &&
      Object.keys(e).forEach(function (n) {
        if ("default" !== n) {
          var r = Object.getOwnPropertyDescriptor(e, n);
          Object.defineProperty(
            t,
            n,
            r.get
              ? r
              : {
                  enumerable: !0,
                  get: function () {
                    return e[n];
                  },
                }
          );
        }
      }),
    (t.default = e),
    Object.freeze(t)
  );
}
var t = e(require("vscode"));
function n(e, t) {
  if (!(e instanceof t))
    throw new TypeError("Cannot call a class as a function");
}
function r(e, t) {
  for (var n = 0; n < t.length; n++) {
    var r = t[n];
    (r.enumerable = r.enumerable || !1),
      (r.configurable = !0),
      "value" in r && (r.writable = !0),
      Object.defineProperty(e, r.key, r);
  }
}
function o(e, t, n) {
  return (
    t && r(e.prototype, t),
    n && r(e, n),
    Object.defineProperty(e, "prototype", { writable: !1 }),
    e
  );
}
var i =
    "undefined" != typeof globalThis
      ? globalThis
      : "undefined" != typeof window
      ? window
      : "undefined" != typeof global
      ? global
      : "undefined" != typeof self
      ? self
      : {},
  a = function (e) {
    return e && e.Math == Math && e;
  },
  c =
    a("object" == typeof globalThis && globalThis) ||
    a("object" == typeof window && window) ||
    a("object" == typeof self && self) ||
    a("object" == typeof i && i) ||
    (function () {
      return this;
    })() ||
    Function("return this")(),
  u = { exports: {} },
  s = c,
  l = Object.defineProperty,
  f = function (e, t) {
    try {
      l(s, e, { value: t, configurable: !0, writable: !0 });
    } catch (n) {
      s[e] = t;
    }
    return t;
  },
  h = f,
  p = c["__core-js_shared__"] || h("__core-js_shared__", {}),
  d = p;
(u.exports = function (e, t) {
  return d[e] || (d[e] = void 0 !== t ? t : {});
})("versions", []).push({
  version: "3.26.1",
  mode: "global",
  copyright: "© 2014-2022 Denis Pushkarev (zloirock.ru)",
  license: "https://github.com/zloirock/core-js/blob/v3.26.1/LICENSE",
  source: "https://github.com/zloirock/core-js",
});
var v,
  g,
  m = function (e) {
    try {
      return !!e();
    } catch (e) {
      return !0;
    }
  },
  y = !m(function () {
    var e = function () {}.bind();
    return "function" != typeof e || e.hasOwnProperty("prototype");
  }),
  b = y,
  S = Function.prototype,
  T = S.call,
  w = b && S.bind.bind(T, T),
  O = b
    ? w
    : function (e) {
        return function () {
          return T.apply(e, arguments);
        };
      },
  x = function (e) {
    return null == e;
  },
  E = x,
  k = TypeError,
  M = function (e) {
    if (E(e)) throw k("Can't call method on " + e);
    return e;
  },
  P = M,
  I = Object,
  j = function (e) {
    return I(P(e));
  },
  A = j,
  C = O({}.hasOwnProperty),
  L =
    Object.hasOwn ||
    function (e, t) {
      return C(A(e), t);
    },
  _ = O,
  R = 0,
  D = Math.random(),
  F = _((1).toString),
  N = function (e) {
    return "Symbol(" + (void 0 === e ? "" : e) + ")_" + F(++R + D, 36);
  },
  V = "object" == typeof document && document.all,
  B = { all: V, IS_HTMLDDA: void 0 === V && void 0 !== V },
  U = B.all,
  $ = B.IS_HTMLDDA
    ? function (e) {
        return "function" == typeof e || e === U;
      }
    : function (e) {
        return "function" == typeof e;
      },
  H = c,
  z = $,
  W = function (e) {
    return z(e) ? e : void 0;
  },
  G = function (e, t) {
    return arguments.length < 2 ? W(H[e]) : H[e] && H[e][t];
  },
  K = c,
  Y = G("navigator", "userAgent") || "",
  X = K.process,
  q = K.Deno,
  Q = (X && X.versions) || (q && q.version),
  Z = Q && Q.v8;
Z && (g = (v = Z.split("."))[0] > 0 && v[0] < 4 ? 1 : +(v[0] + v[1])),
  !g &&
    Y &&
    (!(v = Y.match(/Edge\/(\d+)/)) || v[1] >= 74) &&
    (v = Y.match(/Chrome\/(\d+)/)) &&
    (g = +v[1]);
var J = g,
  ee = J,
  te = m,
  ne =
    !!Object.getOwnPropertySymbols &&
    !te(function () {
      var e = Symbol();
      return (
        !String(e) ||
        !(Object(e) instanceof Symbol) ||
        (!Symbol.sham && ee && ee < 41)
      );
    }),
  re = ne && !Symbol.sham && "symbol" == typeof Symbol.iterator,
  oe = c,
  ie = u.exports,
  ae = L,
  ce = N,
  ue = ne,
  se = re,
  le = ie("wks"),
  fe = oe.Symbol,
  he = fe && fe.for,
  pe = se ? fe : (fe && fe.withoutSetter) || ce,
  de = function (e) {
    if (!ae(le, e) || (!ue && "string" != typeof le[e])) {
      var t = "Symbol." + e;
      ue && ae(fe, e) ? (le[e] = fe[e]) : (le[e] = se && he ? he(t) : pe(t));
    }
    return le[e];
  },
  ve = {};
ve[de("toStringTag")] = "z";
var ge = "[object z]" === String(ve),
  me = {},
  ye = !m(function () {
    return (
      7 !=
      Object.defineProperty({}, 1, {
        get: function () {
          return 7;
        },
      })[1]
    );
  }),
  be = $,
  Se = B.all,
  Te = B.IS_HTMLDDA
    ? function (e) {
        return "object" == typeof e ? null !== e : be(e) || e === Se;
      }
    : function (e) {
        return "object" == typeof e ? null !== e : be(e);
      },
  we = Te,
  Oe = c.document,
  xe = we(Oe) && we(Oe.createElement),
  Ee = function (e) {
    return xe ? Oe.createElement(e) : {};
  },
  ke = Ee,
  Me =
    !ye &&
    !m(function () {
      return (
        7 !=
        Object.defineProperty(ke("div"), "a", {
          get: function () {
            return 7;
          },
        }).a
      );
    }),
  Pe =
    ye &&
    m(function () {
      return (
        42 !=
        Object.defineProperty(function () {}, "prototype", {
          value: 42,
          writable: !1,
        }).prototype
      );
    }),
  Ie = Te,
  je = String,
  Ae = TypeError,
  Ce = function (e) {
    if (Ie(e)) return e;
    throw Ae(je(e) + " is not an object");
  },
  Le = y,
  _e = Function.prototype.call,
  Re = Le
    ? _e.bind(_e)
    : function () {
        return _e.apply(_e, arguments);
      },
  De = O({}.isPrototypeOf),
  Fe = G,
  Ne = $,
  Ve = De,
  Be = Object,
  Ue = re
    ? function (e) {
        return "symbol" == typeof e;
      }
    : function (e) {
        var t = Fe("Symbol");
        return Ne(t) && Ve(t.prototype, Be(e));
      },
  $e = String,
  He = $,
  ze = TypeError,
  We = function (e) {
    if (He(e)) return e;
    throw ze(
      (function (e) {
        try {
          return $e(e);
        } catch (e) {
          return "Object";
        }
      })(e) + " is not a function"
    );
  },
  Ge = We,
  Ke = x,
  Ye = function (e, t) {
    var n = e[t];
    return Ke(n) ? void 0 : Ge(n);
  },
  Xe = Re,
  qe = $,
  Qe = Te,
  Ze = TypeError,
  Je = Re,
  et = Te,
  tt = Ue,
  nt = Ye,
  rt = TypeError,
  ot = de("toPrimitive"),
  it = function (e, t) {
    if (!et(e) || tt(e)) return e;
    var n,
      r = nt(e, ot);
    if (r) {
      if ((void 0 === t && (t = "default"), (n = Je(r, e, t)), !et(n) || tt(n)))
        return n;
      throw rt("Can't convert object to primitive value");
    }
    return (
      void 0 === t && (t = "number"),
      (function (e, t) {
        var n, r;
        if ("string" === t && qe((n = e.toString)) && !Qe((r = Xe(n, e))))
          return r;
        if (qe((n = e.valueOf)) && !Qe((r = Xe(n, e)))) return r;
        if ("string" !== t && qe((n = e.toString)) && !Qe((r = Xe(n, e))))
          return r;
        throw Ze("Can't convert object to primitive value");
      })(e, t)
    );
  },
  at = Ue,
  ct = function (e) {
    var t = it(e, "string");
    return at(t) ? t : t + "";
  },
  ut = ye,
  st = Me,
  lt = Pe,
  ft = Ce,
  ht = ct,
  pt = TypeError,
  dt = Object.defineProperty,
  vt = Object.getOwnPropertyDescriptor;
me.f = ut
  ? lt
    ? function (e, t, n) {
        if (
          (ft(e),
          (t = ht(t)),
          ft(n),
          "function" == typeof e &&
            "prototype" === t &&
            "value" in n &&
            "writable" in n &&
            !n.writable)
        ) {
          var r = vt(e, t);
          r &&
            r.writable &&
            ((e[t] = n.value),
            (n = {
              configurable:
                "configurable" in n ? n.configurable : r.configurable,
              enumerable: "enumerable" in n ? n.enumerable : r.enumerable,
              writable: !1,
            }));
        }
        return dt(e, t, n);
      }
    : dt
  : function (e, t, n) {
      if ((ft(e), (t = ht(t)), ft(n), st))
        try {
          return dt(e, t, n);
        } catch (e) {}
      if ("get" in n || "set" in n) throw pt("Accessors not supported");
      return "value" in n && (e[t] = n.value), e;
    };
var gt = { exports: {} },
  mt = ye,
  yt = L,
  bt = Function.prototype,
  St = mt && Object.getOwnPropertyDescriptor,
  Tt = yt(bt, "name"),
  wt = {
    EXISTS: Tt,
    PROPER: Tt && "something" === function () {}.name,
    CONFIGURABLE: Tt && (!mt || (mt && St(bt, "name").configurable)),
  },
  Ot = $,
  xt = p,
  Et = O(Function.toString);
Ot(xt.inspectSource) ||
  (xt.inspectSource = function (e) {
    return Et(e);
  });
var kt,
  Mt,
  Pt,
  It = xt.inspectSource,
  jt = $,
  At = c.WeakMap,
  Ct = jt(At) && /native code/.test(String(At)),
  Lt = function (e, t) {
    return {
      enumerable: !(1 & e),
      configurable: !(2 & e),
      writable: !(4 & e),
      value: t,
    };
  },
  _t = me,
  Rt = Lt,
  Dt = ye
    ? function (e, t, n) {
        return _t.f(e, t, Rt(1, n));
      }
    : function (e, t, n) {
        return (e[t] = n), e;
      },
  Ft = u.exports,
  Nt = N,
  Vt = Ft("keys"),
  Bt = function (e) {
    return Vt[e] || (Vt[e] = Nt(e));
  },
  Ut = {},
  $t = Ct,
  Ht = c,
  zt = Te,
  Wt = Dt,
  Gt = L,
  Kt = p,
  Yt = Bt,
  Xt = Ut,
  qt = Ht.TypeError,
  Qt = Ht.WeakMap;
if ($t || Kt.state) {
  var Zt = Kt.state || (Kt.state = new Qt());
  (Zt.get = Zt.get),
    (Zt.has = Zt.has),
    (Zt.set = Zt.set),
    (kt = function (e, t) {
      if (Zt.has(e)) throw qt("Object already initialized");
      return (t.facade = e), Zt.set(e, t), t;
    }),
    (Mt = function (e) {
      return Zt.get(e) || {};
    }),
    (Pt = function (e) {
      return Zt.has(e);
    });
} else {
  var Jt = Yt("state");
  (Xt[Jt] = !0),
    (kt = function (e, t) {
      if (Gt(e, Jt)) throw qt("Object already initialized");
      return (t.facade = e), Wt(e, Jt, t), t;
    }),
    (Mt = function (e) {
      return Gt(e, Jt) ? e[Jt] : {};
    }),
    (Pt = function (e) {
      return Gt(e, Jt);
    });
}
var en = {
    set: kt,
    get: Mt,
    has: Pt,
    enforce: function (e) {
      return Pt(e) ? Mt(e) : kt(e, {});
    },
    getterFor: function (e) {
      return function (t) {
        var n;
        if (!zt(t) || (n = Mt(t)).type !== e)
          throw qt("Incompatible receiver, " + e + " required");
        return n;
      };
    },
  },
  tn = m,
  nn = $,
  rn = L,
  on = ye,
  an = wt.CONFIGURABLE,
  cn = It,
  un = en.enforce,
  sn = en.get,
  ln = Object.defineProperty,
  fn =
    on &&
    !tn(function () {
      return 8 !== ln(function () {}, "length", { value: 8 }).length;
    }),
  hn = String(String).split("String"),
  pn = (gt.exports = function (e, t, n) {
    "Symbol(" === String(t).slice(0, 7) &&
      (t = "[" + String(t).replace(/^Symbol\(([^)]*)\)/, "$1") + "]"),
      n && n.getter && (t = "get " + t),
      n && n.setter && (t = "set " + t),
      (!rn(e, "name") || (an && e.name !== t)) &&
        (on ? ln(e, "name", { value: t, configurable: !0 }) : (e.name = t)),
      fn &&
        n &&
        rn(n, "arity") &&
        e.length !== n.arity &&
        ln(e, "length", { value: n.arity });
    try {
      n && rn(n, "constructor") && n.constructor
        ? on && ln(e, "prototype", { writable: !1 })
        : e.prototype && (e.prototype = void 0);
    } catch (e) {}
    var r = un(e);
    return (
      rn(r, "source") || (r.source = hn.join("string" == typeof t ? t : "")), e
    );
  });
Function.prototype.toString = pn(function () {
  return (nn(this) && sn(this).source) || cn(this);
}, "toString");
var dn = $,
  vn = me,
  gn = gt.exports,
  mn = f,
  yn = function (e, t, n, r) {
    r || (r = {});
    var o = r.enumerable,
      i = void 0 !== r.name ? r.name : t;
    if ((dn(n) && gn(n, i, r), r.global)) o ? (e[t] = n) : mn(t, n);
    else {
      try {
        r.unsafe ? e[t] && (o = !0) : delete e[t];
      } catch (e) {}
      o
        ? (e[t] = n)
        : vn.f(e, t, {
            value: n,
            enumerable: !1,
            configurable: !r.nonConfigurable,
            writable: !r.nonWritable,
          });
    }
    return e;
  },
  bn = O,
  Sn = bn({}.toString),
  Tn = bn("".slice),
  wn = function (e) {
    return Tn(Sn(e), 8, -1);
  },
  On = ge,
  xn = $,
  En = wn,
  kn = de("toStringTag"),
  Mn = Object,
  Pn =
    "Arguments" ==
    En(
      (function () {
        return arguments;
      })()
    ),
  In = On
    ? En
    : function (e) {
        var t, n, r;
        return void 0 === e
          ? "Undefined"
          : null === e
          ? "Null"
          : "string" ==
            typeof (n = (function (e, t) {
              try {
                return e[t];
              } catch (e) {}
            })((t = Mn(e)), kn))
          ? n
          : Pn
          ? En(t)
          : "Object" == (r = En(t)) && xn(t.callee)
          ? "Arguments"
          : r;
      },
  jn = In,
  An = ge
    ? {}.toString
    : function () {
        return "[object " + jn(this) + "]";
      };
ge || yn(Object.prototype, "toString", An, { unsafe: !0 });
var Cn = Ee("span").classList,
  Ln = Cn && Cn.constructor && Cn.constructor.prototype,
  _n = Ln === Object.prototype ? void 0 : Ln,
  Rn = wn,
  Dn = O,
  Fn = function (e) {
    if ("Function" === Rn(e)) return Dn(e);
  },
  Nn = We,
  Vn = y,
  Bn = Fn(Fn.bind),
  Un = m,
  $n = wn,
  Hn = Object,
  zn = O("".split),
  Wn = Un(function () {
    return !Hn("z").propertyIsEnumerable(0);
  })
    ? function (e) {
        return "String" == $n(e) ? zn(e, "") : Hn(e);
      }
    : Hn,
  Gn = Math.ceil,
  Kn = Math.floor,
  Yn =
    Math.trunc ||
    function (e) {
      var t = +e;
      return (t > 0 ? Kn : Gn)(t);
    },
  Xn = function (e) {
    var t = +e;
    return t != t || 0 === t ? 0 : Yn(t);
  },
  qn = Xn,
  Qn = Math.min,
  Zn = function (e) {
    return e > 0 ? Qn(qn(e), 9007199254740991) : 0;
  },
  Jn = Zn,
  er = function (e) {
    return Jn(e.length);
  },
  tr = wn,
  nr =
    Array.isArray ||
    function (e) {
      return "Array" == tr(e);
    },
  rr = O,
  or = m,
  ir = $,
  ar = In,
  cr = It,
  ur = function () {},
  sr = [],
  lr = G("Reflect", "construct"),
  fr = /^\s*(?:class|function)\b/,
  hr = rr(fr.exec),
  pr = !fr.exec(ur),
  dr = function (e) {
    if (!ir(e)) return !1;
    try {
      return lr(ur, sr, e), !0;
    } catch (e) {
      return !1;
    }
  },
  vr = function (e) {
    if (!ir(e)) return !1;
    switch (ar(e)) {
      case "AsyncFunction":
      case "GeneratorFunction":
      case "AsyncGeneratorFunction":
        return !1;
    }
    try {
      return pr || !!hr(fr, cr(e));
    } catch (e) {
      return !0;
    }
  };
vr.sham = !0;
var gr =
    !lr ||
    or(function () {
      var e;
      return (
        dr(dr.call) ||
        !dr(Object) ||
        !dr(function () {
          e = !0;
        }) ||
        e
      );
    })
      ? vr
      : dr,
  mr = nr,
  yr = gr,
  br = Te,
  Sr = de("species"),
  Tr = Array,
  wr = function (e, t) {
    return new ((function (e) {
      var t;
      return (
        mr(e) &&
          ((t = e.constructor),
          ((yr(t) && (t === Tr || mr(t.prototype))) ||
            (br(t) && null === (t = t[Sr]))) &&
            (t = void 0)),
        void 0 === t ? Tr : t
      );
    })(e))(0 === t ? 0 : t);
  },
  Or = Wn,
  xr = j,
  Er = er,
  kr = wr,
  Mr = O([].push),
  Pr = function (e) {
    var t = 1 == e,
      n = 2 == e,
      r = 3 == e,
      o = 4 == e,
      i = 6 == e,
      a = 7 == e,
      c = 5 == e || i;
    return function (u, s, l, f) {
      for (
        var h,
          p,
          d = xr(u),
          v = Or(d),
          g = (function (e, t) {
            return (
              Nn(e),
              void 0 === t
                ? e
                : Vn
                ? Bn(e, t)
                : function () {
                    return e.apply(t, arguments);
                  }
            );
          })(s, l),
          m = Er(v),
          y = 0,
          b = f || kr,
          S = t ? b(u, m) : n || a ? b(u, 0) : void 0;
        m > y;
        y++
      )
        if ((c || y in v) && ((p = g((h = v[y]), y, d)), e))
          if (t) S[y] = p;
          else if (p)
            switch (e) {
              case 3:
                return !0;
              case 5:
                return h;
              case 6:
                return y;
              case 2:
                Mr(S, h);
            }
          else
            switch (e) {
              case 4:
                return !1;
              case 7:
                Mr(S, h);
            }
      return i ? -1 : r || o ? o : S;
    };
  },
  Ir = {
    forEach: Pr(0),
    map: Pr(1),
    filter: Pr(2),
    some: Pr(3),
    every: Pr(4),
    find: Pr(5),
    findIndex: Pr(6),
    filterReject: Pr(7),
  },
  jr = m,
  Ar = function (e, t) {
    var n = [][e];
    return (
      !!n &&
      jr(function () {
        n.call(
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
  Cr = Ir.forEach,
  Lr = c,
  _r = {
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
  Rr = _n,
  Dr = Ar("forEach")
    ? [].forEach
    : function (e) {
        return Cr(this, e, arguments.length > 1 ? arguments[1] : void 0);
      },
  Fr = Dt,
  Nr = function (e) {
    if (e && e.forEach !== Dr)
      try {
        Fr(e, "forEach", Dr);
      } catch (t) {
        e.forEach = Dr;
      }
  };
for (var Vr in _r) _r[Vr] && Nr(Lr[Vr] && Lr[Vr].prototype);
Nr(Rr);
var Br = {},
  Ur = {},
  $r = {}.propertyIsEnumerable,
  Hr = Object.getOwnPropertyDescriptor,
  zr = Hr && !$r.call({ 1: 2 }, 1);
Ur.f = zr
  ? function (e) {
      var t = Hr(this, e);
      return !!t && t.enumerable;
    }
  : $r;
var Wr = Wn,
  Gr = M,
  Kr = function (e) {
    return Wr(Gr(e));
  },
  Yr = ye,
  Xr = Re,
  qr = Ur,
  Qr = Lt,
  Zr = Kr,
  Jr = ct,
  eo = L,
  to = Me,
  no = Object.getOwnPropertyDescriptor;
Br.f = Yr
  ? no
  : function (e, t) {
      if (((e = Zr(e)), (t = Jr(t)), to))
        try {
          return no(e, t);
        } catch (e) {}
      if (eo(e, t)) return Qr(!Xr(qr.f, e, t), e[t]);
    };
var ro = {},
  oo = Xn,
  io = Math.max,
  ao = Math.min,
  co = function (e, t) {
    var n = oo(e);
    return n < 0 ? io(n + t, 0) : ao(n, t);
  },
  uo = Kr,
  so = co,
  lo = er,
  fo = function (e) {
    return function (t, n, r) {
      var o,
        i = uo(t),
        a = lo(i),
        c = so(r, a);
      if (e && n != n) {
        for (; a > c; ) if ((o = i[c++]) != o) return !0;
      } else
        for (; a > c; c++) if ((e || c in i) && i[c] === n) return e || c || 0;
      return !e && -1;
    };
  },
  ho = { includes: fo(!0), indexOf: fo(!1) },
  po = L,
  vo = Kr,
  go = ho.indexOf,
  mo = Ut,
  yo = O([].push),
  bo = function (e, t) {
    var n,
      r = vo(e),
      o = 0,
      i = [];
    for (n in r) !po(mo, n) && po(r, n) && yo(i, n);
    for (; t.length > o; ) po(r, (n = t[o++])) && (~go(i, n) || yo(i, n));
    return i;
  },
  So = [
    "constructor",
    "hasOwnProperty",
    "isPrototypeOf",
    "propertyIsEnumerable",
    "toLocaleString",
    "toString",
    "valueOf",
  ],
  To = bo,
  wo = So.concat("length", "prototype");
ro.f =
  Object.getOwnPropertyNames ||
  function (e) {
    return To(e, wo);
  };
var Oo = {};
Oo.f = Object.getOwnPropertySymbols;
var xo = G,
  Eo = ro,
  ko = Oo,
  Mo = Ce,
  Po = O([].concat),
  Io =
    xo("Reflect", "ownKeys") ||
    function (e) {
      var t = Eo.f(Mo(e)),
        n = ko.f;
      return n ? Po(t, n(e)) : t;
    },
  jo = L,
  Ao = Io,
  Co = Br,
  Lo = me,
  _o = m,
  Ro = $,
  Do = /#|\.prototype\./,
  Fo = function (e, t) {
    var n = Vo[No(e)];
    return n == Uo || (n != Bo && (Ro(t) ? _o(t) : !!t));
  },
  No = (Fo.normalize = function (e) {
    return String(e).replace(Do, ".").toLowerCase();
  }),
  Vo = (Fo.data = {}),
  Bo = (Fo.NATIVE = "N"),
  Uo = (Fo.POLYFILL = "P"),
  $o = Fo,
  Ho = c,
  zo = Br.f,
  Wo = Dt,
  Go = yn,
  Ko = f,
  Yo = function (e, t, n) {
    for (var r = Ao(t), o = Lo.f, i = Co.f, a = 0; a < r.length; a++) {
      var c = r[a];
      jo(e, c) || (n && jo(n, c)) || o(e, c, i(t, c));
    }
  },
  Xo = $o,
  qo = function (e, t) {
    var n,
      r,
      o,
      i,
      a,
      c = e.target,
      u = e.global,
      s = e.stat;
    if ((n = u ? Ho : s ? Ho[c] || Ko(c, {}) : (Ho[c] || {}).prototype))
      for (r in t) {
        if (
          ((i = t[r]),
          (o = e.dontCallGetSet ? (a = zo(n, r)) && a.value : n[r]),
          !Xo(u ? r : c + (s ? "." : "#") + r, e.forced) && void 0 !== o)
        ) {
          if (typeof i == typeof o) continue;
          Yo(i, o);
        }
        (e.sham || (o && o.sham)) && Wo(i, "sham", !0), Go(n, r, i, e);
      }
  },
  Qo = bo,
  Zo = So,
  Jo =
    Object.keys ||
    function (e) {
      return Qo(e, Zo);
    },
  ei = j,
  ti = Jo;
qo(
  {
    target: "Object",
    stat: !0,
    forced: m(function () {
      ti(1);
    }),
  },
  {
    keys: function (e) {
      return ti(ei(e));
    },
  }
);
var ni = In,
  ri = String,
  oi = function (e) {
    if ("Symbol" === ni(e))
      throw TypeError("Cannot convert a Symbol value to a string");
    return ri(e);
  },
  ii = Ce,
  ai = m,
  ci = c.RegExp,
  ui = ai(function () {
    var e = ci("a", "y");
    return (e.lastIndex = 2), null != e.exec("abcd");
  }),
  si =
    ui ||
    ai(function () {
      return !ci("a", "y").sticky;
    }),
  li = {
    BROKEN_CARET:
      ui ||
      ai(function () {
        var e = ci("^r", "gy");
        return (e.lastIndex = 2), null != e.exec("str");
      }),
    MISSED_STICKY: si,
    UNSUPPORTED_Y: ui,
  },
  fi = {},
  hi = ye,
  pi = Pe,
  di = me,
  vi = Ce,
  gi = Kr,
  mi = Jo;
fi.f =
  hi && !pi
    ? Object.defineProperties
    : function (e, t) {
        vi(e);
        for (var n, r = gi(t), o = mi(t), i = o.length, a = 0; i > a; )
          di.f(e, (n = o[a++]), r[n]);
        return e;
      };
var yi,
  bi = G("document", "documentElement"),
  Si = Ce,
  Ti = fi,
  wi = So,
  Oi = Ut,
  xi = bi,
  Ei = Ee,
  ki = Bt("IE_PROTO"),
  Mi = function () {},
  Pi = function (e) {
    return "<script>" + e + "</script>";
  },
  Ii = function (e) {
    e.write(Pi("")), e.close();
    var t = e.parentWindow.Object;
    return (e = null), t;
  },
  ji = function () {
    try {
      yi = new ActiveXObject("htmlfile");
    } catch (e) {}
    var e, t;
    ji =
      "undefined" != typeof document
        ? document.domain && yi
          ? Ii(yi)
          : (((t = Ei("iframe")).style.display = "none"),
            xi.appendChild(t),
            (t.src = String("javascript:")),
            (e = t.contentWindow.document).open(),
            e.write(Pi("document.F=Object")),
            e.close(),
            e.F)
        : Ii(yi);
    for (var n = wi.length; n--; ) delete ji.prototype[wi[n]];
    return ji();
  };
Oi[ki] = !0;
var Ai,
  Ci,
  Li =
    Object.create ||
    function (e, t) {
      var n;
      return (
        null !== e
          ? ((Mi.prototype = Si(e)),
            (n = new Mi()),
            (Mi.prototype = null),
            (n[ki] = e))
          : (n = ji()),
        void 0 === t ? n : Ti.f(n, t)
      );
    },
  _i = m,
  Ri = c.RegExp,
  Di = _i(function () {
    var e = Ri(".", "s");
    return !(e.dotAll && e.exec("\n") && "s" === e.flags);
  }),
  Fi = m,
  Ni = c.RegExp,
  Vi = Fi(function () {
    var e = Ni("(?<a>b)", "g");
    return "b" !== e.exec("b").groups.a || "bc" !== "b".replace(e, "$<a>c");
  }),
  Bi = Re,
  Ui = O,
  $i = oi,
  Hi = function () {
    var e = ii(this),
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
  zi = li,
  Wi = u.exports,
  Gi = Li,
  Ki = en.get,
  Yi = Di,
  Xi = Vi,
  qi = Wi("native-string-replace", String.prototype.replace),
  Qi = RegExp.prototype.exec,
  Zi = Qi,
  Ji = Ui("".charAt),
  ea = Ui("".indexOf),
  ta = Ui("".replace),
  na = Ui("".slice),
  ra =
    ((Ci = /b*/g),
    Bi(Qi, (Ai = /a/), "a"),
    Bi(Qi, Ci, "a"),
    0 !== Ai.lastIndex || 0 !== Ci.lastIndex),
  oa = zi.BROKEN_CARET,
  ia = void 0 !== /()??/.exec("")[1];
(ra || ia || oa || Yi || Xi) &&
  (Zi = function (e) {
    var t,
      n,
      r,
      o,
      i,
      a,
      c,
      u = this,
      s = Ki(u),
      l = $i(e),
      f = s.raw;
    if (f)
      return (
        (f.lastIndex = u.lastIndex),
        (t = Bi(Zi, f, l)),
        (u.lastIndex = f.lastIndex),
        t
      );
    var h = s.groups,
      p = oa && u.sticky,
      d = Bi(Hi, u),
      v = u.source,
      g = 0,
      m = l;
    if (
      (p &&
        ((d = ta(d, "y", "")),
        -1 === ea(d, "g") && (d += "g"),
        (m = na(l, u.lastIndex)),
        u.lastIndex > 0 &&
          (!u.multiline || (u.multiline && "\n" !== Ji(l, u.lastIndex - 1))) &&
          ((v = "(?: " + v + ")"), (m = " " + m), g++),
        (n = new RegExp("^(?:" + v + ")", d))),
      ia && (n = new RegExp("^" + v + "$(?!\\s)", d)),
      ra && (r = u.lastIndex),
      (o = Bi(Qi, p ? n : u, m)),
      p
        ? o
          ? ((o.input = na(o.input, g)),
            (o[0] = na(o[0], g)),
            (o.index = u.lastIndex),
            (u.lastIndex += o[0].length))
          : (u.lastIndex = 0)
        : ra && o && (u.lastIndex = u.global ? o.index + o[0].length : r),
      ia &&
        o &&
        o.length > 1 &&
        Bi(qi, o[0], n, function () {
          for (i = 1; i < arguments.length - 2; i++)
            void 0 === arguments[i] && (o[i] = void 0);
        }),
      o && h)
    )
      for (o.groups = a = Gi(null), i = 0; i < h.length; i++)
        a[(c = h[i])[0]] = o[c[1]];
    return o;
  });
var aa = Zi;
qo({ target: "RegExp", proto: !0, forced: /./.exec !== aa }, { exec: aa });
var ca = y,
  ua = Function.prototype,
  sa = ua.apply,
  la = ua.call,
  fa =
    ("object" == typeof Reflect && Reflect.apply) ||
    (ca
      ? la.bind(sa)
      : function () {
          return la.apply(sa, arguments);
        }),
  ha = Fn,
  pa = yn,
  da = aa,
  va = m,
  ga = de,
  ma = Dt,
  ya = ga("species"),
  ba = RegExp.prototype,
  Sa = function (e, t, n, r) {
    var o = ga(e),
      i = !va(function () {
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
        !va(function () {
          var t = !1,
            n = /a/;
          return (
            "split" === e &&
              (((n = {}).constructor = {}),
              (n.constructor[ya] = function () {
                return n;
              }),
              (n.flags = ""),
              (n[o] = /./[o])),
            (n.exec = function () {
              return (t = !0), null;
            }),
            n[o](""),
            !t
          );
        });
    if (!i || !a || n) {
      var c = ha(/./[o]),
        u = t(o, ""[e], function (e, t, n, r, o) {
          var a = ha(e),
            u = t.exec;
          return u === da || u === ba.exec
            ? i && !o
              ? { done: !0, value: c(t, n, r) }
              : { done: !0, value: a(n, t, r) }
            : { done: !1 };
        });
      pa(String.prototype, e, u[0]), pa(ba, o, u[1]);
    }
    r && ma(ba[o], "sham", !0);
  },
  Ta = O,
  wa = Xn,
  Oa = oi,
  xa = M,
  Ea = Ta("".charAt),
  ka = Ta("".charCodeAt),
  Ma = Ta("".slice),
  Pa = function (e) {
    return function (t, n) {
      var r,
        o,
        i = Oa(xa(t)),
        a = wa(n),
        c = i.length;
      return a < 0 || a >= c
        ? e
          ? ""
          : void 0
        : (r = ka(i, a)) < 55296 ||
          r > 56319 ||
          a + 1 === c ||
          (o = ka(i, a + 1)) < 56320 ||
          o > 57343
        ? e
          ? Ea(i, a)
          : r
        : e
        ? Ma(i, a, a + 2)
        : o - 56320 + ((r - 55296) << 10) + 65536;
    };
  },
  Ia = (Pa(!1), Pa(!0)),
  ja = function (e, t, n) {
    return t + (n ? Ia(e, t).length : 1);
  },
  Aa = O,
  Ca = j,
  La = Math.floor,
  _a = Aa("".charAt),
  Ra = Aa("".replace),
  Da = Aa("".slice),
  Fa = /\$([$&'`]|\d{1,2}|<[^>]*>)/g,
  Na = /\$([$&'`]|\d{1,2})/g,
  Va = Re,
  Ba = Ce,
  Ua = $,
  $a = wn,
  Ha = aa,
  za = TypeError,
  Wa = function (e, t) {
    var n = e.exec;
    if (Ua(n)) {
      var r = Va(n, e, t);
      return null !== r && Ba(r), r;
    }
    if ("RegExp" === $a(e)) return Va(Ha, e, t);
    throw za("RegExp#exec called on incompatible receiver");
  },
  Ga = fa,
  Ka = Re,
  Ya = O,
  Xa = Sa,
  qa = m,
  Qa = Ce,
  Za = $,
  Ja = x,
  ec = Xn,
  tc = Zn,
  nc = oi,
  rc = M,
  oc = ja,
  ic = Ye,
  ac = function (e, t, n, r, o, i) {
    var a = n + e.length,
      c = r.length,
      u = Na;
    return (
      void 0 !== o && ((o = Ca(o)), (u = Fa)),
      Ra(i, u, function (i, u) {
        var s;
        switch (_a(u, 0)) {
          case "$":
            return "$";
          case "&":
            return e;
          case "`":
            return Da(t, 0, n);
          case "'":
            return Da(t, a);
          case "<":
            s = o[Da(u, 1, -1)];
            break;
          default:
            var l = +u;
            if (0 === l) return i;
            if (l > c) {
              var f = La(l / 10);
              return 0 === f
                ? i
                : f <= c
                ? void 0 === r[f - 1]
                  ? _a(u, 1)
                  : r[f - 1] + _a(u, 1)
                : i;
            }
            s = r[l - 1];
        }
        return void 0 === s ? "" : s;
      })
    );
  },
  cc = Wa,
  uc = de("replace"),
  sc = Math.max,
  lc = Math.min,
  fc = Ya([].concat),
  hc = Ya([].push),
  pc = Ya("".indexOf),
  dc = Ya("".slice),
  vc = "$0" === "a".replace(/./, "$0"),
  gc = !!/./[uc] && "" === /./[uc]("a", "$0");
Xa(
  "replace",
  function (e, t, n) {
    var r = gc ? "$" : "$0";
    return [
      function (e, n) {
        var r = rc(this),
          o = Ja(e) ? void 0 : ic(e, uc);
        return o ? Ka(o, e, r, n) : Ka(t, nc(r), e, n);
      },
      function (e, o) {
        var i = Qa(this),
          a = nc(e);
        if ("string" == typeof o && -1 === pc(o, r) && -1 === pc(o, "$<")) {
          var c = n(t, i, a, o);
          if (c.done) return c.value;
        }
        var u = Za(o);
        u || (o = nc(o));
        var s = i.global;
        if (s) {
          var l = i.unicode;
          i.lastIndex = 0;
        }
        for (var f = []; ; ) {
          var h = cc(i, a);
          if (null === h) break;
          if ((hc(f, h), !s)) break;
          "" === nc(h[0]) && (i.lastIndex = oc(a, tc(i.lastIndex), l));
        }
        for (var p, d = "", v = 0, g = 0; g < f.length; g++) {
          for (
            var m = nc((h = f[g])[0]),
              y = sc(lc(ec(h.index), a.length), 0),
              b = [],
              S = 1;
            S < h.length;
            S++
          )
            hc(b, void 0 === (p = h[S]) ? p : String(p));
          var T = h.groups;
          if (u) {
            var w = fc([m], b, y, a);
            void 0 !== T && hc(w, T);
            var O = nc(Ga(o, void 0, w));
          } else O = ac(m, a, y, b, T, o);
          y >= v && ((d += dc(a, v, y) + O), (v = y + m.length));
        }
        return d + dc(a, v);
      },
    ];
  },
  !!qa(function () {
    var e = /./;
    return (
      (e.exec = function () {
        var e = [];
        return (e.groups = { a: "7" }), e;
      }),
      "7" !== "".replace(e, "$<a>")
    );
  }) ||
    !vc ||
    gc
);
var mc = qo,
  yc = Wn,
  bc = Kr,
  Sc = Ar,
  Tc = O([].join),
  wc = yc != Object,
  Oc = Sc("join", ",");
mc(
  { target: "Array", proto: !0, forced: wc || !Oc },
  {
    join: function (e) {
      return Tc(bc(this), void 0 === e ? "," : e);
    },
  }
);
var xc = m,
  Ec = J,
  kc = de("species"),
  Mc = function (e) {
    return (
      Ec >= 51 ||
      !xc(function () {
        var t = [];
        return (
          ((t.constructor = {})[kc] = function () {
            return { foo: 1 };
          }),
          1 !== t[e](Boolean).foo
        );
      })
    );
  },
  Pc = Ir.map;
qo(
  { target: "Array", proto: !0, forced: !Mc("map") },
  {
    map: function (e) {
      return Pc(this, e, arguments.length > 1 ? arguments[1] : void 0);
    },
  }
);
var Ic = TypeError,
  jc = ct,
  Ac = me,
  Cc = Lt,
  Lc = function (e, t, n) {
    var r = jc(t);
    r in e ? Ac.f(e, r, Cc(0, n)) : (e[r] = n);
  },
  _c = qo,
  Rc = m,
  Dc = nr,
  Fc = Te,
  Nc = j,
  Vc = er,
  Bc = function (e) {
    if (e > 9007199254740991) throw Ic("Maximum allowed index exceeded");
    return e;
  },
  Uc = Lc,
  $c = wr,
  Hc = Mc,
  zc = J,
  Wc = de("isConcatSpreadable"),
  Gc =
    zc >= 51 ||
    !Rc(function () {
      var e = [];
      return (e[Wc] = !1), e.concat()[0] !== e;
    }),
  Kc = Hc("concat"),
  Yc = function (e) {
    if (!Fc(e)) return !1;
    var t = e[Wc];
    return void 0 !== t ? !!t : Dc(e);
  };
_c(
  { target: "Array", proto: !0, arity: 1, forced: !Gc || !Kc },
  {
    concat: function (e) {
      var t,
        n,
        r,
        o,
        i,
        a = Nc(this),
        c = $c(a, 0),
        u = 0;
      for (t = -1, r = arguments.length; t < r; t++)
        if (Yc((i = -1 === t ? a : arguments[t])))
          for (o = Vc(i), Bc(u + o), n = 0; n < o; n++, u++)
            n in i && Uc(c, u, i[n]);
        else Bc(u + 1), Uc(c, u++, i);
      return (c.length = u), c;
    },
  }
);
var Xc = {
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
  qc = Re,
  Qc = Ce,
  Zc = x,
  Jc = Zn,
  eu = oi,
  tu = M,
  nu = Ye,
  ru = ja,
  ou = Wa;
Sa("match", function (e, t, n) {
  return [
    function (t) {
      var n = tu(this),
        r = Zc(t) ? void 0 : nu(t, e);
      return r ? qc(r, t, n) : new RegExp(t)[e](eu(n));
    },
    function (e) {
      var r = Qc(this),
        o = eu(e),
        i = n(t, r, o);
      if (i.done) return i.value;
      if (!r.global) return ou(r, o);
      var a = r.unicode;
      r.lastIndex = 0;
      for (var c, u = [], s = 0; null !== (c = ou(r, o)); ) {
        var l = eu(c[0]);
        (u[s] = l), "" === l && (r.lastIndex = ru(o, Jc(r.lastIndex), a)), s++;
      }
      return 0 === s ? null : u;
    },
  ];
});
var iu = O([].slice),
  au = qo,
  cu = nr,
  uu = gr,
  su = Te,
  lu = co,
  fu = er,
  hu = Kr,
  pu = Lc,
  du = de,
  vu = iu,
  gu = Mc("slice"),
  mu = du("species"),
  yu = Array,
  bu = Math.max;
au(
  { target: "Array", proto: !0, forced: !gu },
  {
    slice: function (e, t) {
      var n,
        r,
        o,
        i = hu(this),
        a = fu(i),
        c = lu(e, a),
        u = lu(void 0 === t ? a : t, a);
      if (
        cu(i) &&
        ((n = i.constructor),
        ((uu(n) && (n === yu || cu(n.prototype))) ||
          (su(n) && null === (n = n[mu]))) &&
          (n = void 0),
        n === yu || void 0 === n)
      )
        return vu(i, c, u);
      for (
        r = new (void 0 === n ? yu : n)(bu(u - c, 0)), o = 0;
        c < u;
        c++, o++
      )
        c in i && pu(r, o, i[c]);
      return (r.length = o), r;
    },
  }
);
var Su = de,
  Tu = Li,
  wu = me.f,
  Ou = Su("unscopables"),
  xu = Array.prototype;
null == xu[Ou] && wu(xu, Ou, { configurable: !0, value: Tu(null) });
var Eu,
  ku = ho.includes;
qo(
  {
    target: "Array",
    proto: !0,
    forced: m(function () {
      return !Array(1).includes();
    }),
  },
  {
    includes: function (e) {
      return ku(this, e, arguments.length > 1 ? arguments[1] : void 0);
    },
  }
),
  (Eu = "includes"),
  (xu[Ou][Eu] = !0);
var Mu = Te,
  Pu = wn,
  Iu = de("match"),
  ju = TypeError,
  Au = de("match"),
  Cu = qo,
  Lu = function (e) {
    if (
      (function (e) {
        var t;
        return Mu(e) && (void 0 !== (t = e[Iu]) ? !!t : "RegExp" == Pu(e));
      })(e)
    )
      throw ju("The method doesn't accept regular expressions");
    return e;
  },
  _u = M,
  Ru = oi,
  Du = O("".indexOf);
Cu(
  {
    target: "String",
    proto: !0,
    forced: !(function (e) {
      var t = /./;
      try {
        "/./"[e](t);
      } catch (n) {
        try {
          return (t[Au] = !1), "/./"[e](t);
        } catch (e) {}
      }
      return !1;
    })("includes"),
  },
  {
    includes: function (e) {
      return !!~Du(
        Ru(_u(this)),
        Ru(Lu(e)),
        arguments.length > 1 ? arguments[1] : void 0
      );
    },
  }
);
var Fu,
  Nu,
  Vu = { exports: {} },
  Bu = { exports: {} };
(Fu = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"),
  (Nu = {
    rotl: function (e, t) {
      return (e << t) | (e >>> (32 - t));
    },
    rotr: function (e, t) {
      return (e << (32 - t)) | (e >>> t);
    },
    endian: function (e) {
      if (e.constructor == Number)
        return (16711935 & Nu.rotl(e, 8)) | (4278255360 & Nu.rotl(e, 24));
      for (var t = 0; t < e.length; t++) e[t] = Nu.endian(e[t]);
      return e;
    },
    randomBytes: function (e) {
      for (var t = []; e > 0; e--) t.push(Math.floor(256 * Math.random()));
      return t;
    },
    bytesToWords: function (e) {
      for (var t = [], n = 0, r = 0; n < e.length; n++, r += 8)
        t[r >>> 5] |= e[n] << (24 - (r % 32));
      return t;
    },
    wordsToBytes: function (e) {
      for (var t = [], n = 0; n < 32 * e.length; n += 8)
        t.push((e[n >>> 5] >>> (24 - (n % 32))) & 255);
      return t;
    },
    bytesToHex: function (e) {
      for (var t = [], n = 0; n < e.length; n++)
        t.push((e[n] >>> 4).toString(16)), t.push((15 & e[n]).toString(16));
      return t.join("");
    },
    hexToBytes: function (e) {
      for (var t = [], n = 0; n < e.length; n += 2)
        t.push(parseInt(e.substr(n, 2), 16));
      return t;
    },
    bytesToBase64: function (e) {
      for (var t = [], n = 0; n < e.length; n += 3)
        for (
          var r = (e[n] << 16) | (e[n + 1] << 8) | e[n + 2], o = 0;
          o < 4;
          o++
        )
          8 * n + 6 * o <= 8 * e.length
            ? t.push(Fu.charAt((r >>> (6 * (3 - o))) & 63))
            : t.push("=");
      return t.join("");
    },
    base64ToBytes: function (e) {
      e = e.replace(/[^A-Z0-9+\/]/gi, "");
      for (var t = [], n = 0, r = 0; n < e.length; r = ++n % 4)
        0 != r &&
          t.push(
            ((Fu.indexOf(e.charAt(n - 1)) & (Math.pow(2, -2 * r + 8) - 1)) <<
              (2 * r)) |
              (Fu.indexOf(e.charAt(n)) >>> (6 - 2 * r))
          );
      return t;
    },
  }),
  (Bu.exports = Nu);
var Uu = {
    utf8: {
      stringToBytes: function (e) {
        return Uu.bin.stringToBytes(unescape(encodeURIComponent(e)));
      },
      bytesToString: function (e) {
        return decodeURIComponent(escape(Uu.bin.bytesToString(e)));
      },
    },
    bin: {
      stringToBytes: function (e) {
        for (var t = [], n = 0; n < e.length; n++)
          t.push(255 & e.charCodeAt(n));
        return t;
      },
      bytesToString: function (e) {
        for (var t = [], n = 0; n < e.length; n++)
          t.push(String.fromCharCode(e[n]));
        return t.join("");
      },
    },
  },
  $u = Uu,
  Hu = function (e) {
    return (
      null != e &&
      (zu(e) ||
        (function (e) {
          return (
            "function" == typeof e.readFloatLE &&
            "function" == typeof e.slice &&
            zu(e.slice(0, 0))
          );
        })(e) ||
        !!e._isBuffer)
    );
  };
function zu(e) {
  return (
    !!e.constructor &&
    "function" == typeof e.constructor.isBuffer &&
    e.constructor.isBuffer(e)
  );
}
!(function () {
  var e = Bu.exports,
    t = $u.utf8,
    n = Hu,
    r = $u.bin,
    o = function (i, a) {
      i.constructor == String
        ? (i =
            a && "binary" === a.encoding
              ? r.stringToBytes(i)
              : t.stringToBytes(i))
        : n(i)
        ? (i = Array.prototype.slice.call(i, 0))
        : Array.isArray(i) ||
          i.constructor === Uint8Array ||
          (i = i.toString());
      for (
        var c = e.bytesToWords(i),
          u = 8 * i.length,
          s = 1732584193,
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
      (c[u >>> 5] |= 128 << u % 32), (c[14 + (((u + 64) >>> 9) << 4)] = u);
      var d = o._ff,
        v = o._gg,
        g = o._hh,
        m = o._ii;
      for (p = 0; p < c.length; p += 16) {
        var y = s,
          b = l,
          S = f,
          T = h;
        (s = d(s, l, f, h, c[p + 0], 7, -680876936)),
          (h = d(h, s, l, f, c[p + 1], 12, -389564586)),
          (f = d(f, h, s, l, c[p + 2], 17, 606105819)),
          (l = d(l, f, h, s, c[p + 3], 22, -1044525330)),
          (s = d(s, l, f, h, c[p + 4], 7, -176418897)),
          (h = d(h, s, l, f, c[p + 5], 12, 1200080426)),
          (f = d(f, h, s, l, c[p + 6], 17, -1473231341)),
          (l = d(l, f, h, s, c[p + 7], 22, -45705983)),
          (s = d(s, l, f, h, c[p + 8], 7, 1770035416)),
          (h = d(h, s, l, f, c[p + 9], 12, -1958414417)),
          (f = d(f, h, s, l, c[p + 10], 17, -42063)),
          (l = d(l, f, h, s, c[p + 11], 22, -1990404162)),
          (s = d(s, l, f, h, c[p + 12], 7, 1804603682)),
          (h = d(h, s, l, f, c[p + 13], 12, -40341101)),
          (f = d(f, h, s, l, c[p + 14], 17, -1502002290)),
          (s = v(
            s,
            (l = d(l, f, h, s, c[p + 15], 22, 1236535329)),
            f,
            h,
            c[p + 1],
            5,
            -165796510
          )),
          (h = v(h, s, l, f, c[p + 6], 9, -1069501632)),
          (f = v(f, h, s, l, c[p + 11], 14, 643717713)),
          (l = v(l, f, h, s, c[p + 0], 20, -373897302)),
          (s = v(s, l, f, h, c[p + 5], 5, -701558691)),
          (h = v(h, s, l, f, c[p + 10], 9, 38016083)),
          (f = v(f, h, s, l, c[p + 15], 14, -660478335)),
          (l = v(l, f, h, s, c[p + 4], 20, -405537848)),
          (s = v(s, l, f, h, c[p + 9], 5, 568446438)),
          (h = v(h, s, l, f, c[p + 14], 9, -1019803690)),
          (f = v(f, h, s, l, c[p + 3], 14, -187363961)),
          (l = v(l, f, h, s, c[p + 8], 20, 1163531501)),
          (s = v(s, l, f, h, c[p + 13], 5, -1444681467)),
          (h = v(h, s, l, f, c[p + 2], 9, -51403784)),
          (f = v(f, h, s, l, c[p + 7], 14, 1735328473)),
          (s = g(
            s,
            (l = v(l, f, h, s, c[p + 12], 20, -1926607734)),
            f,
            h,
            c[p + 5],
            4,
            -378558
          )),
          (h = g(h, s, l, f, c[p + 8], 11, -2022574463)),
          (f = g(f, h, s, l, c[p + 11], 16, 1839030562)),
          (l = g(l, f, h, s, c[p + 14], 23, -35309556)),
          (s = g(s, l, f, h, c[p + 1], 4, -1530992060)),
          (h = g(h, s, l, f, c[p + 4], 11, 1272893353)),
          (f = g(f, h, s, l, c[p + 7], 16, -155497632)),
          (l = g(l, f, h, s, c[p + 10], 23, -1094730640)),
          (s = g(s, l, f, h, c[p + 13], 4, 681279174)),
          (h = g(h, s, l, f, c[p + 0], 11, -358537222)),
          (f = g(f, h, s, l, c[p + 3], 16, -722521979)),
          (l = g(l, f, h, s, c[p + 6], 23, 76029189)),
          (s = g(s, l, f, h, c[p + 9], 4, -640364487)),
          (h = g(h, s, l, f, c[p + 12], 11, -421815835)),
          (f = g(f, h, s, l, c[p + 15], 16, 530742520)),
          (s = m(
            s,
            (l = g(l, f, h, s, c[p + 2], 23, -995338651)),
            f,
            h,
            c[p + 0],
            6,
            -198630844
          )),
          (h = m(h, s, l, f, c[p + 7], 10, 1126891415)),
          (f = m(f, h, s, l, c[p + 14], 15, -1416354905)),
          (l = m(l, f, h, s, c[p + 5], 21, -57434055)),
          (s = m(s, l, f, h, c[p + 12], 6, 1700485571)),
          (h = m(h, s, l, f, c[p + 3], 10, -1894986606)),
          (f = m(f, h, s, l, c[p + 10], 15, -1051523)),
          (l = m(l, f, h, s, c[p + 1], 21, -2054922799)),
          (s = m(s, l, f, h, c[p + 8], 6, 1873313359)),
          (h = m(h, s, l, f, c[p + 15], 10, -30611744)),
          (f = m(f, h, s, l, c[p + 6], 15, -1560198380)),
          (l = m(l, f, h, s, c[p + 13], 21, 1309151649)),
          (s = m(s, l, f, h, c[p + 4], 6, -145523070)),
          (h = m(h, s, l, f, c[p + 11], 10, -1120210379)),
          (f = m(f, h, s, l, c[p + 2], 15, 718787259)),
          (l = m(l, f, h, s, c[p + 9], 21, -343485551)),
          (s = (s + y) >>> 0),
          (l = (l + b) >>> 0),
          (f = (f + S) >>> 0),
          (h = (h + T) >>> 0);
      }
      return e.endian([s, l, f, h]);
    };
  (o._ff = function (e, t, n, r, o, i, a) {
    var c = e + ((t & n) | (~t & r)) + (o >>> 0) + a;
    return ((c << i) | (c >>> (32 - i))) + t;
  }),
    (o._gg = function (e, t, n, r, o, i, a) {
      var c = e + ((t & r) | (n & ~r)) + (o >>> 0) + a;
      return ((c << i) | (c >>> (32 - i))) + t;
    }),
    (o._hh = function (e, t, n, r, o, i, a) {
      var c = e + (t ^ n ^ r) + (o >>> 0) + a;
      return ((c << i) | (c >>> (32 - i))) + t;
    }),
    (o._ii = function (e, t, n, r, o, i, a) {
      var c = e + (n ^ (t | ~r)) + (o >>> 0) + a;
      return ((c << i) | (c >>> (32 - i))) + t;
    }),
    (o._blocksize = 16),
    (o._digestsize = 16),
    (Vu.exports = function (t, n) {
      if (null == t) throw new Error("Illegal argument " + t);
      var i = e.wordsToBytes(o(t, n));
      return n && n.asBytes
        ? i
        : n && n.asString
        ? r.bytesToString(i)
        : e.bytesToHex(i);
    });
})();
var Wu = (function () {
    function e(t, r) {
      n(this, e),
        (this.extensionContext = t),
        (this.vscode = r),
        (this.isFirstTime = !1),
        (this.globalState = this.extensionContext.globalState),
        this.load();
    }
    return (
      o(e, [
        {
          key: "loadCurrentUserSettings",
          value: function () {
            var e = this.vscode.workspace.getConfiguration("workbench");
            (this.version = Xc.VERSION),
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
              n = ""
                .concat(e)
                .concat(
                  this.fileIconsMonochrome ? " Monochrome " : " ",
                  "Icons"
                ),
              r = this.vscode.workspace.getConfiguration("workbench"),
              o = r.iconTheme;
            e !== t.colorTheme && r.update("colorTheme", e, !0),
              (this.isValidIconTheme(o) || this.isFirstTime) &&
                n !== t.iconTheme &&
                r.update("iconTheme", n, !0),
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
            var n = Vu.exports("".concat(Xc.APP.UUID).concat(e)),
              r = n.match(/.{1,5}/g),
              o = r.slice(0, 5).join("-");
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
            return Xc.APP.THEMES.includes(
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
                  Xc.APP.SECONDS_TO_EXPIRE_FAST
              : this.getCurrentTimeStamp() - this.lastTimeStamp >
                  Xc.APP.SECONDS_TO_EXPIRE;
          },
        },
        {
          key: "isUsingForAWhile",
          get: function () {
            return (
              this.lastTimeStamp - this.firstTimeStamp > Xc.APP.SLOW_PERIOD
            );
          },
        },
        {
          key: "hasActiveMonokaiProColorTheme",
          get: function () {
            return Xc.APP.THEMES.includes(this.colorTheme);
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
  Gu = (function () {
    function e(t, r) {
      n(this, e),
        (this.vscode = t),
        (this.open = r),
        (this.state = null),
        (this.timeout = null);
    }
    return (
      o(e, [
        {
          key: "activate",
          value: function (e) {
            var t = this;
            this.state = new Wu(e, this.vscode);
            var n = {
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
            Object.keys(n).forEach(function (r) {
              var o = t.vscode.commands.registerCommand(r, n[r]);
              e.subscriptions.push(o);
            }),
              this.vscode.workspace.onDidChangeConfiguration(function () {
                var e = t.state.get(),
                  n = t.state.load();
                t.state.hasActiveMonokaiProColorTheme &&
                  t.state.updateTheme(n.colorTheme, e);
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
            Xc.APP.THEMES.forEach(function (e) {
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
                version: Xc.APP.VERSION,
                name: Xc.APP.NAME,
              },
              n = Object.keys(t)
                .map(function (e) {
                  return "".concat(e, "=").concat(encodeURIComponent(t[e]));
                })
                .join("&");
            this.vscode.window
              .showInformationMessage(
                "Thank you for evaluating Monokai Pro. Please purchase a license for extended use.",
                { modal: !0 },
                "OK"
              )
              .then(function (t) {
                t &&
                  "OK" === t.toUpperCase() &&
                  (e.open
                    ? e.open("https://monokai.pro?".concat(n))
                    : e.vscode.env.openExternal(
                        "https://monokai.pro?".concat(n)
                      ));
              });
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
  Ku = new Gu(t);
(exports.activate = function (e) {
  Ku.activate(e);
}),
  (exports.deactivate = function () {
    Ku.deactivate();
  });
