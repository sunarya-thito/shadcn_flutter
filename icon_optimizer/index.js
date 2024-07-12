const fs = require('fs');

let sourceDir = '../shadcn_flutter/icons';
let outputDir = '../shadcn_flutter/icons_optimized';

let icons = [
    'radix',
];

async function convertSvg(icon) {
    let iconsDir = sourceDir + '/' + icon;
    let outputIconsDir = outputDir + '/' + icon;
    if (!fs.existsSync(outputIconsDir)) {
        fs.mkdirSync(outputIconsDir);
    }

    // delete bugged icons
//    for (let i = 0; i < buggedIcon.length; i++) {
//        let buggedIconPath = sourceDir + '/' + buggedIcon[i];
//        if (fs.existsSync(buggedIconPath)) {
//            fs.unlinkSync(buggedIconPath);
//            console.log('Deleted', buggedIconPath);
//        }
//    }

    // exec and wait: picosvg {input} > {output}
    let files = fs.readdirSync(iconsDir);
    let futures = [];
    for (let i = 0; i < files.length; i++) {
        let file = files[i];
        let inputPath = iconsDir + '/' + file;
        let outputPath = outputIconsDir + '/' + file;
        let cmd = `picosvg ${inputPath} > ${outputPath}`;
        console.log('Executing:', cmd);
        futures.push(new Promise((resolve, reject) => {
            const exec = require('child_process').exec;
            exec(cmd, (err, stdout, stderr) => {
                if (err) {
                    console.error('Error:', err);
                    reject(err);
                } else {
                    console.log('Converted', file);
                    resolve();
                }
            });
        }));
    }
    // wait for all futures
    await Promise.all(futures);
    console.log('Converted', icon);
}

async function convertAll() {
    for (let i = 0; i < icons.length; i++) {
        await convertSvg(icons[i]);
    }
}

convertAll();