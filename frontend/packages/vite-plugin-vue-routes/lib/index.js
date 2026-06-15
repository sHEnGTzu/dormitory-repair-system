import e from "node:fs";
import t from "node:path";
import { execSync as n } from "child_process";
import * as r from "typescript";
//#region ../../node_modules/es-toolkit/dist/function/debounce.mjs
function i(e, t, { signal: n, edges: r } = {}) {
	let i, a = null, o = r != null && r.includes("leading"), s = r == null || r.includes("trailing"), c = () => {
		a !== null && (e.apply(i, a), i = void 0, a = null);
	}, l = () => {
		s && c(), p();
	}, u = null, d = () => {
		u != null && clearTimeout(u), u = setTimeout(() => {
			u = null, l();
		}, t);
	}, f = () => {
		u !== null && (clearTimeout(u), u = null);
	}, p = () => {
		f(), i = void 0, a = null;
	}, m = () => {
		c();
	}, h = function(...e) {
		if (n?.aborted) return;
		i = this, a = e;
		let t = u == null;
		d(), o && t && c();
	};
	return h.schedule = d, h.cancel = p, h.flush = m, n?.addEventListener("abort", p, { once: !0 }), h;
}
//#endregion
//#region utils.ts
function a(t) {
	let n = e.readFileSync(t, "utf-8"), i = r.createSourceFile(t, n, r.ScriptTarget.Latest, !0), a = /* @__PURE__ */ new Map(), o = [];
	function s(e) {
		if (r.isVariableStatement(e)) for (let t of e.declarationList.declarations) r.isIdentifier(t.name) && t.name.text === "routes" && t.initializer && r.isArrayLiteralExpression(t.initializer) && (o = c(t.initializer));
		r.forEachChild(e, s);
	}
	function c(e) {
		return e.elements.map((e) => u(e));
	}
	function l(e) {
		let t = {};
		for (let n of e.properties) if (r.isPropertyAssignment(n)) {
			let e = r.isIdentifier(n.name) || r.isStringLiteral(n.name) ? n.name.text : "", i = u(n.initializer);
			e && (t[e] = i);
		}
		return t;
	}
	function u(e) {
		if (r.isStringLiteral(e)) return e.text;
		if (r.isNumericLiteral(e)) return Number(e.text);
		if (e.kind === r.SyntaxKind.TrueKeyword) return !0;
		if (e.kind === r.SyntaxKind.FalseKeyword) return !1;
		if (e.kind === r.SyntaxKind.ArrayLiteralExpression) return c(e);
		if (e.kind === r.SyntaxKind.ObjectLiteralExpression) return l(e);
		if (e.kind === r.SyntaxKind.CallExpression) {
			let t = e;
			if (t.expression.kind === r.SyntaxKind.Identifier && t.expression.text === "import") {
				let e = t.arguments[0];
				return e && e.kind === r.SyntaxKind.StringLiteral ? e.text : "";
			}
		} else if (e.kind === r.SyntaxKind.ArrowFunction) return;
		else if (e.kind === r.SyntaxKind.AsExpression) return u(e.expression);
		else if (e.kind === r.SyntaxKind.Identifier) return e.text;
	}
	function d(e) {
		for (let t of e) {
			let { name: e, meta: n, redirect: r, children: i } = t;
			a.set(e, {
				meta: n,
				redirect: r
			}), i && i.length > 0 && d(i);
		}
	}
	if (s(i), o.length > 0) return d(o), a;
	throw Error("Failed to parse routes");
}
function o(e) {
	let t = [], n = /:([a-zA-Z0-9_]+)(\+|\*)?/g, r;
	for (; (r = n.exec(e)) !== null;) {
		let e = r[1], n = r[2];
		e && t.push({
			name: e,
			isOptional: n === "*",
			isArray: n === "+"
		});
	}
	return t;
}
function s(e) {
	let t = "// 此文件由vite-plugin-routes自动生成，请勿手动修改\nimport type { RouteRecordInfo } from 'vue-router'\nexport {}\n\ndeclare global {\n  interface RouteNamedMap {";
	function n(e) {
		let t = [];
		for (let r of e) t.push(r.name), r.children && r.children.length > 0 && t.push(...n(r.children));
		return t;
	}
	function r(e, t = "") {
		let i = "", a = e.path;
		t && (a = t.startsWith("/") && !e.path.startsWith("/") || !t.startsWith("/") && !e.path.startsWith("/") ? `${t}/${e.path}` : e.path);
		let s = o(a), c = "Record<string, string | number>";
		s.length > 0 && (c = `{\n${s.map((e) => e.isArray ? `      ${e.name}: string | number | (string | number)[]` : `      ${e.name}: string | number`).join(",\n")}\n    } & ${c}`);
		let l = "Record<string, string>";
		s.length > 0 && (l = `{\n${s.map((e) => e.isArray ? `      ${e.name}: string[]` : `      ${e.name}: string`).join(",\n")}\n    } & ${l}`);
		let u = e.children && e.children.length > 0 ? n(e.children).map((e) => `'${e}'`).join(" | ") : "never";
		if (i += `\n    // ${e.meta.title || e.name}\n`, i += `    '${e.name}': RouteRecordInfo<\n`, i += `      '${e.name}',\n`, i += `      '${a}',\n`, i += `      ${c},\n`, i += `      ${l},\n`, i += `      ${u}\n`, i += "    >", e.children && e.children.length > 0) for (let t of e.children) i += r(t, a);
		return i;
	}
	for (let n of e) t += r(n);
	return t += "\n  }\n", t += "\n  type RouteRecordName = keyof RouteNamedMap\n", t += "\n}\n", t;
}
function c(e, t) {
	let n = "// 此文件由vite-plugin-routes自动生成，仅限meta、redirect属性手动修改\nimport type { RouteRecordRaw } from 'vue-router'\n\nexport const routes: RouteRecordRaw[] = [\n";
	function r(e, n = 1) {
		let i = "  ".repeat(n), a = i + "{\n";
		if (e.name && (a += `${i}  name: '${e.name}',\n`), a += `${i}  path: '${e.path}',\n`, e.component && (a += `${i}  component: () => import('${e.component}'),\n`), t.get(e.name)?.redirect) if (typeof t.get(e.name)?.redirect == "string") a += `${i}  redirect: '${t.get(e.name)?.redirect}',\n`;
		else {
			a += `${i}  redirect: {\n`;
			for (let [n, r] of Object.entries(t.get(e.name)?.redirect || {})) {
				let e = typeof r == "string" ? `'${r}'` : Array.isArray(r) ? JSON.stringify(r).replace(/"/g, "'") : r;
				a += `${i}    ${n}: ${e},\n`;
			}
			a += `${i}  },\n`;
		}
		if (t.get(e.name)?.meta) {
			a += `${i}  meta: {\n`;
			for (let [n, r] of Object.entries(t.get(e.name)?.meta || {})) {
				let e = typeof r == "string" ? `'${r}'` : Array.isArray(r) ? JSON.stringify(r).replace(/"/g, "'") : r;
				a += `${i}    ${n}: ${e},\n`;
			}
			a += `${i}  },\n`;
		} else a += `${i}  meta: {\n`, a += `${i}    title: '${e.meta.title}'\n`, a += `${i}  },\n`;
		return e.children && e.children.length > 0 && (a += `${i}  children: [\n`, a += e.children.map((e) => r(e, n + 2)).join(",\n"), a += `\n${i}  ]\n`), a += `${i}}`, a;
	}
	return n += e.map((e) => r(e)).join(",\n"), n += "\n]\n", n;
}
function l(n, r) {
	let i = process.cwd(), a = [], o = e.readdirSync(n);
	for (let s of o) {
		let o = t.join(n, s);
		if (e.statSync(o).isDirectory()) {
			let n = e.existsSync(t.join(o, "index.vue")) || e.readdirSync(o).some((e) => e.match(/^\[.*?\]\.vue$/)), c = l(o, r), u = t.relative(t.join(i, "src/views"), o), d = u.split(t.sep), f = e.readdirSync(o).find((e) => e.match(/^\[.*?\]\.vue$/))?.match(/\[(.*?)\]/)?.[1], p = f ? d.length === 1 ? `/${s}/:${f}` : `${s}/:${f}` : d.length === 1 ? `/${s}` : s, m = d.map((e) => e.replace(/\[.*?\]$/, "")), h = m.join("-"), g = m.join("_");
			if (n || c.length > 0) {
				let e = !c.length, o = {
					path: p,
					name: h,
					level: d.length,
					meta: { title: g }
				}, s = `@${t.relative(i, r).replace("src", "").split(t.sep).join("/")}/${u.split(t.sep).join("/")}/${f ? `[${f}].vue` : "index.vue"}`;
				(e || n) && (o.component = s), o.children = c, a.push(o);
			}
		}
	}
	return a;
}
//#endregion
//#region index.ts
function u(r) {
	let { entry: o, output: u, typeDir: d } = r, f = process.cwd(), p = t.resolve(f, o), m = t.resolve(f, u), h = t.resolve(f, d), g = /* @__PURE__ */ new Map();
	function _(t = !1) {
		t && console.log("监听到文件变化，重新生成路由..."), g.clear(), g = a(m);
		let r = l(p, p), i = c(r, g);
		e.writeFileSync(m, i, "utf-8");
		let o = s(r);
		e.writeFileSync(h, o, "utf-8"), n(`npx prettier --write "${m}" "${h}"`), console.log("\x1B[32mvite-plugin-vue-routes: 路由生成成功\x1B[0m");
	}
	let v = i(_, 300), y = e.watch(p, { recursive: !0 }, (e) => {
		e === "rename" && v();
	});
	return {
		name: "vite-plugin-vue-routes",
		enforce: "pre",
		buildStart() {
			_();
		},
		buildEnd() {
			y.close();
		}
	};
}
//#endregion
export { u as vitePluginRoutes };
