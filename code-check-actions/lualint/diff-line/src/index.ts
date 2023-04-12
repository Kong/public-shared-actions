#!/usr/bin/env node
import { Command } from 'commander';
import * as childProcess from 'child_process';
import * as parseDiff from 'parse-diff';
const program = new Command();
program
    .name('diff-line')
    .option('-s, --source <sourceHash>', 'source branch hash')
    .option('-t, --target <targetHash>', 'target branch hash')
    .option('-w, --wd [workingDir]', 'working directory', process.cwd())
    .option('-f, --output-format [format]', 'output format: stdout (default), json, csv', 'stdout')
    .option('-m, --only [mode]', 'only output mode: add, del', 'add,del')
    .parse(process.argv);

const opts = program.opts();
if (!opts.source || !opts.target) {
    program.outputHelp();
    process.exit(1);
}

const cmd = `git diff ${opts.source} ${opts.target}`;
const options = {
    cwd: opts.wd,
    maxBuffer: 1024 * 1024,
};
const diff = childProcess.execSync(cmd, options).toString();
const files = parseDiff.default(diff);

let output = [];

files.forEach((file) => {
    file.chunks.forEach((chunk) => {
        const addLines = chunk.changes.filter((change) => change.type === 'add');
        const delLines = chunk.changes.filter((change) => change.type === 'del');
        const addRanges = getRanges(addLines);
        const delRanges = getRanges(delLines);

        if (addRanges.length > 0 && opts.only.indexOf('add') != -1) {
            output.push({ action: 'add', file: file.to, ranges: addRanges });
        }
        if (delRanges.length > 0 && opts.only.indexOf('del') != -1) {
            output.push({ action: 'del', file: file.from, ranges: delRanges });
        }
    });
});

switch (opts.outputFormat) {
    case 'stdout':
        output.forEach(({ action, file, ranges }) => {
            console.log(`${action}: ${file}: ${ranges.join(', ')}`);
        });
        break;
    case 'json':
        output = aggregateFileChanges(output)
        console.log(JSON.stringify(output, null, 2));
        break;
    case 'csv':
        if (opts.only.indexOf(',') == -1) {
            output.forEach(({ action, file, ranges }) => {
                console.log(`${file},${ranges.join('|')}`);
            });
            break;
        }
        console.log('action,file,ranges');
        output.forEach(({ action, file, ranges }) => {
            console.log(`${action},${file},${ranges.join('|')}`);
        });
        break;
    default:
        console.error(`Invalid output format: ${opts.outputFormat}`);
        process.exit(1);
}

function getRanges(changes: parseDiff.Change[]) {
    const ranges: Range[] = [];
    let startLine = 0;
    let endLine = 0;
    changes.forEach((change) => {
        if (change.type === 'add') {
            endLine = change.ln + 1;
            if (startLine === 0) {
                startLine = endLine;
            }
        } else if (change.type === 'del') {
            endLine = change.ln + 1;
            if (startLine === 0) {
                startLine = endLine;
            }
        } else if (change.type === 'normal' && startLine > 0) {
            ranges.push([startLine, endLine]);
            startLine = 0;
            endLine = 0;
        } else {
            console.error('unknown change type: ', change.type);
        }
    });
    if (startLine > 0) {
        ranges.push([startLine, endLine]);
    }
    return ranges;
}

type Range = [number, number];

interface FileChange {
    action: string;
    file: string;
    ranges: Range[];
}

function aggregateFileChanges(changes: FileChange[]): FileChange[] {
    const result: FileChange[] = [];

    changes.forEach((change) => {
        const existingChange = result.find((c) => c.action === change.action && c.file === change.file);

        if (existingChange) {
            change.ranges.forEach((range) => {
                const [start, end] = range;
                const [lastStart, lastEnd] = existingChange.ranges[existingChange.ranges.length - 1];

                if (start === lastEnd + 1) {
                    existingChange.ranges[existingChange.ranges.length - 1][1] = end;
                } else {
                    existingChange.ranges.push(range);
                }
            });
        } else {
            result.push(change);
        }
    });

    return result;
}