"use strict";
// ==UserScript==
// @name         Obsidian Omnisearch in DuckDuckGo
// @namespace    https://github.com/scambier/userscripts
// @downloadURL  https://github.com/scambier/userscripts/raw/master/dist/obsidian-omnisearch-ddg.user.js
// @updateURL    https://github.com/scambier/userscripts/raw/master/dist/obsidian-omnisearch-ddg.user.js
// @version      0.1.0
// @description  Injects Obsidian notes in DuckDuckGo search results
// @author       Simon Cambier
// @match        https://duckduckgo.com/*
// @match        https://www.duckduckgo.com/*
// @icon         https://obsidian.md/favicon.ico
// @require      https://code.jquery.com/jquery-3.7.1.min.js
// @require      https://gist.githubusercontent.com/scambier/109932d45b7592d3decf24194008be4d/raw/9c97aa67ff9c5d56be34a55ad6c18a314e5eb548/waitForKeyElements.js
// @require      https://cdn.jsdelivr.net/npm/vue@3
// @require      https://raw.githubusercontent.com/sizzlemctwizzle/GM_config/master/gm_config.js
// @grant        GM.xmlHttpRequest
// @grant        GM_getValue
// @grant        GM_setValue
// @grant        GM.getValue
// @grant        GM.setValue
// ==/UserScript==
/* globals GM_config, jQuery, $, waitForKeyElements */
(function () {
    "use strict";
    // The right sidebar that will contain the results div
    const sidebarSelector = '[data-area="sidebar"]';
    // The results div
    const resultsDivId = "OmnisearchObsidianResults";
    // The "loading"/"no results" label
    const loadingSpanId = "OmnisearchObsidianLoading";
    // The `new GM_config()` syntax is not recognized by the TS compiler
    // @ts-ignore
    const gmc = new GM_config({
        id: "ObsidianOmnisearchDdg",
        title: "Omnisearch in DuckDuckGo - Configuration",
        fields: {
            port: {
                label: "HTTP Port",
                type: "text",
                default: "51361",
            },
            nbResults: {
                label: "Number of results to display",
                type: "int",
                default: 3,
            },
        },
        events: {
            save: () => {
                location.reload();
            },
            init: () => { },
        },
    });
    // Promise resolves when initialization completes
    const onInit = (config) => new Promise((resolve) => {
        let isInit = () => setTimeout(() => (config.isInit ? resolve() : isInit()), 0);
        isInit();
    });
    // Obsidian logo
    const logo = `<svg height="1em" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 256 256">
<style>
.purple { fill: #9974F8; }
@media (prefers-color-scheme: dark) { .purple { fill: #A88BFA; } }
</style>
<path class="purple" d="M94.82 149.44c6.53-1.94 17.13-4.9 29.26-5.71a102.97 102.97 0 0 1-7.64-48.84c1.63-16.51 7.54-30.38 13.25-42.1l3.47-7.14 4.48-9.18c2.35-5 4.08-9.38 4.9-13.56.81-4.07.81-7.64-.2-11.11-1.03-3.47-3.07-7.14-7.15-11.21a17.02 17.02 0 0 0-15.8 3.77l-52.81 47.5a17.12 17.12 0 0 0-5.5 10.2l-4.5 30.18a149.26 149.26 0 0 1 38.24 57.2ZM54.45 106l-1.02 3.06-27.94 62.2a17.33 17.33 0 0 0 3.27 18.96l43.94 45.16a88.7 88.7 0 0 0 8.97-88.5A139.47 139.47 0 0 0 54.45 106Z"/><path class="purple" d="m82.9 240.79 2.34.2c8.26.2 22.33 1.02 33.64 3.06 9.28 1.73 27.73 6.83 42.82 11.21 11.52 3.47 23.45-5.8 25.08-17.73 1.23-8.67 3.57-18.46 7.75-27.53a94.81 94.81 0 0 0-25.9-40.99 56.48 56.48 0 0 0-29.56-13.35 96.55 96.55 0 0 0-40.99 4.79 98.89 98.89 0 0 1-15.29 80.34h.1Z"/><path class="purple" d="M201.87 197.76a574.87 574.87 0 0 0 19.78-31.6 8.67 8.67 0 0 0-.61-9.48 185.58 185.58 0 0 1-21.82-35.9c-5.91-14.16-6.73-36.08-6.83-46.69 0-4.07-1.22-8.05-3.77-11.21l-34.16-43.33c0 1.94-.4 3.87-.81 5.81a76.42 76.42 0 0 1-5.71 15.9l-4.7 9.8-3.36 6.72a111.95 111.95 0 0 0-12.03 38.23 93.9 93.9 0 0 0 8.67 47.92 67.9 67.9 0 0 1 39.56 16.52 99.4 99.4 0 0 1 25.8 37.31Z"/></svg>
`;
    function omnisearch() {
        const port = gmc.get("port");
        const nbResults = gmc.get("nbResults");
        // Extract the ?q= part of the URL with URLSearchParams
        const params = new URLSearchParams(window.location.search);
        const query = params.get("q");
        if (!query)
            return;
        injectLoadingLabel();
        GM.xmlHttpRequest({
            method: "GET",
            url: `http://localhost:${port}/search?q=${query}`,
            headers: {
                "Content-Type": "application/json",
            },
            onload: function (res) {
                const data = JSON.parse(res.response);
                removeLoadingLabel(data.length > 0);
                // Keep the x first results
                data.splice(nbResults);
                const resultsDiv = $(`#${resultsDivId}`);
                // Delete all existing data-omnisearch
                $("[data-omnisearch-result]").remove();
                // Inject results
                for (const item of data) {
                    const url = `obsidian://open?vault=${encodeURIComponent(item.vault)}&file=${encodeURIComponent(item.path)}`;
                    const element = $(`
        <div data-omnisearch-result style="margin-bottom: 2rem;">

            <div>
                <a href="${url}" rel="noopener noreferrer" tabindex="-1" aria-hidden="true">
                    <div>
                        <span>${logo}Obsidian</span>&nbsp;<span>› ${item.path}</span>
                    </div>
                </a>
            </div>

            <div>
                <h2 style="font-size: var(--font-size-result-title-main); padding: 0;">
                    <a
                    title="${item.basename}"
                    href="${url}" rel="noopener noreferrer">
                        ${item.basename}
                    </a>
                </h3>
            </div>

            <div>
                <div>
                    <div>
                        ${item.excerpt.replaceAll("<br>", " ")}
                    </div>
                </div>
            </div>
        </div>`);
                    resultsDiv.append(element);
                }
            },
            onerror: function (res) {
                console.log("Omnisearch error", res);
                const span = $("#" + loadingSpanId)[0];
                if (span) {
                    span.innerHTML = `Error: Obsidian is not running or the Omnisearch server is not enabled.
          <br /><a href="Obsidian://open" style="color: var(--theme-col-about-link);">Open Obsidian</a>.`;
                }
            },
        });
    }
    function injectResultsContainer() {
        $(`#${resultsDivId}`).remove();
        const resultsDiv = $(`<div id="${resultsDivId}" style="color: var(--theme-col-txt-snippet); margin-bottom: 2em;"></div>`);
        $(sidebarSelector).prepend(resultsDiv);
    }
    function injectTitle() {
        const id = "OmnisearchObsidianConfig";
        if (!$("#" + id)[0]) {
            const btn = $(`<div style="margin-bottom: 1em;">
          <span style="font-size: 1.2em">${logo}&nbsp;Omnisearch results</span>
          <span style="font-size: 0.8em;">
            (<a id=${id} title="Settings" href="#">settings</a>)
          </span>
        </div>`);
            $(`#${resultsDivId}`).append(btn);
            $(document).on("click", "#" + id, function () {
                gmc.open();
            });
        }
    }
    function injectLoadingLabel() {
        if (!$("#" + loadingSpanId)[0]) {
            const label = $(`<span id=${loadingSpanId}>Loading...</span>`);
            $(`#${resultsDivId}`).append(label);
        }
    }
    function removeLoadingLabel(foundResults = true) {
        if (foundResults) {
            $("#" + loadingSpanId).remove();
        }
        else {
            $("#" + loadingSpanId).text("No result found");
        }
    }
    console.log("Loading Omnisearch injector");
    let init = onInit(gmc);
    init.then(() => {
        injectResultsContainer();
        injectTitle();
        waitForKeyElements("#layout-v2", omnisearch);
        omnisearch(); // Make an initial call, just to avoid an improbable race condition
        console.log("Loaded Omnisearch injector");
    });
})();