const words = [
    'Something is happening. Please wait.',
    'Please be patient. This may take a while.',
    'While you wait, please consider that this is a good time to take a break.',
    'Please wait. This is a good time to go grab a cup of coffee.',
    'Sometimes the things that are worth waiting for take time.',
    'Please wait. This is a good time to stretch your legs.',
    'Posture check! Please wait while we load the application.',
];

const loaderWidget = `
<div style="padding-right: 32px; padding-bottom: 32px; font-smooth: always; display: flex; flex-direction: column; align-items: end">
    Loading Application...
    <div id="words" style="font-size: 16px; opacity: 0.6; font-weight: 300; text-align: right; margin-top: 4px">
    ${words[Math.floor(Math.random() * words.length)]}
    </div>
</div>`

const shadcn_flutter_config = {
    loaderWidget: loaderWidget,
    backgroundColor: null,
    foregroundColor: null,
    loaderColor: null,
    fontFamily: 'Geist Sans',
    fontSize: '24px',
    fontWeight: '400',
    mainAxisAlignment: 'end',
    crossAxisAlignment: 'end',
    externalScripts: [
        {
            src: 'https://cdn.jsdelivr.net/npm/@fontsource/geist-sans@5.0.3/400.min.css',
            type: 'stylesheet',
        },
        {
            src: 'https://cdn.jsdelivr.net/npm/@fontsource/geist-sans@5.0.3/300.min.css',
            type: 'stylesheet',
        },
    ]
};

(()=>{var P=()=>navigator.vendor==="Google Inc."||navigator.agent==="Edg/",L=()=>typeof ImageDecoder>"u"?!1:P(),U=()=>typeof Intl.v8BreakIterator<"u"&&typeof Intl.Segmenter<"u",W=()=>{let i=[0,97,115,109,1,0,0,0,1,5,1,95,1,120,0];return WebAssembly.validate(new Uint8Array(i))},f={hasImageCodecs:L(),hasChromiumBreakIterators:U(),supportsWasmGC:W(),crossOriginIsolated:window.crossOriginIsolated};var h=j();function j(){let i=document.querySelector("base");return i&&i.getAttribute("href")||""}function m(...i){return i.filter(t=>!!t).map((t,n)=>n===0?_(t):K(_(t))).filter(t=>t.length).join("/")}function K(i){let t=0;for(;t<i.length&&i.charAt(t)==="/";)t++;return i.substring(t)}function _(i){let t=i.length;for(;t>0&&i.charAt(t-1)==="/";)t--;return i.substring(0,t)}function I(i,t){return i.canvasKitBaseUrl?i.canvasKitBaseUrl:t.engineRevision&&!t.useLocalCanvasKit?m("https://www.gstatic.com/flutter-canvaskit",t.engineRevision):"/canvaskit"}var v=class{constructor(){this._scriptLoaded=!1}setTrustedTypesPolicy(t){this._ttPolicy=t}async loadEntrypoint(t){let{entrypointUrl:n=m(h,"main.dart.js"),onEntrypointLoaded:e,nonce:r}=t||{};return this._loadJSEntrypoint(n,e,r)}async load(t,n,e,r,s){s??=o=>{o.initializeEngine(e).then(c=>c.runApp())};let{entryPointBaseUrl:a}=e;if(t.compileTarget==="dart2wasm")return this._loadWasmEntrypoint(t,n,a,s);{let o=t.mainJsPath??"main.dart.js",c=m(h,a,o);return this._loadJSEntrypoint(c,s,r)}}didCreateEngineInitializer(t){typeof this._didCreateEngineInitializerResolve=="function"&&(this._didCreateEngineInitializerResolve(t),this._didCreateEngineInitializerResolve=null,delete _flutter.loader.didCreateEngineInitializer),typeof this._onEntrypointLoaded=="function"&&this._onEntrypointLoaded(t)}_loadJSEntrypoint(t,n,e){let r=typeof n=="function";if(!this._scriptLoaded){this._scriptLoaded=!0;let s=this._createScriptTag(t,e);if(r)console.debug("Injecting <script> tag. Using callback."),this._onEntrypointLoaded=n,document.head.append(s);else return new Promise((a,o)=>{console.debug("Injecting <script> tag. Using Promises. Use the callback approach instead!"),this._didCreateEngineInitializerResolve=a,s.addEventListener("error",o),document.head.append(s)})}}async _loadWasmEntrypoint(t,n,e,r){if(!this._scriptLoaded){this._scriptLoaded=!0,this._onEntrypointLoaded=r;let{mainWasmPath:s,jsSupportRuntimePath:a}=t,o=m(h,e,s),c=m(h,e,a);this._ttPolicy!=null&&(c=this._ttPolicy.createScriptURL(c));let p=WebAssembly.compileStreaming(fetch(o)),l=await import(c),w;t.renderer==="skwasm"?w=(async()=>{let u=await n.skwasm;return window._flutter_skwasmInstance=u,{skwasm:u.wasmExports,skwasmWrapper:u,ffi:{memory:u.wasmMemory}}})():w={};let d=await l.instantiate(p,w);await l.invoke(d)}}_createScriptTag(t,n){let e=document.createElement("script");e.type="application/javascript",n&&(e.nonce=n);let r=t;return this._ttPolicy!=null&&(r=this._ttPolicy.createScriptURL(t)),e.src=r,e}};async function S(i,t,n){if(t<0)return i;let e,r=new Promise((s,a)=>{e=setTimeout(()=>{a(new Error(`${n} took more than ${t}ms to resolve. Moving on.`,{cause:S}))},t)});return Promise.race([i,r]).finally(()=>{clearTimeout(e)})}var y=class{setTrustedTypesPolicy(t){this._ttPolicy=t}loadServiceWorker(t){if(!t)return console.debug("Null serviceWorker configuration. Skipping."),Promise.resolve();if(!("serviceWorker"in navigator)){let o="Service Worker API unavailable.";return window.isSecureContext||(o+=`
The current context is NOT secure.`,o+=`
Read more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts`),Promise.reject(new Error(o))}let{serviceWorkerVersion:n,serviceWorkerUrl:e=m(h,`flutter_service_worker.js?v=${n}`),timeoutMillis:r=4e3}=t,s=e;this._ttPolicy!=null&&(s=this._ttPolicy.createScriptURL(s));let a=navigator.serviceWorker.register(s).then(o=>this._getNewServiceWorker(o,n)).then(this._waitForServiceWorkerActivation);return S(a,r,"prepareServiceWorker")}async _getNewServiceWorker(t,n){if(!t.active&&(t.installing||t.waiting))return console.debug("Installing/Activating first service worker."),t.installing||t.waiting;if(t.active.scriptURL.endsWith(n))return console.debug("Loading from existing service worker."),t.active;{let e=await t.update();return console.debug("Updating service worker."),e.installing||e.waiting||e.active}}async _waitForServiceWorkerActivation(t){if(!t||t.state==="activated")if(t){console.debug("Service worker already active.");return}else throw new Error("Cannot activate a null service worker!");return new Promise((n,e)=>{t.addEventListener("statechange",()=>{t.state==="activated"&&(console.debug("Activated new service worker."),n())})})}};var g=class{constructor(t,n="flutter-js"){let e=t||[/\.js$/,/\.mjs$/];window.trustedTypes&&(this.policy=trustedTypes.createPolicy(n,{createScriptURL:function(r){if(r.startsWith("blob:"))return r;let s=new URL(r,window.location),a=s.pathname.split("/").pop();if(e.some(c=>c.test(a)))return s.toString();console.error("URL rejected by TrustedTypes policy",n,":",r,"(download prevented)")}}))}};var k=i=>{let t=WebAssembly.compileStreaming(fetch(i));return(n,e)=>((async()=>{let r=await t,s=await WebAssembly.instantiate(r,n);e(s,r)})(),{})};var T=(i,t,n,e)=>window.flutterCanvasKit?Promise.resolve(window.flutterCanvasKit):(window.flutterCanvasKitLoaded=new Promise((r,s)=>{let a=n.hasChromiumBreakIterators&&n.hasImageCodecs;if(!a&&t.canvasKitVariant=="chromium")throw"Chromium CanvasKit variant specifically requested, but unsupported in this browser";let o=a&&t.canvasKitVariant!=="full",c=e;o&&(c=m(c,"chromium"));let p=m(c,"canvaskit.js");i.flutterTT.policy&&(p=i.flutterTT.policy.createScriptURL(p));let l=k(m(c,"canvaskit.wasm")),w=document.createElement("script");w.src=p,t.nonce&&(w.nonce=t.nonce),w.addEventListener("load",async()=>{try{let d=await CanvasKitInit({instantiateWasm:l});window.flutterCanvasKit=d,r(d)}catch(d){s(d)}}),w.addEventListener("error",s),document.head.appendChild(w)}),window.flutterCanvasKitLoaded);var E=(i,t,n,e)=>new Promise((r,s)=>{let a=m(e,"skwasm.js");i.flutterTT.policy&&(a=i.flutterTT.policy.createScriptURL(a));let o=k(m(e,"skwasm.wasm")),c=document.createElement("script");c.src=a,t.nonce&&(c.nonce=t.nonce),c.addEventListener("load",async()=>{try{let p=await skwasm({instantiateWasm:o,locateFile:(l,w)=>{let d=w+l;return d.endsWith(".worker.js")?URL.createObjectURL(new Blob([`importScripts("${d}");`],{type:"application/javascript"})):d}});r(p)}catch(p){s(p)}}),c.addEventListener("error",s),document.head.appendChild(c)});var C=class{async loadEntrypoint(t){let{serviceWorker:n,...e}=t||{},r=new g,s=new y;s.setTrustedTypesPolicy(r.policy),await s.loadServiceWorker(n).catch(o=>{console.warn("Exception while loading service worker:",o)});let a=new v;return a.setTrustedTypesPolicy(r.policy),this.didCreateEngineInitializer=a.didCreateEngineInitializer.bind(a),a.loadEntrypoint(e)}async load({serviceWorkerSettings:t,onEntrypointLoaded:n,nonce:e,config:r}={}){r??={};let s=_flutter.buildConfig;if(!s)throw"FlutterLoader.load requires _flutter.buildConfig to be set";let a=u=>{switch(u){case"skwasm":return f.crossOriginIsolated&&f.hasChromiumBreakIterators&&f.hasImageCodecs&&f.supportsWasmGC;default:return!0}},o=(u,b)=>{switch(u.renderer){case"auto":return b=="canvaskit"||b=="html";default:return u.renderer==b}},c=u=>u.compileTarget==="dart2wasm"&&!f.supportsWasmGC||r.renderer&&!o(u,r.renderer)?!1:a(u.renderer),p=s.builds.find(c);if(!p)throw"FlutterLoader could not find a build compatible with configuration and environment.";let l={};l.flutterTT=new g,t&&(l.serviceWorkerLoader=new y,l.serviceWorkerLoader.setTrustedTypesPolicy(l.flutterTT.policy),await l.serviceWorkerLoader.loadServiceWorker(t).catch(u=>{console.warn("Exception while loading service worker:",u)}));let w=I(r,s);p.renderer==="canvaskit"?l.canvasKit=T(l,r,f,w):p.renderer==="skwasm"&&(l.skwasm=E(l,r,f,w));let d=new v;return d.setTrustedTypesPolicy(l.flutterTT.policy),this.didCreateEngineInitializer=d.didCreateEngineInitializer.bind(d),d.load(p,l,r,e,n)}};window._flutter||(window._flutter={});window._flutter.loader||(window._flutter.loader=new C);})();
//# sourceMappingURL=flutter.js.map

if (!window._flutter) {
  window._flutter = {};
}
_flutter.buildConfig = {"engineRevision":"b8800d88be4866db1b15f8b954ab2573bba9960f","builds":[{"compileTarget":"dart2wasm","renderer":"skwasm","mainWasmPath":"main.dart.wasm","jsSupportRuntimePath":"main.dart.mjs"},{"compileTarget":"dart2js","renderer":"canvaskit","mainJsPath":"main.dart.js"}]};


class ShadcnAppConfig {
    background;
    foreground;
    fontFamily;
    fontSize;
    fontWeight;
    mainAxisAlignment;
    crossAxisAlignment;
    loaderWidget;
    loaderColor;
    externalScripts;

    constructor({ background, foreground, fontFamily, fontSize, fontWeight, mainAxisAlignment, crossAxisAlignment, loaderWidget, loaderColor, externalScripts }) {
        this.background = background;
        this.foreground = foreground;
        this.fontFamily = fontFamily;
        this.fontSize = fontSize;
        this.fontWeight = fontWeight;
        this.mainAxisAlignment = mainAxisAlignment;
        this.crossAxisAlignment = crossAxisAlignment;
        this.loaderWidget = loaderWidget;
        this.loaderColor = loaderColor;
        this.externalScripts = externalScripts;

        if (this.background == null) {
            this.background = localStorage.getItem('shadcn_flutter.background') || '#09090b';
        }
        if (this.foreground == null) {
            this.foreground = localStorage.getItem('shadcn_flutter.foreground') || '#ffffff';
        }
        if (this.loaderColor == null) {
            this.loaderColor = localStorage.getItem('shadcn_flutter.primary') || '#3c83f6';
        }
    }
}

class ShadcnAppThemeChangedEvent extends CustomEvent {
    constructor(theme) {
        super('shadcn_flutter_theme_changed', { detail: theme });
    }
}

class ShadcnAppTheme {
    background;
    foreground;
    primary;

    constructor(background, foreground, primary) {
        this.background = background;
        this.foreground = foreground;
        this.primary = primary;
    }
}

class ShadcnApp {
    config;

    constructor(config) {
        this.config = config;
    }

    loadApp() {
        window.addEventListener('shadcn_flutter_app_ready', this.onAppReady);
        window.addEventListener('shadcn_flutter_theme_changed', this.onThemeChanged);
        this.#initializeDocument();
        let externalScriptIndex = 0;
        this.#loadExternalScripts(externalScriptIndex, () => {
            _flutter.loader.load({
                onEntrypointLoaded: async function(engineInitializer) {
                    const appRunner = await engineInitializer.initializeEngine();
                    await appRunner.runApp();
                }
            });
        });
    }

    #loadExternalScripts(index, onDone) {
        if (index >= this.config.externalScripts.length) {
            onDone();
            return;
        }
        this.#loadScriptDynamically(this.config.externalScripts[index], () => {
            this.#loadExternalScripts(index + 1, onDone);
        });
    }

    #createStyleSheet(css) {
        const style = document.createElement('style');
        style.type = 'text/css';
        style.appendChild(document.createTextNode(css));
        document.head.appendChild(style);
    }

    #loadScriptDynamically(src, callback) {
        if (typeof src === 'string') {
            src = { src: src, type: 'script' };
        }
        if (src.type === 'script') {
            const script = document.createElement('script');
            script.src = src.src;
            script.onload = callback;
            document.body.appendChild(script);
        } else if (src.type === 'module') {
            const script = document.createElement('script');
            script.type = 'module';
            script.src = src.src;
            script.onload = callback;
            document.body.appendChild(script);
        } else if (src.type === 'stylesheet') {
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = src.src;
            link.onload = callback;
            document.head.appendChild(link);
        } else {
            throw new Error('Unknown type of file to load: ' + src);
        }
    }

    #initializeDocument() {
        const loaderStyle = `
            display: flex;
            justify-content: ${this.config.mainAxisAlignment};
            align-items: ${this.config.crossAxisAlignment};
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: ${this.config.background};
            color: ${this.config.foreground};
            z-index: 9998;
            font-family: ${this.config.fontFamily};
            font-size: ${this.config.fontSize};
            font-weight: ${this.config.fontWeight};
            text-align: center;
            transition: opacity 0.5s;
            opacity: 1;
            pointer-events: initial;
        `;

        const loaderBarCss = `
        .loader {
          height: 7px;
          background: repeating-linear-gradient(-45deg,${this.config.loaderColor} 0 15px,#000 0 20px) left/200% 100%;
          animation: l3 20s infinite linear;
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          z-index: 9999;
        }
        @keyframes l3 {
            100% {background-position:right}
        }`;

        const loaderDiv = document.createElement('div');
        loaderDiv.style.cssText = loaderStyle;
        loaderDiv.innerHTML = this.config.loaderWidget;

        document.body.appendChild(loaderDiv);

        document.body.style.backgroundColor = this.config.background;

        const loaderBarDiv = document.createElement('div');
        loaderBarDiv.className = 'loader';
        loaderDiv.appendChild(loaderBarDiv);

        this.#createStyleSheet(loaderBarCss);
    }

    onAppReady() {
        const loaderDiv = document.querySelector('div');
        loaderDiv.style.opacity = 0;
        loaderDiv.style.pointerEvents = 'none';
    }

    onThemeChanged(event) {
        let theme = event.detail;
        let background = theme['background'];
        let foreground = theme['foreground'];
        let primary = theme['primary'];
        localStorage.setItem('shadcn_flutter.background', background);
        localStorage.setItem('shadcn_flutter.foreground', foreground);
        localStorage.setItem('shadcn_flutter.primary', primary);
    }
}

globalThis.ShadcnApp = ShadcnApp;
globalThis.ShadcnAppConfig = ShadcnAppConfig;
globalThis.ShadcnAppThemeChangedEvent = ShadcnAppThemeChangedEvent;
globalThis.ShadcnAppTheme = ShadcnAppTheme;

const shadcn_flutter = new ShadcnApp(new ShadcnAppConfig(shadcn_flutter_config));
shadcn_flutter.loadApp();