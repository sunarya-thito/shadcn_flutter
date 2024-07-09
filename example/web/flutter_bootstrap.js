//
// some words for the preloaders
const words = [
    'Something is happening. Please wait.',
    'Please be patient. This may take a while.',
    'While you wait, please consider that this is a good time to take a break.',
    'Please wait. This is a good time to go grab a cup of coffee.',
    'Sometimes the things that are worth waiting for take time.',
    'Please wait. This is a good time to stretch your legs.',
    'Posture check! Please wait while we load the application.',
];
const shadcnLoaderConfig = {
    loaderWidget: `
        <div style="padding-right: 32px; padding-bottom: 32px; font-smooth: always; display: flex; flex-direction: column; align-items: end">
            Loading Application...
            <div id="words" style="font-size: 16px; opacity: 0.6; font-weight: 300">
            ${words[Math.floor(Math.random() * words.length)]}
            </div>
        </div>`,
    backgroundColor: '#09090b',
    foregroundColor: '#ffffff',
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
}

//

function getSharedPreferences() {
    let sharedPreferences = {};
    // get all items from localStorage that starts with 'flutter.'
    for (let key in localStorage) {
        if (key.startsWith('flutter.')) {
            let sharedPreferencesKey = key.substring(8);
            sharedPreferences[sharedPreferencesKey] = localStorage.getItem(key);
        }
    }
    return sharedPreferences;
}

{{flutter_js}}
{{flutter_build_config}}

const loaderStyle = `
    display: flex;
    justify-content: ${shadcnLoaderConfig.mainAxisAlignment};
    align-items: ${shadcnLoaderConfig.crossAxisAlignment};
    position: fixed;
    top: 7px;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: ${shadcnLoaderConfig.backgroundColor};
    color: ${shadcnLoaderConfig.foregroundColor};
    z-index: 9999;
    font-family: ${shadcnLoaderConfig.fontFamily};
    font-size: ${shadcnLoaderConfig.fontSize};
    font-weight: ${shadcnLoaderConfig.fontWeight};
    text-align: center;
    transition: opacity 0.5s;
    opacity: 1;
    pointer-events: initial;
`;

function loadScriptDynamically(src, callback) {
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

const loaderDiv = document.createElement('div');
loaderDiv.style.cssText = loaderStyle;
loaderDiv.innerHTML = shadcnLoaderConfig.loaderWidget;

document.body.appendChild(loaderDiv);

document.body.style.backgroundColor = shadcnLoaderConfig.backgroundColor;

window.onAppReady = function() {
    loaderDiv.style.opacity = 0;
    loaderDiv.style.pointerEvents = 'none';
    delete window.onAppReady;
};

function loadExternalScripts(index, onDone) {
    if (index >= shadcnLoaderConfig.externalScripts.length) {
        onDone();
        return;
    }
    loadScriptDynamically(shadcnLoaderConfig.externalScripts[index], () => {
        loadExternalScripts(index + 1, onDone);
    });
}

function loadApp() {
    let externalScriptIndex = 0;
    loadExternalScripts(externalScriptIndex, () => {
        _flutter.loader.load({
            onEntrypointLoaded: async function(engineInitializer) {
                const appRunner = await engineInitializer.initializeEngine();
                await appRunner.runApp();
            }
        });
    });
}

loadApp();