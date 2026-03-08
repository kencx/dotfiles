// ==UserScript==
// @name          Always Nitter
// @version       1.0
// @description   Redirect to Nitter
// @match         *://*.twitter.com/*
// @match         *://*.x.com/*
// @run-at        document-start
// @grant         none
// ==/UserScript==

window.location.replace("https://nitter.net" + window.location.pathname + window.location.search);