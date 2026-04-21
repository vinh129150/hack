// ==UserScript==
// @name          BaconHub
// @namespace     http://tampermonkey.net/
// @version       2.0
// @description   BaconHub Link Bypass
// @author        BaconHub
// @match         *://rekonise.com/*
// @match         *://auth.platorelay.com/*
// @match         *://auth.platoboost.app/*
// @match         *://auth.platoboost.me/*
// @match         *://go.linkify.ru/*
// @match         *://paste-drop.com/*
// @match         *://pastefy.app/*
// @match         *://scriptpastebins.com/*
// @match         *://pastebin.com/*
// @match         *://loot-link.com/*
// @match         *://loot-links.com/*
// @match         *://lootlink.org/*
// @match         *://lootlinks.co/*
// @match         *://lootdest.info/*
// @match         *://lootdest.org/*
// @match         *://lootdest.com/*
// @match         *://links-loot.com/*
// @match         *://linksloot.net/*
// @match         *://link-unlock.com/*
// @match         *://boost.ink/*
// @match         *://mboost.me/*
// @match         *://linkvertise.com/*/*
// @match         *://direct-link.net/*/*
// @match         *://link-hub.net/*/*
// @match         *://link-target.net/*/*
// @match         *://link-center.net/*/*
// @match         *://link-to.net/*/*
// @match         *://neoxsoftworks.eu/*
// @match         *://robloxscripts.gg/*
// @match         *://socialwolvez.com/*
// @match         *://sub2get.com/*
// @match         *://sub2unlock.com/*
// @match         *://sub2unlocksl.com/*
// @match         *://trigonevo.com/auth/android*
// @match         *://ntt-hub.xyz/key/ntt-hub.html?hwid=*
// @match         *://ntt-hub.xyz/key/ntt-hub?hwid=*
// @match         *://ldnesfspublic.org/*
// @match         *://blog.tapvietcode.com/*
// @match         *://link4sub.com/*
// @match         *://linkunlocker.com/*
// @match         *://rentry.co/*
// @match         *://scriptblox.club/*
// @match         *://scriptix.live/*
// @match         *://links.lootlabs.gg/*
// @match         *://lootlabs.gg/*
// @icon          https://i.ibb.co/LDjBMqVf/1769213061522-removebg-preview.png
// @grant         GM_xmlhttpRequest
// @connect       tranvinh.site
// @downloadURL   https://github.com/ron12373/userscript/raw/main/free.user.js
// @updateURL     https://github.com/ron12373/userscript/raw/main/free.user.js
// ==/UserScript==

(function () {
    'use strict';

    const MY_API = "https://tranvinh.site/api/bypass/skibidi/baconhub/userscript";
    const CF_IFRAME = "https://tranvinh.site/load-cf";

    const redirectDomains = [
        "linkvertise.com","direct-link.net","link-hub.net",
        "link-target.net","link-center.net","link-to.net"
    ];

    function shouldRedirect() {
        return redirectDomains.some(d => location.hostname.includes(d));
    }

    const style = document.createElement("style");
    style.innerHTML = `
@import url('https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;600;700&display=swap');
#bh-overlay{position:fixed;inset:0;z-index:2147483647;display:flex;align-items:center;justify-content:center;font-family:'Rajdhani',sans-serif;overflow:hidden}
#bh-bg{position:absolute;inset:0;background:#050508}
#bh-grid{position:absolute;inset:0;background-image:linear-gradient(rgba(80,40,200,0.07) 1px,transparent 1px),linear-gradient(90deg,rgba(80,40,200,0.07) 1px,transparent 1px);background-size:40px 40px;animation:gridMove 20s linear infinite}
@keyframes gridMove{0%{background-position:0 0}100%{background-position:0 40px}}
#bh-glow-1{position:absolute;width:500px;height:500px;border-radius:50%;background:radial-gradient(circle,rgba(120,40,255,0.15) 0%,transparent 70%);top:-100px;left:-100px;animation:glowFloat 8s ease-in-out infinite}
#bh-glow-2{position:absolute;width:400px;height:400px;border-radius:50%;background:radial-gradient(circle,rgba(0,150,255,0.1) 0%,transparent 70%);bottom:-80px;right:-80px;animation:glowFloat 10s ease-in-out infinite reverse}
@keyframes glowFloat{0%,100%{transform:translate(0,0)}50%{transform:translate(30px,30px)}}
#bh-card{position:relative;z-index:1;width:440px;max-width:92vw;background:rgba(8,8,16,0.95);border:1px solid rgba(120,60,255,0.4);border-radius:20px;overflow:hidden;box-shadow:0 0 0 1px rgba(120,60,255,0.1),0 40px 80px rgba(0,0,0,0.8),inset 0 1px 0 rgba(255,255,255,0.05)}
#bh-topbar{height:3px;background:linear-gradient(90deg,#7c3aed,#3b82f6,#06b6d4,#7c3aed);background-size:200% 100%;animation:barSlide 3s linear infinite}
@keyframes barSlide{0%{background-position:0% 0}100%{background-position:200% 0}}
#bh-inner{padding:28px 28px 24px}
#bh-header{display:flex;align-items:center;gap:14px;margin-bottom:22px}
#bh-logo-img{width:44px;height:44px;object-fit:contain;filter:drop-shadow(0 0 8px rgba(120,60,255,0.6))}
#bh-title-wrap{}
#bh-title{font-size:22px;font-weight:700;color:#fff;letter-spacing:1px;line-height:1}
#bh-version{font-size:11px;color:rgba(120,60,255,0.8);letter-spacing:2px;margin-top:3px}
#bh-divider{height:1px;background:linear-gradient(90deg,transparent,rgba(120,60,255,0.4),transparent);margin-bottom:20px}
#bh-urlbox{background:rgba(120,60,255,0.06);border:1px solid rgba(120,60,255,0.2);border-radius:10px;padding:10px 14px;margin-bottom:20px;display:flex;align-items:center;gap:8px}
#bh-url-icon{color:rgba(120,60,255,0.7);font-size:14px;flex-shrink:0}
#bh-url-text{font-size:11px;color:rgba(255,255,255,0.35);word-break:break-all;font-family:monospace;line-height:1.4}
#bh-captcha-section{margin-bottom:18px}
#bh-captcha-label{font-size:12px;color:rgba(255,255,255,0.4);letter-spacing:2px;text-transform:uppercase;margin-bottom:10px}
#bh-iframe-wrap{background:rgba(0,0,0,0.4);border:1px solid rgba(120,60,255,0.2);border-radius:12px;padding:12px;display:flex;justify-content:center}
#bh-iframe{width:305px;height:65px;border:none;border-radius:8px;display:block}
#bh-status{display:none;align-items:center;justify-content:center;gap:10px;padding:14px;background:rgba(120,60,255,0.08);border:1px solid rgba(120,60,255,0.2);border-radius:12px;margin-bottom:10px}
.bh-spinner{width:16px;height:16px;border:2px solid rgba(120,60,255,0.3);border-top:2px solid #7c3aed;border-radius:50%;animation:spin .7s linear infinite;flex-shrink:0}
@keyframes spin{to{transform:rotate(360deg)}}
#bh-status-text{font-size:14px;color:#a78bfa;font-weight:600;letter-spacing:.5px}
#bh-result{display:none;padding:14px 16px;border-radius:12px;font-size:13px;word-break:break-word;white-space:pre-wrap;max-height:180px;overflow-y:auto;line-height:1.5}
.bh-success{background:rgba(16,185,129,0.08);border:1px solid rgba(16,185,129,0.3);color:#6ee7b7}
.bh-error{background:rgba(239,68,68,0.08);border:1px solid rgba(239,68,68,0.3);color:#fca5a5}
#bh-footer{padding:12px 28px;background:rgba(0,0,0,0.3);border-top:1px solid rgba(255,255,255,0.04);display:flex;align-items:center;justify-content:space-between}
#bh-footer-left{font-size:10px;color:rgba(255,255,255,0.2);letter-spacing:1.5px}
#bh-footer-right{display:flex;align-items:center;gap:6px}
.bh-dot{width:6px;height:6px;border-radius:50%;background:#10b981;box-shadow:0 0 6px #10b981;animation:pulse 2s ease-in-out infinite}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.3}}
#bh-footer-status{font-size:10px;color:#10b981;letter-spacing:1px}
.hidden{display:none!important}
`;
    document.head.appendChild(style);

    const overlay = document.createElement("div");
    overlay.id = "bh-overlay";
    overlay.innerHTML = `
<div id="bh-bg"></div>
<div id="bh-grid"></div>
<div id="bh-glow-1"></div>
<div id="bh-glow-2"></div>
<div id="bh-card">
  <div id="bh-topbar"></div>
  <div id="bh-inner">
    <div id="bh-header">
      <img id="bh-logo-img" src="https://i.ibb.co/LDjBMqVf/1769213061522-removebg-preview.png">
      <div id="bh-title-wrap">
        <div id="bh-title">BACONHUB</div>
        <div id="bh-version">BYPASS ENGINE v2.0</div>
      </div>
    </div>
    <div id="bh-divider"></div>
    <div id="bh-urlbox">
      <div id="bh-url-icon">🔗</div>
      <div id="bh-url-text">${location.href}</div>
    </div>
    <div id="bh-captcha-section">
      <div id="bh-captcha-label">Security Verification</div>
      <div id="bh-iframe-wrap">
        <iframe id="bh-iframe" src="${CF_IFRAME}" scrolling="no"></iframe>
      </div>
    </div>
    <div id="bh-status">
      <div class="bh-spinner"></div>
      <span id="bh-status-text">Bypassing link...</span>
    </div>
    <div id="bh-result"></div>
  </div>
  <div id="bh-footer">
    <div id="bh-footer-left">TRANVINH.SITE</div>
    <div id="bh-footer-right">
      <div class="bh-dot"></div>
      <div id="bh-footer-status">ONLINE</div>
    </div>
  </div>
</div>
`;
    document.body.appendChild(overlay);

    const iframeWrap = document.getElementById("bh-iframe-wrap");
    const captchaSection = document.getElementById("bh-captcha-section");
    const statusEl = document.getElementById("bh-status");
    const statusText = document.getElementById("bh-status-text");
    const resultEl = document.getElementById("bh-result");

    function showError(msg) {
        statusEl.style.display = "none";
        resultEl.style.display = "block";
        resultEl.className = "bh-error";
        resultEl.textContent = "❌ " + msg;
    }

    function sendToApi(token) {
        captchaSection.classList.add("hidden");
        statusEl.style.display = "flex";

        GM_xmlhttpRequest({
            method: "POST",
            url: MY_API,
            headers: { "Content-Type": "application/json" },
            data: JSON.stringify({ url: location.href, token }),
            onload: function (res) {
                try {
                    const data = JSON.parse(res.responseText);
                    if (data.status === "success") {
                        const result = data.result;

                        if (result.startsWith("http") && shouldRedirect()) {
                            statusText.textContent = "Redirecting...";
                            const encoded = btoa(result);
                            location.href = "https://linkvertise.com/access/1229176/kiciahook-kiciahook?hash=" + encoded;
                            return;
                        }

                        if (result.startsWith("http")) {
                            statusText.textContent = "Redirecting...";
                            setTimeout(() => { location.href = result; }, 600);
                            return;
                        }

                        statusEl.style.display = "none";
                        resultEl.style.display = "block";
                        resultEl.className = "bh-success";
                        resultEl.textContent = "✅ " + result;
                    } else {
                        showError(data.message || "Unknown error");
                    }
                } catch (e) {
                    showError("Parse error: " + e.message);
                }
            },
            onerror: function () { showError("Request failed"); },
            ontimeout: function () { showError("Request timed out"); },
            timeout: 20000
        });
    }

    window.addEventListener("message", e => {
        if (e.data && (e.data.type === "CF_SOLVED" || e.data.type === "TURNSTILE_SOLVED")) {
            sendToApi(e.data.token);
        }
    });

})();
