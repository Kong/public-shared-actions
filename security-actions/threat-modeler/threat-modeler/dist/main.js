"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const openai_1 = require("openai");
const fs = require("fs");
const glob_1 = require("glob");
var STRIDE;
(function (STRIDE) {
    STRIDE["S"] = "SPOOFING";
    STRIDE["T"] = "TAMPERING";
    STRIDE["R"] = "REPUDIATION";
    STRIDE["I"] = "INFORMATION DISCLOSURE";
    STRIDE["D"] = "DENIAL OF SERVICE";
    STRIDE["E"] = "ELEVATION OF PRIVILEGE";
})(STRIDE || (STRIDE = {}));
var LIKELIHOOD;
(function (LIKELIHOOD) {
    LIKELIHOOD["RARE"] = "RARE";
    LIKELIHOOD["UNLIKELY"] = "UNLIKELY";
    LIKELIHOOD["PROBABLE"] = "PROBABLE";
    LIKELIHOOD["LIKELY"] = "LIKELY";
    LIKELIHOOD["ALMOST_CERTAIN"] = "ALMOST CERTAIN";
})(LIKELIHOOD || (LIKELIHOOD = {}));
var IMPACT;
(function (IMPACT) {
    IMPACT[IMPACT["INSIGNIFICANT"] = 0] = "INSIGNIFICANT";
    IMPACT[IMPACT["MINIMAL"] = 1] = "MINIMAL";
    IMPACT[IMPACT["MODERATE"] = 2] = "MODERATE";
    IMPACT[IMPACT["SIGNIFICANT"] = 3] = "SIGNIFICANT";
    IMPACT[IMPACT["CATASTROPHIC"] = 4] = "CATASTROPHIC";
})(IMPACT || (IMPACT = {}));
var RISK;
(function (RISK) {
    RISK[RISK["MINOR"] = 0] = "MINOR";
    RISK[RISK["LOW"] = 1] = "LOW";
    RISK[RISK["MEDIUM"] = 2] = "MEDIUM";
    RISK[RISK["HIGH"] = 3] = "HIGH";
    RISK[RISK["EXTREME"] = 4] = "EXTREME";
})(RISK || (RISK = {}));
const main = () => __awaiter(void 0, void 0, void 0, function* () {
    const args = process.argv.slice(2);
    const dryRun = getDryRun(args[2]);
    const systemPrompt = fs.readFileSync('prompt.txt', 'utf-8');
    const mermaidMatrix = yield getMermaidMatrix(args[1]);
    let rootModel = [];
    for (const mermaids of mermaidMatrix) {
        for (const mermaid of mermaids) {
            const res = yield request(dryRun, systemPrompt, args[0], mermaid);
            rootModel = appendNewModel(res, rootModel);
        }
    }
    if (!dryRun) {
        console.log(rootModel);
    }
});
const getMermaidMatrix = (directory) => __awaiter(void 0, void 0, void 0, function* () {
    // Strip slash suffix if present
    let dir = directory;
    if (directory.endsWith('/')) {
        dir = directory.slice(0, -1);
    }
    const files = yield (0, glob_1.glob)(dir + '/**/*.md');
    const mermaidMatrix = [];
    // Get all mermaid blocks
    files.forEach((file) => {
        mermaidMatrix.push(extractMermaid(fs.readFileSync(file, 'utf-8').split(/\r?\n/)));
    });
    return mermaidMatrix;
});
const extractMermaid = (contents) => {
    const mermaids = [];
    let mermaid = '';
    let inMermaidBlock = false;
    contents.forEach((line) => {
        if (inMermaidBlock) {
            mermaid += '\r\n' + line;
        }
        if (line === '```mermaid') {
            inMermaidBlock = true;
            mermaid += line;
        }
        if (line === '```') {
            mermaids.push(mermaid);
            mermaid = '';
            inMermaidBlock = false;
        }
    });
    return mermaids;
};
const request = (dryRun, systemPrompt, description, mermaid) => __awaiter(void 0, void 0, void 0, function* () {
    const params = {
        response_format: { type: 'json_object' },
        messages: [
            {
                role: 'user',
                content: `${description}

Mermaid:
    ${mermaid}

Create the threat model and only return a JSON response, using the  schema provided.`,
            },
            {
                role: 'system',
                content: systemPrompt,
            },
        ],
        model: 'gpt-3.5-turbo',
    };
    if (dryRun === false) {
        const openai = new openai_1.default({
            apiKey: process.env.OPENAI_SECRET_KEY,
        });
        const chatCompletion = yield openai.chat.completions.create(params);
        const content = chatCompletion.choices[0].message.content;
        return JSON.parse(content).threats;
    }
    console.log('GPT params:', params);
    return [];
});
const getDryRun = (flag) => {
    if (flag === 'true') {
        return true;
    }
    return false;
};
const appendNewModel = (model, rootModel) => {
    if (rootModel.length !== 0) {
        const lastId = rootModel[rootModel.length - 1].id;
        model.forEach((threat, index) => {
            index++;
            threat.id = lastId + index;
            rootModel.push(threat);
        });
        return rootModel;
    }
    rootModel.push(...model);
    return rootModel;
};
main();
