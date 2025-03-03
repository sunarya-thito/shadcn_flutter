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

(()=>{var P=()=>navigator.vendor==="Google Inc."||navigator.agent==="Edg/",E=()=>typeof ImageDecoder>"u"?!1:P(),L=()=>typeof Intl.v8BreakIterator<"u"&&typeof Intl.Segmenter<"u",W=()=>{let n=[0,97,115,109,1,0,0,0,1,5,1,95,1,120,0];return WebAssembly.validate(new Uint8Array(n))},w={hasImageCodecs:E(),hasChromiumBreakIterators:L(),supportsWasmGC:W(),crossOriginIsolated:window.crossOriginIsolated};function l(...n){return new URL(C(...n),document.baseURI).toString()}function C(...n){return n.filter(t=>!!t).map((t,i)=>i===0?_(t):j(_(t))).filter(t=>t.length).join("/")}function j(n){let t=0;for(;t<n.length&&n.charAt(t)==="/";)t++;return n.substring(t)}function _(n){let t=n.length;for(;t>0&&n.charAt(t-1)==="/";)t--;return n.substring(0,t)}function T(n,t){return n.canvasKitBaseUrl?n.canvasKitBaseUrl:t.engineRevision&&!t.useLocalCanvasKit?C("https://www.gstatic.com/flutter-canvaskit",t.engineRevision):"canvaskit"}var v=class{constructor(){this._scriptLoaded=!1}setTrustedTypesPolicy(t){this._ttPolicy=t}async loadEntrypoint(t){let{entrypointUrl:i=l("main.dart.js"),onEntrypointLoaded:r,nonce:e}=t||{};return this._loadJSEntrypoint(i,r,e)}async load(t,i,r,e,a){a??=o=>{o.initializeEngine(r).then(c=>c.runApp())};let{entryPointBaseUrl:s}=r;if(t.compileTarget==="dart2wasm")return this._loadWasmEntrypoint(t,i,s,a);{let o=t.mainJsPath??"main.dart.js",c=l(s,o);return this._loadJSEntrypoint(c,a,e)}}didCreateEngineInitializer(t){typeof this._didCreateEngineInitializerResolve=="function"&&(this._didCreateEngineInitializerResolve(t),this._didCreateEngineInitializerResolve=null,delete _flutter.loader.didCreateEngineInitializer),typeof this._onEntrypointLoaded=="function"&&this._onEntrypointLoaded(t)}_loadJSEntrypoint(t,i,r){let e=typeof i=="function";if(!this._scriptLoaded){this._scriptLoaded=!0;let a=this._createScriptTag(t,r);if(e)console.debug("Injecting <script> tag. Using callback."),this._onEntrypointLoaded=i,document.head.append(a);else return new Promise((s,o)=>{console.debug("Injecting <script> tag. Using Promises. Use the callback approach instead!"),this._didCreateEngineInitializerResolve=s,a.addEventListener("error",o),document.head.append(a)})}}async _loadWasmEntrypoint(t,i,r,e){if(!this._scriptLoaded){this._scriptLoaded=!0,this._onEntrypointLoaded=e;let{mainWasmPath:a,jsSupportRuntimePath:s}=t,o=l(r,a),c=l(r,s);this._ttPolicy!=null&&(c=this._ttPolicy.createScriptURL(c));let d=(await import(c)).compileStreaming(fetch(o)),f;t.renderer==="skwasm"?f=(async()=>{let m=await i.skwasm;return window._flutter_skwasmInstance=m,{skwasm:m.wasmExports,skwasmWrapper:m,ffi:{memory:m.wasmMemory}}})():f=Promise.resolve({}),await(await(await d).instantiate(await f)).invokeMain()}}_createScriptTag(t,i){let r=document.createElement("script");r.type="application/javascript",i&&(r.nonce=i);let e=t;return this._ttPolicy!=null&&(e=this._ttPolicy.createScriptURL(t)),r.src=e,r}};async function I(n,t,i){if(t<0)return n;let r,e=new Promise((a,s)=>{r=setTimeout(()=>{s(new Error(`${i} took more than ${t}ms to resolve. Moving on.`,{cause:I}))},t)});return Promise.race([n,e]).finally(()=>{clearTimeout(r)})}var y=class{setTrustedTypesPolicy(t){this._ttPolicy=t}loadServiceWorker(t){if(!t)return console.debug("Null serviceWorker configuration. Skipping."),Promise.resolve();if(!("serviceWorker"in navigator)){let o="Service Worker API unavailable.";return window.isSecureContext||(o+=`
The current context is NOT secure.`,o+=`
Read more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts`),Promise.reject(new Error(o))}let{serviceWorkerVersion:i,serviceWorkerUrl:r=l(`flutter_service_worker.js?v=${i}`),timeoutMillis:e=4e3}=t,a=r;this._ttPolicy!=null&&(a=this._ttPolicy.createScriptURL(a));let s=navigator.serviceWorker.register(a).then(o=>this._getNewServiceWorker(o,i)).then(this._waitForServiceWorkerActivation);return I(s,e,"prepareServiceWorker")}async _getNewServiceWorker(t,i){if(!t.active&&(t.installing||t.waiting))return console.debug("Installing/Activating first service worker."),t.installing||t.waiting;if(t.active.scriptURL.endsWith(i))return console.debug("Loading from existing service worker."),t.active;{let r=await t.update();return console.debug("Updating service worker."),r.installing||r.waiting||r.active}}async _waitForServiceWorkerActivation(t){if(!t||t.state==="activated")if(t){console.debug("Service worker already active.");return}else throw new Error("Cannot activate a null service worker!");return new Promise((i,r)=>{t.addEventListener("statechange",()=>{t.state==="activated"&&(console.debug("Activated new service worker."),i())})})}};var g=class{constructor(t,i="flutter-js"){let r=t||[/\.js$/,/\.mjs$/];window.trustedTypes&&(this.policy=trustedTypes.createPolicy(i,{createScriptURL:function(e){if(e.startsWith("blob:"))return e;let a=new URL(e,window.location),s=a.pathname.split("/").pop();if(r.some(c=>c.test(s)))return a.toString();console.error("URL rejected by TrustedTypes policy",i,":",e,"(download prevented)")}}))}};var k=n=>{let t=WebAssembly.compileStreaming(fetch(n));return(i,r)=>((async()=>{let e=await t,a=await WebAssembly.instantiate(e,i);r(a,e)})(),{})};var b=(n,t,i,r)=>(window.flutterCanvasKitLoaded=(async()=>{if(window.flutterCanvasKit)return window.flutterCanvasKit;let e=i.hasChromiumBreakIterators&&i.hasImageCodecs;if(!e&&t.canvasKitVariant=="chromium")throw"Chromium CanvasKit variant specifically requested, but unsupported in this browser";let a=e&&t.canvasKitVariant!=="full",s=r;a&&(s=l(s,"chromium"));let o=l(s,"canvaskit.js");n.flutterTT.policy&&(o=n.flutterTT.policy.createScriptURL(o));let c=k(l(s,"canvaskit.wasm")),p=await import(o);return window.flutterCanvasKit=await p.default({instantiateWasm:c}),window.flutterCanvasKit})(),window.flutterCanvasKitLoaded);var U=async(n,t,i,r)=>{let e=i.crossOriginIsolated&&!t.forceSingleThreadedSkwasm?"skwasm":"skwasm_st",s=l(r,`${e}.js`);n.flutterTT.policy&&(s=n.flutterTT.policy.createScriptURL(s));let o=k(l(r,`${e}.wasm`));return await(await import(s)).default({instantiateWasm:o,mainScriptUrlOrBlob:new Blob([`import '${s}'`],{type:"application/javascript"})})};var S=class{async loadEntrypoint(t){let{serviceWorker:i,...r}=t||{},e=new g,a=new y;a.setTrustedTypesPolicy(e.policy),await a.loadServiceWorker(i).catch(o=>{console.warn("Exception while loading service worker:",o)});let s=new v;return s.setTrustedTypesPolicy(e.policy),this.didCreateEngineInitializer=s.didCreateEngineInitializer.bind(s),s.loadEntrypoint(r)}async load({serviceWorkerSettings:t,onEntrypointLoaded:i,nonce:r,config:e}={}){e??={};let a=_flutter.buildConfig;if(!a)throw"FlutterLoader.load requires _flutter.buildConfig to be set";let s=u=>{switch(u){case"skwasm":return w.hasChromiumBreakIterators&&w.hasImageCodecs&&w.supportsWasmGC;default:return!0}},o=(u,m)=>{switch(u.renderer){case"auto":return m=="canvaskit"||m=="html";default:return u.renderer==m}},c=u=>u.compileTarget==="dart2wasm"&&!w.supportsWasmGC||e.renderer&&!o(u,e.renderer)?!1:s(u.renderer),p=a.builds.find(c);if(!p)throw"FlutterLoader could not find a build compatible with configuration and environment.";let d={};d.flutterTT=new g,t&&(d.serviceWorkerLoader=new y,d.serviceWorkerLoader.setTrustedTypesPolicy(d.flutterTT.policy),await d.serviceWorkerLoader.loadServiceWorker(t).catch(u=>{console.warn("Exception while loading service worker:",u)}));let f=T(e,a);p.renderer==="canvaskit"?d.canvasKit=b(d,e,w,f):p.renderer==="skwasm"&&(d.skwasm=U(d,e,w,f));let h=new v;return h.setTrustedTypesPolicy(d.flutterTT.policy),this.didCreateEngineInitializer=h.didCreateEngineInitializer.bind(h),h.load(p,d,e,r,i)}};window._flutter||(window._flutter={});window._flutter.loader||(window._flutter.loader=new S);})();
//# sourceMappingURL=flutter.js.map

if (!window._flutter) {
  window._flutter = {};
}
_flutter.buildConfig = {"engineRevision":"f73bfc4522dd0bc87bbcdb4bb3088082755c5e87","builds":[{"compileTarget":"dart2wasm","renderer":"skwasm","mainWasmPath":"main.dart.wasm","jsSupportRuntimePath":"main.dart.mjs"},{"compileTarget":"dart2js","renderer":"canvaskit","mainJsPath":"main.dart.js"}]};


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