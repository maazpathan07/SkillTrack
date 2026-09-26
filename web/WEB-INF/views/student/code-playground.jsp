<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Code Playground (Online Compiler)" />
<c:set var="activeNav" value="dsa" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<!-- JetBrains Mono Programming Font for Ultra-Crisp Code Rendering -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Local Ace Editor -->
<script src="${pageContext.request.contextPath}/assets/js/ace/ace.js"></script>

<style>
    :root {
        --code-font: 'JetBrains Mono', 'Fira Code', 'Cascadia Code', 'SFMono-Regular', Consolas, Menlo, monospace;
    }

    .playground-page-wrapper {
        max-width: 1440px;
        margin: 0 auto;
        padding-bottom: 2rem;
    }

    /* Page Header */
    .playground-header-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.8);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.25rem;
    }

    /* Unified Dual-Column IDE Layout */
    .ide-container {
        display: flex;
        flex-direction: column;
        gap: 1.25rem;
    }

    @media (min-width: 992px) {
        .ide-container {
            flex-direction: row;
            align-items: stretch;
            height: calc(100vh - 235px);
            min-height: 580px;
            max-height: 750px;
        }
    }

    .ide-column-editor {
        flex: 1.25;
        display: flex;
        flex-direction: column;
        min-width: 0;
    }

    .ide-column-terminal {
        flex: 0.95;
        display: flex;
        flex-direction: column;
        min-width: 0;
    }

    /* Editor Card */
    .editor-card {
        background: #1e1e24;
        border: 1px solid #2d2d38;
        border-radius: 16px;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        height: 100%;
        box-shadow: 0 12px 36px -4px rgba(0, 0, 0, 0.25);
    }

    .editor-topbar {
        background: #16161c;
        border-bottom: 1px solid #272732;
        padding: 8px 12px;
        display: flex;
        flex-wrap: nowrap;
        align-items: center;
        justify-content: space-between;
        gap: 8px;
        overflow-x: auto;
        white-space: nowrap;
        scrollbar-width: none;
    }
    .editor-topbar::-webkit-scrollbar {
        display: none;
    }

    /* Language Pills */
    .lang-tabs-group {
        display: inline-flex;
        align-items: center;
        gap: 3px;
        background: #0f0f13;
        padding: 3px 4px;
        border-radius: 10px;
        border: 1px solid #272732;
        flex-shrink: 0;
    }

    .lang-pill-btn {
        background: transparent;
        color: #94a3b8;
        border: none;
        padding: 4px 10px;
        border-radius: 7px;
        font-size: 0.8rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.18s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        font-family: inherit;
        line-height: 1.2;
        white-space: nowrap;
    }

    .lang-pill-btn svg {
        flex-shrink: 0;
        transition: transform 0.18s ease;
    }

    .lang-pill-btn:hover {
        color: #f1f5f9;
        background: rgba(255, 255, 255, 0.06);
    }

    .lang-pill-btn.active {
        color: #ffffff;
        background: #0071e3;
        box-shadow: 0 2px 10px rgba(0, 113, 227, 0.45);
    }

    .lang-pill-btn.active svg {
        transform: scale(1.08);
    }

    /* Editor Body */
    .editor-body-container {
        position: relative;
        flex: 1;
        min-height: 380px;
        background: #18181f;
    }

    #aceEditor {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        font-size: 14px;
        font-family: var(--code-font);
        line-height: 1.6;
    }

    #fallbackCodeEditor {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: #18181f;
        color: #f8fafc;
        border: none;
        padding: 16px;
        font-family: var(--code-font);
        font-size: 14px;
        line-height: 1.6;
        resize: none;
        outline: none;
        display: none;
    }

    /* Editor Footer Bar */
    .editor-bottombar {
        background: #16161c;
        border-top: 1px solid #272732;
        padding: 10px 16px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
    }

    /* Terminal Console Card */
    .terminal-card {
        background: #0d1117;
        border: 1px solid #30363d;
        border-radius: 16px;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        height: 100%;
        box-shadow: 0 12px 36px -4px rgba(0, 0, 0, 0.3);
    }

    .terminal-topbar {
        background: #161b22;
        border-bottom: 1px solid #30363d;
        padding: 10px 14px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
    }

    .mac-window-dots {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .mac-dot {
        width: 11px;
        height: 11px;
        border-radius: 50%;
        display: inline-block;
    }

    .mac-dot-red { background: #ff5f56; box-shadow: 0 0 6px rgba(255, 95, 86, 0.4); }
    .mac-dot-yellow { background: #ffbd2e; box-shadow: 0 0 6px rgba(255, 189, 46, 0.4); }
    .mac-dot-green { background: #27c93f; box-shadow: 0 0 6px rgba(39, 201, 63, 0.4); }

    .terminal-title-text {
        font-size: 0.76rem;
        font-weight: 700;
        letter-spacing: 0.08em;
        text-transform: uppercase;
        color: #8b949e;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* Terminal Body */
    .terminal-screen-body {
        flex: 1;
        padding: 16px;
        overflow-y: auto;
        font-family: var(--code-font);
        font-size: 13.5px;
        line-height: 1.55;
        white-space: pre-wrap;
        word-break: break-word;
        color: #e6edf3;
        background: #090d13;
        min-height: 220px;
    }

    /* Custom Input (stdin) Panel */
    .terminal-stdin-wrapper {
        background: #161b22;
        border-top: 1px solid #30363d;
        padding: 10px 14px;
    }

    .stdin-header-toggle {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 6px;
    }

    .stdin-label {
        font-size: 0.78rem;
        font-weight: 700;
        color: #8b949e;
        display: flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 0;
    }

    .stdin-textarea {
        background: #0d1117;
        border: 1px solid #30363d;
        color: #58a6ff;
        font-family: var(--code-font);
        font-size: 12.5px;
        border-radius: 8px;
        padding: 6px 10px;
        width: 100%;
        resize: none;
        height: 52px;
        transition: all 0.15s ease;
    }

    .stdin-textarea:focus {
        outline: none;
        border-color: #58a6ff;
        box-shadow: 0 0 0 2px rgba(88, 166, 255, 0.15);
        background: #090d13;
    }

    /* Terminal Colors */
    .term-text-green { color: #38ef7d; font-weight: 500; }
    .term-text-red { color: #ff5252; font-weight: 500; }
    .term-text-blue { color: #58a6ff; }
    .term-text-gray { color: #7d8590; }
    .term-divider { color: #30363d; user-select: none; }

    /* Action Buttons */
    .btn-run-code-action {
        background: linear-gradient(135deg, #0071e3, #1d4ed8);
        color: #ffffff;
        font-weight: 700;
        font-size: 0.9rem;
        padding: 7px 22px;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 14px rgba(0, 113, 227, 0.4);
        display: inline-flex;
        align-items: center;
        gap: 7px;
        transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
        cursor: pointer;
    }

    .btn-run-code-action:hover {
        background: linear-gradient(135deg, #0077ed, #2563eb);
        box-shadow: 0 6px 20px rgba(0, 113, 227, 0.55);
        transform: translateY(-1px);
        color: #ffffff;
    }

    .btn-run-code-action:active {
        transform: translateY(0);
    }

    .btn-run-code-action:disabled {
        opacity: 0.65;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
    }

    .btn-dark-icon {
        background: rgba(255, 255, 255, 0.07);
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #cbd5e1;
        border-radius: 8px;
        padding: 4px 10px;
        font-size: 0.78rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.15s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .btn-dark-icon:hover {
        background: rgba(255, 255, 255, 0.16);
        color: #ffffff;
        border-color: rgba(255, 255, 255, 0.2);
    }

    .snippet-select-dark {
        background: #1e1e24;
        color: #e2e8f0;
        border: 1px solid #374151;
        border-radius: 8px;
        padding: 4px 10px;
        font-size: 0.8rem;
        font-weight: 600;
        outline: none;
        cursor: pointer;
        transition: border-color 0.15s ease;
    }

    .snippet-select-dark:focus {
        border-color: #0071e3;
        box-shadow: 0 0 0 2px rgba(0, 113, 227, 0.2);
    }

    .status-badge-pill {
        font-family: var(--code-font);
        font-size: 0.72rem;
        font-weight: 600;
        padding: 2px 8px;
        border-radius: 6px;
        background: #21262d;
        color: #7ee787;
        border: 1px solid #30363d;
        display: none;
    }
</style>

<div class="container-fluid py-3 playground-page-wrapper">
    
    <!-- Top Header Card -->
    <div class="playground-header-card">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                    <span class="ios-badge ios-badge-blue">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                        Standalone Code Sandbox
                    </span>
                    <span class="ios-badge ios-badge-green">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                        Zero DB Impact (Pure Utility)
                    </span>
                </div>
                <h1 class="h4 font-weight-bold text-gray-900 mb-0" style="letter-spacing: -0.02em;">
                    In-Browser Interactive Code Playground
                </h1>
                <p class="text-muted small mb-0 mt-1">
                    Write, compile, and execute algorithmic programs in Java, Python, C++, C, or JavaScript with instant terminal feedback.
                </p>
            </div>

            <div class="d-flex align-items-center gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/app/student/dsa" class="ios-btn-secondary" style="padding: 0.45rem 1rem; font-size: 0.85rem; border-radius: 10px; text-decoration: none;">
                    &larr; Back to DSA Tracker
                </a>
            </div>
        </div>
    </div>

    <!-- Main Dual-Column IDE Layout -->
    <div class="ide-container">
        
        <!-- Left: Code Editor Window -->
        <div class="ide-column-editor">
            <div class="editor-card">
                
                <!-- Editor Header: Language Tabs & Quick Tools -->
                <div class="editor-topbar">
                    <!-- Language Selection Tabs -->
                    <div class="lang-tabs-group">
                        <!-- Java -->
                        <button type="button" class="lang-pill-btn active" id="tab-java" onclick="switchLanguage('java')" title="Java 15+">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
                            <span>Java</span>
                        </button>

                        <!-- Python -->
                        <button type="button" class="lang-pill-btn" id="tab-python" onclick="switchLanguage('python')" title="Python 3.10+">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="m4.93 4.93 4.24 4.24"></path><path d="m14.83 9.17 4.24-4.24"></path><path d="m14.83 14.83 4.24 4.24"></path><path d="m9.17 14.83-4.24 4.24"></path></svg>
                            <span>Python</span>
                        </button>

                        <!-- C++ -->
                        <button type="button" class="lang-pill-btn" id="tab-cpp" onclick="switchLanguage('cpp')" title="C++ (GCC/MinGW)">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>
                            <span>C++</span>
                        </button>

                        <!-- C -->
                        <button type="button" class="lang-pill-btn" id="tab-c" onclick="switchLanguage('c')" title="C (GCC/MinGW)">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="M15 9.5a4 4 0 1 0 0 5"></path></svg>
                            <span>C</span>
                        </button>

                        <!-- JavaScript -->
                        <button type="button" class="lang-pill-btn" id="tab-javascript" onclick="switchLanguage('javascript')" title="JavaScript (Node.js)">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                            <span>JavaScript</span>
                        </button>
                    </div>

                    <!-- Right Quick Tools -->
                    <div class="d-flex align-items-center gap-2 flex-shrink-0">
                        <select id="snippetSelector" class="snippet-select-dark" onchange="loadPresetSnippet(this.value)" style="max-width: 155px;">
                            <option value="">⚡ Templates...</option>
                            <option value="hello">Hello World</option>
                            <option value="twosum">Two Sum</option>
                            <option value="binarysearch">Binary Search</option>
                            <option value="fibonacci">Fibonacci</option>
                            <option value="reverse">String Reversal</option>
                        </select>

                        <button type="button" class="btn-dark-icon" onclick="resetToTemplate()" title="Reset to Starter Template">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path><path d="M3 3v5h5"></path></svg>
                            <span>Reset</span>
                        </button>
                        <button type="button" class="btn-dark-icon" onclick="copyCode()" title="Copy Code to Clipboard">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                            <span>Copy</span>
                        </button>
                    </div>
                </div>

                <!-- Ace Code Editor Surface -->
                <div class="editor-body-container">
                    <div id="aceEditor"></div>
                    <textarea id="fallbackCodeEditor" placeholder="Type your code here..."></textarea>
                </div>

                <!-- Editor Bottom Action Bar -->
                <div class="editor-bottombar">
                    <span class="term-text-gray small d-none d-sm-inline">
                        Press <kbd style="background: #272732; color: #e4e4e7; padding: 2px 6px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #374151;">Ctrl + Enter</kbd> to execute
                    </span>

                    <button type="button" class="btn-run-code-action ml-auto" id="runCodeBtn" onclick="runCurrentCode()">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                        <span>Run Code</span>
                    </button>
                </div>

            </div>
        </div>

        <!-- Right: Terminal Output & Console Window -->
        <div class="ide-column-terminal">
            <div class="terminal-card">
                
                <!-- Terminal Top Bar -->
                <div class="terminal-topbar">
                    <div class="d-flex align-items-center gap-2">
                        <!-- macOS Window Dots -->
                        <div class="mac-window-dots mr-1">
                            <span class="mac-dot mac-dot-red"></span>
                            <span class="mac-dot mac-dot-yellow"></span>
                            <span class="mac-dot mac-dot-green"></span>
                        </div>
                        <span class="terminal-title-text">
                            Console Output
                        </span>
                    </div>

                    <div class="d-flex align-items-center gap-2">
                        <span id="execMetricsPill" class="status-badge-pill">
                            0 ms
                        </span>
                        <button type="button" class="btn-dark-icon" onclick="clearConsoleOutput()" title="Clear Console">
                            Clear
                        </button>
                    </div>
                </div>

                <!-- Terminal Execution Screen -->
                <div class="terminal-screen-body" id="terminalOutput"><span class="term-text-blue">⚡ SkillTrack Interactive Code Sandbox Ready</span>
<span class="term-text-gray">Select your language, write your code, and click "Run Code".</span>
<span class="term-divider">---------------------------------------------------------</span>
<span class="term-text-green">Output will appear here.</span></div>

                <!-- Custom Input (stdin) Box -->
                <div class="terminal-stdin-wrapper">
                    <div class="stdin-header-toggle">
                        <label class="stdin-label" for="stdinInput">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                            Custom Input (stdin)
                        </label>
                        <span class="term-text-gray" style="font-size: 0.72rem;">Optional values for standard input</span>
                    </div>
                    <textarea id="stdinInput" class="stdin-textarea" placeholder="e.g. 5 10 (Space or newline separated)"></textarea>
                </div>

            </div>
        </div>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>

<script>
    // Templates for various languages
    const CODE_TEMPLATES = {
        java: `public class Main {
    public static void main(String[] args) {
        System.out.println("Hello SkillTrack!");
    }
}`,
        python: `# Python 3 Program
def main():
    print("Hello SkillTrack from Python!")

if __name__ == "__main__":
    main()`,
        cpp: `#include <iostream>
using namespace std;

int main() {
    cout << "Hello SkillTrack from C++!" << endl;
    return 0;
}`,
        c: `#include <stdio.h>

int main() {
    printf("Hello SkillTrack from C!\\n");
    return 0;
}`,
        javascript: `// JavaScript (Node.js) Program
function greet(name) {
    return "Hello " + name + "! Welcome to SkillTrack.";
}

console.log(greet("SkillTrack Developer"));`
    };

    // Preset algorithm snippets
    const PRESET_SNIPPETS = {
        hello: {
            java: `public class Main {
    public static void main(String[] args) {
        System.out.println("Hello SkillTrack!");
    }
}`,
            python: `print("Hello SkillTrack!")`,
            cpp: `#include <iostream>
using namespace std;
int main() {
    cout << "Hello SkillTrack!" << endl;
    return 0;
}`,
            c: `#include <stdio.h>
int main() {
    printf("Hello SkillTrack!\\n");
    return 0;
}`,
            javascript: `console.log("Hello SkillTrack!");`
        },
        twosum: {
            java: `import java.util.*;

public class Main {
    public static int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                return new int[] { map.get(complement), i };
            }
            map.put(nums[i], i);
        }
        return new int[0];
    }

    public static void main(String[] args) {
        int[] nums = {2, 7, 11, 15};
        int target = 9;
        int[] result = twoSum(nums, target);
        System.out.println("Target: " + target);
        System.out.println("Result Indices: [" + result[0] + ", " + result[1] + "]");
    }
}`,
            python: `def two_sum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        diff = target - num
        if diff in seen:
            return [seen[diff], i]
        seen[num] = i
    return []

nums = [2, 7, 11, 15]
target = 9
print("Target:", target)
print("Result Indices:", two_sum(nums, target))`,
            cpp: `#include <iostream>
#include <vector>
#include <unordered_map>
using namespace std;

vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> map;
    for (int i = 0; i < nums.size(); i++) {
        int complement = target - nums[i];
        if (map.find(complement) != map.end()) {
            return {map[complement], i};
        }
        map[nums[i]] = i;
    }
    return {};
}

int main() {
    vector<int> nums = {2, 7, 11, 15};
    int target = 9;
    vector<int> res = twoSum(nums, target);
    cout << "Target: " << target << endl;
    cout << "Result Indices: [" << res[0] << ", " << res[1] << "]" << endl;
    return 0;
}`,
            c: `#include <stdio.h>

int main() {
    int nums[] = {2, 7, 11, 15};
    int target = 9;
    int n = 4;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (nums[i] + nums[j] == target) {
                printf("Target: %d\\n", target);
                printf("Result Indices: [%d, %d]\\n", i, j);
                return 0;
            }
        }
    }
    return 0;
}`,
            javascript: `function twoSum(nums, target) {
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        const comp = target - nums[i];
        if (map.has(comp)) return [map.get(comp), i];
        map.set(nums[i], i);
    }
    return [];
}
console.log("Target: 9");
console.log("Result Indices:", twoSum([2, 7, 11, 15], 9));`
        },
        binarysearch: {
            java: `public class Main {
    public static int binarySearch(int[] arr, int target) {
        int low = 0, high = arr.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (arr[mid] == target) return mid;
            if (arr[mid] < target) low = mid + 1;
            else high = mid - 1;
        }
        return -1;
    }

    public static void main(String[] args) {
        int[] arr = {1, 3, 5, 7, 9, 11, 13, 15};
        int target = 7;
        int idx = binarySearch(arr, target);
        System.out.println("Array: [1, 3, 5, 7, 9, 11, 13, 15]");
        System.out.println("Element " + target + " found at index: " + idx);
    }
}`,
            python: `def binary_search(arr, target):
    low, high = 0, len(arr) - 1
    while low <= high:
        mid = (low + high) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            low = mid + 1
        else:
            high = mid - 1
    return -1

arr = [1, 3, 5, 7, 9, 11, 13, 15]
target = 7
print("Array:", arr)
print(f"Element {target} found at index:", binary_search(arr, target))`,
            cpp: `#include <iostream>
#include <vector>
using namespace std;

int binarySearch(const vector<int>& arr, int target) {
    int low = 0, high = arr.size() - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] == target) return mid;
        if (arr[mid] < target) low = mid + 1;
        else high = mid - 1;
    }
    return -1;
}

int main() {
    vector<int> arr = {1, 3, 5, 7, 9, 11, 13, 15};
    int target = 7;
    int idx = binarySearch(arr, target);
    cout << "Array: [1, 3, 5, 7, 9, 11, 13, 15]" << endl;
    cout << "Element " << target << " found at index: " << idx << endl;
    return 0;
}`,
            c: `#include <stdio.h>

int binarySearch(int arr[], int size, int target) {
    int low = 0, high = size - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] == target) return mid;
        if (arr[mid] < target) low = mid + 1;
        else high = mid - 1;
    }
    return -1;
}

int main() {
    int arr[] = {1, 3, 5, 7, 9, 11, 13, 15};
    int size = 8;
    int target = 7;
    int idx = binarySearch(arr, size, target);
    printf("Array: [1, 3, 5, 7, 9, 11, 13, 15]\\n");
    printf("Element %d found at index: %d\\n", target, idx);
    return 0;
}`,
            javascript: `function binarySearch(arr, target) {
    let low = 0, high = arr.length - 1;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (arr[mid] === target) return mid;
        if (arr[mid] < target) low = mid + 1;
        else high = mid - 1;
    }
    return -1;
}
const arr = [1, 3, 5, 7, 9, 11, 13, 15];
console.log("Array:", arr);
console.log("Element 7 found at index:", binarySearch(arr, 7));`
        },
        fibonacci: {
            java: `public class Main {
    public static int fib(int n) {
        if (n <= 1) return n;
        int a = 0, b = 1;
        for (int i = 2; i <= n; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        return b;
    }

    public static void main(String[] args) {
        System.out.print("First 10 Fibonacci numbers: ");
        for (int i = 0; i < 10; i++) {
            System.out.print(fib(i) + " ");
        }
        System.out.println();
    }
}`,
            python: `def fibonacci(n):
    a, b = 0, 1
    result = []
    for _ in range(n):
        result.append(a)
        a, b = b, a + b
    return result

print("First 10 Fibonacci numbers:", fibonacci(10))`,
            cpp: `#include <iostream>
using namespace std;

int main() {
    int a = 0, b = 1, n = 10;
    cout << "First 10 Fibonacci numbers: ";
    for (int i = 0; i < n; i++) {
        cout << a << " ";
        int next = a + b;
        a = b;
        b = next;
    }
    cout << endl;
    return 0;
}`,
            c: `#include <stdio.h>

int main() {
    int a = 0, b = 1, n = 10;
    printf("First 10 Fibonacci numbers: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", a);
        int next = a + b;
        a = b;
        b = next;
    }
    printf("\\n");
    return 0;
}`,
            javascript: `function fib(n) {
    let a = 0, b = 1, res = [];
    for (let i = 0; i < n; i++) {
        res.push(a);
        [a, b] = [b, a + b];
    }
    return res;
}
console.log("First 10 Fibonacci numbers:", fib(10).join(" "));`
        },
        reverse: {
            java: `public class Main {
    public static void main(String[] args) {
        String str = "SkillTrack Placement";
        String rev = new StringBuilder(str).reverse().toString();
        System.out.println("Original: " + str);
        System.out.println("Reversed: " + rev);
    }
}`,
            python: `text = "SkillTrack Placement"
print("Original:", text)
print("Reversed:", text[::-1])`,
            cpp: `#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

int main() {
    string str = "SkillTrack Placement";
    cout << "Original: " << str << endl;
    reverse(str.begin(), str.end());
    cout << "Reversed: " << str << endl;
    return 0;
}`,
            c: `#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "SkillTrack Placement";
    int n = strlen(str);
    printf("Original: %s\\n", str);
    printf("Reversed: ");
    for (int i = n - 1; i >= 0; i--) {
        putchar(str[i]);
    }
    printf("\\n");
    return 0;
}`,
            javascript: `const str = "SkillTrack Placement";
console.log("Original:", str);
console.log("Reversed:", str.split("").reverse().join(""));`
        }
    };

    let currentLanguage = 'java';
    let editor = null;

    // Initialize Ace Editor with local files and fallback
    document.addEventListener("DOMContentLoaded", function() {
        const fallbackTextarea = document.getElementById('fallbackCodeEditor');
        const aceDiv = document.getElementById('aceEditor');

        if (window.ace) {
            try {
                ace.config.set('basePath', '${pageContext.request.contextPath}/assets/js/ace');
                editor = ace.edit("aceEditor");
                editor.setTheme("ace/theme/tomorrow_night");
                editor.session.setMode("ace/mode/java");
                editor.setValue(CODE_TEMPLATES.java, -1);
                editor.setShowPrintMargin(false);
                editor.setOptions({
                    enableBasicAutocompletion: true,
                    enableLiveAutocompletion: true,
                    enableSnippets: true,
                    fontSize: "14px",
                    fontFamily: "'JetBrains Mono', Consolas, monospace",
                    tabSize: 4,
                    useSoftTabs: true
                });

                // Keyboard shortcut: Ctrl+Enter / Cmd+Enter to Run
                editor.commands.addCommand({
                    name: 'runCode',
                    bindKey: { win: 'Ctrl-Enter', mac: 'Command-Enter' },
                    exec: function() {
                        runCurrentCode();
                    }
                });

                aceDiv.style.display = 'block';
                if (fallbackTextarea) fallbackTextarea.style.display = 'none';
            } catch (e) {
                console.warn("Ace init error, switching to native editor:", e);
                initFallback();
            }
        } else {
            initFallback();
        }

        function initFallback() {
            if (aceDiv) aceDiv.style.display = 'none';
            if (fallbackTextarea) {
                fallbackTextarea.style.display = 'block';
                fallbackTextarea.value = CODE_TEMPLATES.java;
                fallbackTextarea.addEventListener('keydown', function(e) {
                    if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
                        e.preventDefault();
                        runCurrentCode();
                    }
                });
            }
        }
    });

    function getEditorCode() {
        if (editor) {
            return editor.getValue();
        }
        const fallbackTextarea = document.getElementById('fallbackCodeEditor');
        return fallbackTextarea ? fallbackTextarea.value : '';
    }

    function setEditorCode(code) {
        if (editor) {
            editor.setValue(code, -1);
        }
        const fallbackTextarea = document.getElementById('fallbackCodeEditor');
        if (fallbackTextarea) {
            fallbackTextarea.value = code;
        }
    }

    function switchLanguage(lang) {
        currentLanguage = lang;

        // Update Tab UI
        document.querySelectorAll('.lang-pill-btn').forEach(btn => btn.classList.remove('active'));
        const activeBtn = document.getElementById('tab-' + lang);
        if (activeBtn) activeBtn.classList.add('active');

        // Set Ace Editor mode & template
        const templateCode = CODE_TEMPLATES[lang] || "";
        if (editor) {
            let mode = "ace/mode/java";
            if (lang === 'python') mode = "ace/mode/python";
            else if (lang === 'cpp' || lang === 'c') mode = "ace/mode/c_cpp";
            else if (lang === 'javascript') mode = "ace/mode/javascript";

            editor.session.setMode(mode);
            editor.setValue(templateCode, -1);
        } else {
            setEditorCode(templateCode);
        }
    }

    function resetToTemplate() {
        const templateCode = CODE_TEMPLATES[currentLanguage] || "";
        setEditorCode(templateCode);
    }

    function loadPresetSnippet(snippetKey) {
        if (!snippetKey || !PRESET_SNIPPETS[snippetKey]) return;
        const snippetObj = PRESET_SNIPPETS[snippetKey];
        if (snippetObj[currentLanguage]) {
            setEditorCode(snippetObj[currentLanguage]);
        }
    }

    function copyCode() {
        const code = getEditorCode();
        if (!code) return;
        navigator.clipboard.writeText(code).then(() => {
            alert("Code copied to clipboard!");
        }).catch(err => {
            console.error("Clipboard copy failed", err);
        });
    }

    function clearConsoleOutput() {
        const out = document.getElementById('terminalOutput');
        if (out) out.innerHTML = '<span class="term-text-gray">Console cleared.</span>';
        const pill = document.getElementById('execMetricsPill');
        if (pill) pill.style.display = 'none';
    }

    function escapeHtml(text) {
        if (!text) return '';
        return text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function runCurrentCode() {
        const code = getEditorCode();
        const stdin = document.getElementById('stdinInput') ? document.getElementById('stdinInput').value : '';
        const runBtn = document.getElementById('runCodeBtn');
        const outputEl = document.getElementById('terminalOutput');
        const pill = document.getElementById('execMetricsPill');

        if (!code || code.trim() === '') {
            outputEl.innerHTML = '<span class="term-text-red">Error: Code editor is empty. Please enter code to run.</span>';
            return;
        }

        // Show Running state
        runBtn.disabled = true;
        runBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> <span>Running...</span>';
        outputEl.innerHTML = '<span class="term-text-blue">⏳ Compiling and executing in sandbox...</span>';

        const startTime = Date.now();

        fetch('${pageContext.request.contextPath}/app/student/playground', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                'X-CSRF-Token': '${sessionScope.CSRF_TOKEN}'
            },
            body: new URLSearchParams({
                csrfToken: '${sessionScope.CSRF_TOKEN}',
                language: currentLanguage,
                sourceCode: code,
                stdin: stdin
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Server returned status: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            const timeMs = data.executionTimeMs || (Date.now() - startTime);
            pill.style.display = 'inline-block';
            pill.textContent = timeMs + ' ms';

            let formattedHtml = '';

            if (data.stdout && data.stdout.trim().length > 0) {
                formattedHtml += '<span class="term-text-green">' + escapeHtml(data.stdout) + '</span>';
            }

            if (data.stderr && data.stderr.trim().length > 0) {
                if (formattedHtml.length > 0) formattedHtml += '\n';
                formattedHtml += '<span class="term-text-red">' + escapeHtml(data.stderr) + '</span>';
            }

            if (!data.stdout && !data.stderr) {
                formattedHtml = '<span class="term-text-gray">(Program completed with no terminal output)</span>';
            }

            // Append status footer
            formattedHtml += '\n<span class="term-divider">---------------------------------------------------------</span>\n';
            if (data.success) {
                formattedHtml += '<span class="term-text-green">✓ ' + escapeHtml(data.statusMessage || 'Execution Finished Successfully') + '</span>';
            } else {
                formattedHtml += '<span class="term-text-red">✗ ' + escapeHtml(data.statusMessage || 'Execution Failed') + ' (Exit: ' + data.exitCode + ')</span>';
            }

            outputEl.innerHTML = formattedHtml;
        })
        .catch(err => {
            console.error('Playground Execution Error:', err);
            outputEl.innerHTML = '<span class="term-text-red">Execution Error: ' + escapeHtml(err.message) + '</span>\n' +
                                 '<span class="term-text-gray">Please verify server connectivity or syntax.</span>';
        })
        .finally(() => {
            runBtn.disabled = false;
            runBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg> <span>Run Code</span>';
        });
    }
</script>
