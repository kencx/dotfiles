// ==UserScript==
// @name          Redirect to Youtube Subscriptions
// @version       1.0
// @description   Redirect Home button to Youtube subscriptions page
// @include	      *://*.youtube.com/*
// @run-at        document-start
// @grant         none
// ==/UserScript==

let feedURL = '/feed/subscriptions';

if (window.location.pathname === "/") {
  window.location.replace(window.location.href + feedURL);
}

window.onload = function() {
  let bodyList = document.querySelector("body");
  let observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      document.querySelector("a#logo.yt-simple-endpoint.style-scope.ytd-topbar-logo-renderer").onclick = function() {
        window.location.replace("https://youtube.com" + feedURL);
        return false;
      };
    });
  });
  observer.observe(bodyList, {childList: true, subtree: true});
};

document.querySelector("a#logo.yt-simple-endpoint.style-scope.ytd-topbar-logo-renderer").onclick = function() {
  window.location.replace("https://youtube.com" + feedURL);
  return false;
};