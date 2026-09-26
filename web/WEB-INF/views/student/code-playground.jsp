<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Code Playground (Online Compiler)" />
<c:set var="activeNav" value="dsa" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<!-- Local Ace Editor -->
<script src="${pageContext.request.contextPath}/assets/js/ace/ace.js"></script>

<style>
    .playground-container {
        max-width: 1400px;
        margin: 0 auto;
    }

    .editor-wrapper {
        border-radius: 16px;
        overflow: hidden;
        border: 1px solid rgba(226, 232, 240, 0.9);
        box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.08);
        background: #1e1e1e;
        display: flex;
        flex-direction: column;
        height: 100%;
        min-height: 590px;
    }

    .editor-header-bar {
        background: #18181b;
        padding: 10px 16px;
        border-bottom: 1px solid #27272a;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
    }

    .lang-pill-btn {
        background: transparent;
        color: #a1a1aa;
        border: 1px solid transparent;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .lang-pill-btn:hover {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.08);
    }

    .lang-pill-btn.active {
        color: #ffffff;
        background: #0071e3;
        border-color: #0071e3;
        box-shadow: 0 2px 8px rgba(0, 113, 227, 0.4);
    }

    #aceEditor {
        width: 100%;
        height: 480px;
        font-size: 14.5px;
        font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, Courier, monospace;
        line-height: 1.55;
    }

    #fallbackCodeEditor {
        width: 100%;
        height: 480px;
        background: #1e1e1e;
        color: #f8fafc;
        border: none;
        padding: 16px;
        font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, monospace;
        font-size: 14.5px;
        line-height: 1.55;
        resize: none;
        outline: none;
        display: none;
    }

    .terminal-console {
        background: #0d1117;
        color: #e6edf3;
        font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, monospace;
        font-size: 13.5px;
        line-height: 1.5;
        border-radius: 16px;
        border: 1px solid #30363d;
        overflow: hidden;
        box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        height: 100%;
        min-height: 590px;
    }

    .terminal-header {
        background: #161b22;
        padding: 10px 16px;
        border-bottom: 1px solid #30363d;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .terminal-output-body {
        padding: 16px;
        flex-grow: 1;
        overflow-y: auto;
        white-space: pre-wrap;
        word-break: break-word;
        max-height: 390px;
        min-height: 250px;
    }

    .terminal-stdin-box {
        background: #161b22;
        border-top: 1px solid #30363d;
        padding: 12px 16px;
    }

    .terminal-stdin-input {
        background: #0d1117;
        border: 1px solid #30363d;
        color: #58a6ff;
        font-family: inherit;
        font-size: 13px;
        border-radius: 8px;
        padding: 8px 12px;
        width: 100%;
        resize: vertical;
        min-height: 60px;
    }

    .terminal-stdin-input:focus {
        outline: none;
        border-color: #58a6ff;
        box-shadow: 0 0 0 2px rgba(88, 166, 255, 0.2);
    }

    .text-term-success {
        color: #3fb950;
    }

    .text-term-error {
        color: #f85149;
    }

    .text-term-info {
        color: #58a6ff;
    }

    .text-term-muted {
        color: #8b949e;
    }

    .btn-run-code {
        background: linear-gradient(135deg, #0071e3, #2563eb);
        color: #ffffff;
        font-weight: 700;
        font-size: 0.95rem;
        padding: 8px 24px;
        border-radius: 12px;
        border: none;
        box-shadow: 0 4px 14px rgba(0, 113, 227, 0.35);
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .btn-run-code:hover {
        background: linear-gradient(135deg, #0077ed, #1d4ed8);
        box-shadow: 0 6px 18px rgba(0, 113, 227, 0.45);
        transform: translateY(-1px);
        color: #ffffff;
    }

    .btn-run-code:disabled {
        opacity: 0.65;
        cursor: not-allowed;
        transform: none;
    }

    .btn-tool-icon {
        background: rgba(255, 255, 255, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.12);
        color: #e6edf3;
        border-radius: 8px;
        padding: 4px 10px;
        font-size: 0.78rem;
        cursor: pointer;
        transition: all 0.15s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .btn-tool-icon:hover {
        background: rgba(255, 255, 255, 0.18);
        color: #ffffff;
    }
</style>

<div class="container-fluid py-4">
    <div class="playground-container">
        
        <!-- Header & Breadcrumb -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="ios-badge ios-badge-blue">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                        Standalone Code Sandbox
                    </span>
                    <span class="ios-badge ios-badge-green">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                        Isolated Environment (Zero DB Impact)
                    </span>
                </div>
                <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">
                    In-Browser Interactive Code Playground
                </h1>
                <p class="text-muted small mb-0 mt-1">
                    Write, run, and debug algorithmic code instantly in Java, Python, C++, C, or JavaScript — no installation required.
                </p>
            </div>
            
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <select id="snippetSelector" class="form-control form-control-sm" style="width: auto; border-radius: 10px; font-weight: 600;" onchange="loadPresetSnippet(this.value)">
                    <option value="">⚡ Quick Starter Snippet...</option>
                    <option value="hello">Hello World</option>
                    <option value="twosum">Two Sum (Array Algorithm)</option>
                    <option value="fibonacci">Fibonacci Sequence (Recursion/DP)</option>
                    <option value="binarysearch">Binary Search (Sorted Array)</option>
                    <option value="reverse">Reverse String / Palindrome</option>
                </select>

                <a href="${pageContext.request.contextPath}/app/student/dsa" class="ios-btn-secondary" style="padding: 0.45rem 1rem; font-size: 0.85rem; border-radius: 10px;">
                    &larr; Back to DSA Tracker
                </a>
            </div>
        </div>

        <!-- Main IDE Grid: Left Editor & Right Output Console -->
        <div class="row">
            
            <!-- Code Editor Column -->
            <div class="col-lg-7 mb-4">
                <div class="editor-wrapper">
                    
                    <!-- Top Bar: Language Tabs & Controls -->
                    <div class="editor-header-bar">
                        <div class="d-flex align-items-center gap-2 flex-wrap">
                            <button type="button" class="lang-pill-btn active" id="tab-java" onclick="switchLanguage('java')">
                                ☕ Java
                            </button>
                            <button type="button" class="lang-pill-btn" id="tab-python" onclick="switchLanguage('python')">
                                🐍 Python
                            </button>
                            <button type="button" class="lang-pill-btn" id="tab-cpp" onclick="switchLanguage('cpp')">
                                ⚙️ C++
                            </button>
                            <button type="button" class="lang-pill-btn" id="tab-c" onclick="switchLanguage('c')">
                                🇨 C
                            </button>
                            <button type="button" class="lang-pill-btn" id="tab-javascript" onclick="switchLanguage('javascript')">
                                ⚡ JavaScript
                            </button>
                        </div>

                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn-tool-icon" onclick="resetToTemplate()" title="Reset to Starter Template">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path><path d="M3 3v5h5"></path></svg>
                                Reset
                            </button>
                            <button type="button" class="btn-tool-icon" onclick="copyCode()" title="Copy Code to Clipboard">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                                Copy
                            </button>
                        </div>
                    </div>

                    <!-- Primary Ace Code Editor -->
                    <div id="aceEditor"></div>

                    <!-- Direct Editable Fallback Textarea (in case Ace isn't loaded) -->
                    <textarea id="fallbackCodeEditor" placeholder="Type your code here..."></textarea>

                    <!-- Editor Bottom Bar with Shortcut Tip & Run Button -->
                    <div class="d-flex justify-content-between align-items-center p-3 mt-auto" style="background: #18181b; border-top: 1px solid #27272a;">
                        <span class="text-term-muted small d-none d-sm-inline">
                            Tip: Press <kbd style="background: #27272a; color: #e4e4e7; padding: 2px 6px; border-radius: 4px; font-size: 0.75rem;">Ctrl + Enter</kbd> to Run Code
                        </span>

                        <div class="d-flex align-items-center gap-2 ml-auto">
                            <button type="button" class="btn-run-code" id="runCodeBtn" onclick="runCurrentCode()">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                                <span>Run Code</span>
                            </button>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Terminal Output & Custom Input Column -->
            <div class="col-lg-5 mb-4">
                <div class="terminal-console">
                    
                    <!-- Terminal Header Bar -->
                    <div class="terminal-header">
                        <div class="d-flex align-items-center gap-2">
                            <div class="d-flex gap-1 mr-2">
                                <span style="width: 10px; height: 10px; border-radius: 50%; background: #ff5f56; display: inline-block;"></span>
                                <span style="width: 10px; height: 10px; border-radius: 50%; background: #ffbd2e; display: inline-block;"></span>
                                <span style="width: 10px; height: 10px; border-radius: 50%; background: #27c93f; display: inline-block;"></span>
                            </div>
                            <span class="font-weight-bold small text-term-muted" style="letter-spacing: 0.05em; text-transform: uppercase;">
                                Console Output
                            </span>
                        </div>

                        <div class="d-flex align-items-center gap-2">
                            <span id="execMetricsPill" class="badge badge-secondary small" style="background: #21262d; color: #8b949e; border: 1px solid #30363d; display: none;">
                                0 ms
                            </span>
                            <button type="button" class="btn-tool-icon" onclick="clearConsoleOutput()" title="Clear Terminal Console">
                                Clear
                            </button>
                        </div>
                    </div>

                    <!-- Terminal Output Window -->
                    <div class="terminal-output-body" id="terminalOutput">
<span class="text-term-info">⚡ SkillTrack Interactive Code Sandbox Ready</span>
<span class="text-term-muted">Select your language, write your code, and click "Run Code".
---------------------------------------------------------</span>
<span class="text-term-success">Output will appear here.</span></div>

                    <!-- Custom STDIN Input Box -->
                    <div class="terminal-stdin-box">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="small font-weight-bold text-term-muted mb-0" for="stdinInput" style="font-size: 0.78rem;">
                                Custom Input (stdin):
                            </label>
                            <span class="text-term-muted" style="font-size: 0.72rem;">Optional parameters / test values</span>
                        </div>
                        <textarea id="stdinInput" class="terminal-stdin-input" placeholder="e.g. 5 10&#10;Alice&#10;1 2 3 4 5" rows="2"></textarea>
                    </div>

                </div>
            </div>

        </div>

    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
<%@ include file="/WEB-INF/views/common/ai-floating-widget.jspf" %>

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

    // Preset algorithms snippets
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
        System.out.println("Indices: [" + result[0] + ", " + result[1] + "]");
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
print("Indices:", two_sum(nums, target))`,
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
    cout << "Indices: [" << res[0] << ", " << res[1] << "]" << endl;
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
                printf("Indices: [%d, %d]\\n", i, j);
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
console.log("Indices:", twoSum([2, 7, 11, 15], 9));`
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
        for (int i = 0; i <= 10; i++) {
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

print("First 10 Fib Numbers:", fibonacci(10))`,
            cpp: `#include <iostream>
using namespace std;

int main() {
    int a = 0, b = 1, n = 10;
    cout << "Fibonacci: ";
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
    printf("Fibonacci: ");
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
console.log("Fibonacci:", fib(10).join(" "));`
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
print("Index of 7:", binary_search(arr, 7))`,
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
    cout << "Index of 7: " << binarySearch(arr, 7) << endl;
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
    printf("Index of 7: %d\\n", binarySearch(arr, size, 7));
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
console.log("Index of 7:", binarySearch([1, 3, 5, 7, 9, 11, 13, 15], 7));`
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
                    fontSize: "14.5px",
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
        if (out) out.innerHTML = '<span class="text-term-muted">Console cleared.</span>';
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
            outputEl.innerHTML = '<span class="text-term-error">Error: Code editor is empty. Please enter code to run.</span>';
            return;
        }

        // Show Running state
        runBtn.disabled = true;
        runBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> <span>Running...</span>';
        outputEl.innerHTML = '<span class="text-term-info">⏳ Compiling and executing in sandbox...</span>';

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
                formattedHtml += '<span class="text-term-success">' + escapeHtml(data.stdout) + '</span>';
            }

            if (data.stderr && data.stderr.trim().length > 0) {
                if (formattedHtml.length > 0) formattedHtml += '\n';
                formattedHtml += '<span class="text-term-error">' + escapeHtml(data.stderr) + '</span>';
            }

            if (!data.stdout && !data.stderr) {
                formattedHtml = '<span class="text-term-muted">(Program completed with no terminal output)</span>';
            }

            // Append status footer
            formattedHtml += '\n<span class="text-term-muted">---------------------------------------------------------</span>\n';
            if (data.success) {
                formattedHtml += '<span class="text-term-success">✓ ' + escapeHtml(data.statusMessage || 'Execution Finished Successfully') + '</span>';
            } else {
                formattedHtml += '<span class="text-term-error">✗ ' + escapeHtml(data.statusMessage || 'Execution Failed') + ' (Exit: ' + data.exitCode + ')</span>';
            }

            outputEl.innerHTML = formattedHtml;
        })
        .catch(err => {
            console.error('Playground Execution Error:', err);
            outputEl.innerHTML = '<span class="text-term-error">Execution Error: ' + escapeHtml(err.message) + '</span>\n' +
                                 '<span class="text-term-muted">Please verify server connectivity or syntax.</span>';
        })
        .finally(() => {
            runBtn.disabled = false;
            runBtn.innerHTML = '<svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg> <span>Run Code</span>';
        });
    }
</script>
