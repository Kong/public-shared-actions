import OpenAI from 'openai'
import * as fs from 'fs'
import { glob } from 'glob'

enum STRIDE {
    S = 'SPOOFING',
    T = 'TAMPERING',
    R = 'REPUDIATION',
    I = 'INFORMATION DISCLOSURE',
    D = 'DENIAL OF SERVICE',
    E = 'ELEVATION OF PRIVILEGE',
}

enum LIKELIHOOD {
    RARE = 'RARE',
    UNLIKELY = 'UNLIKELY',
    PROBABLE = 'PROBABLE',
    LIKELY = 'LIKELY',
    ALMOST_CERTAIN = 'ALMOST CERTAIN',
}

enum IMPACT {
    INSIGNIFICANT,
    MINIMAL,
    MODERATE,
    SIGNIFICANT,
    CATASTROPHIC,
}

enum RISK {
    MINOR,
    LOW,
    MEDIUM,
    HIGH,
    EXTREME,
}

type Model = {
    id: number
    category: STRIDE
    threat: string
    impact: IMPACT
    likelihood: LIKELIHOOD
    risk: RISK
}

const main = async () => {
    const args = process.argv.slice(2)
    const dryRun = parseDryRunFlag(args[2])
    const systemPrompt = fs.readFileSync('prompt.txt', 'utf-8')
    const mermaidMatrix = await getMermaidMatrix(args[1])
    let rootModel: Model[] = []
    for (const mermaids of mermaidMatrix) {
        for (const mermaid of mermaids) {
            const res = await request(dryRun, systemPrompt, args[0], mermaid)
            rootModel = appendNewModel(res, rootModel)
        }
    }
    if (!dryRun) {
        console.log(rootModel)
    }
}

const parseDryRunFlag = (flag: string): boolean => {
    if (flag === 'true') {
        return true
    }
    return false
}

const getMermaidMatrix = async (directory: string): Promise<string[][]> => {
    // Strip slash suffix if present
    let dir: string = directory
    if (directory.endsWith('/')) {
        dir = directory.slice(0, -1)
    }
    const files: string[] = await glob(dir + '/**/*.md')
    const mermaidMatrix: string[][] = []
    // Get all mermaid blocks
    files.forEach((file) => {
        mermaidMatrix.push(
            extractMermaid(fs.readFileSync(file, 'utf-8').split(/\r?\n/))
        )
    })
    return mermaidMatrix
}

const extractMermaid = (contents: string[]): string[] => {
    const mermaids: string[] = []
    let mermaid: string = ''
    let inMermaidBlock: boolean = false
    contents.forEach((line) => {
        if (inMermaidBlock) {
            mermaid += '\r\n' + line
        }
        if (line === '```mermaid') {
            inMermaidBlock = true
            mermaid += line
        }
        if (line === '```') {
            mermaids.push(mermaid)
            mermaid = ''
            inMermaidBlock = false
        }
    })

    return mermaids
}

const request = async (
    dryRun: boolean,
    systemPrompt: string,
    description: string,
    mermaid: string
): Promise<Model[]> => {
    const params: OpenAI.Chat.ChatCompletionCreateParams = {
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
    }

    if (dryRun === false) {
        const openai = new OpenAI({
            apiKey: process.env.OPENAI_SECRET_KEY,
        })
        const chatCompletion: OpenAI.Chat.ChatCompletion =
            await openai.chat.completions.create(params)
        const content: string = chatCompletion.choices[0].message.content
        return JSON.parse(content).threats
    }
    console.log('GPT params:', params)
    return []
}

const appendNewModel = (model: Model[], rootModel: Model[]): Model[] => {
    if (rootModel.length !== 0) {
        const lastId: number = rootModel[rootModel.length - 1].id
        model.forEach((threat, index) => {
            index++
            threat.id = lastId + index
            rootModel.push(threat)
        })
        return rootModel
    }
    rootModel.push(...model)
    return rootModel
}

main()
