// ==UserScript==
// @name         Reddit search on DuckDuckGo
// @version      0.1.0
// @description  Adds a button to search Reddit posts with DuckDuckGo
// @include      http*://www.duckduckgo.*/*
// @include      http*://duckduckgo.*/*
// @run-at       document-end
// ==/UserScript==

// This script is modified from "Reddit search on Google".
// Credits to Mario O.M. at https://github.com/marioortizmanero/reddit-search-on-google/

// Change this to false if you don't want an icon
const useIcon = false;
// Change this to true if you want to add the button to the right of the 'Tools' button
const appendRight = false;

const queryRegex = /q=[^&]+/g;
const siteRegex = /\+site(?:%3A|\:).+\.[^&+]+/g;
const redditUrl = '+site%3Areddit.com';
let redditIcon = '';
const isImageSearch = /[?&]tbm=isch/.test(location.search);

if (typeof trustedTypes !== 'undefined') {
    const policy = trustedTypes.createPolicy('html', { createHTML: input => input });
    redditIcon = policy.createHTML(redditIcon);
}

(function() {
    // Creating the element
    let el = document.createElement('li');
    el.className = 'zcm__item';
    const link = document.createElement('a');
    link.className = 'zcm__link';

    // Adding the svg icon
    if (useIcon) {
        const span = document.createElement('span');
        span.className = isImageSearch ? 'm3kSL' : 'zcm__link__icon';
        span.style.cssText = 'display: block;margin-right: 5px;min-width: 11px;';
        span.innerHTML = redditIcon;
        link.appendChild(span);
    }

    // Hyperlink to add 'site:reddit.com' to the query
    link.appendChild(document.createTextNode('Reddit'));
    link.href = window.location.href.replace(queryRegex, (match) => {
        // Replaces the existing `site` flags
        return match.search(siteRegex) >= 0 ? match.replace(siteRegex, redditUrl) : match + redditUrl;
    });
    if (isImageSearch) {
        link.classList.add('NZmxZe');
        el = link;
    } else {
        el.appendChild(link);
    }

    // Inserting the element into DuckDuckGo search
    if (appendRight) {
        const toolsBtn = document.querySelector(isImageSearch ? '.ssfWCe' : '.zcm');
        toolsBtn.parentNode.insertBefore(el, toolsBtn.nextSibling);
    } else {
        const menuBar = document.querySelector(isImageSearch ? '.T47uwc' : '.zcm__menu.zcm__constant.has-zci');
        if (isImageSearch) {
            menuBar.insertBefore(el, menuBar.children[menuBar.childElementCount - 1]);
        } else {
            menuBar.appendChild(el);
        }
    }
})();
