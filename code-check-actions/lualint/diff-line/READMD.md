# Diff-Line

## Description

Diff-Line is a command-line tool that parses the git diff between two branch hashes and outputs the added or deleted lines of code in a specified format.

## Installation

<!-- To use Diff-Line, you will need to have Node.js installed on your machine. If you don't already have Node.js installed, please follow the instructions on the [official website](https://nodejs.org/en/download/).

Once Node.js is installed, you can install Diff-Line globally using npm:

```bash
npm install -g diff-line
``` -->

Diff-Line is a simple internal tool, so it is not published to npm. To use Diff-Line, you will need to clone the repository and install the dependencies:

```bash
cd diff-line
npm install
```

## Usage

To use Diff-Line, open a terminal and navigate to the directory where you want to run the tool. Then, type the following command:

```bash
diff-line -s <sourceHash> -t <targetHash>
```

The `-s` flag specifies the source branch hash, and the `-t` flag specifies the target branch hash.

You can also specify the working directory with the `-w` flag, the output format with the `-f` flag, and the only output mode with the `-m` flag.

### Options

* `-s, --source <sourceHash>`: Specifies the source branch hash.
* `-t, --target <targetHash>`: Specifies the target branch hash.
* `-w, --wd [workingDir]`: Specifies the working directory (default is current working directory).
* `-f, --output-format [format]`: Specifies the output format: stdout (default), json, csv.
* `-m, --only [mode]`: Specifies the only output mode: add, del.

### Examples

Output added lines of code in CSV format:

```bash
diff-line -s abc123 -t def456 -f csv -m add
```

Output deleted lines of code in JSON format:

```bash
diff-line -s abc123 -t def456 -f json -m del
```

## Contributing

If you would like to contribute to the development of Diff-Line, please fork the repository and submit a pull request.

## License

No license.
