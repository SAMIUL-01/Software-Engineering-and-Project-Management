<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

    <main class="card">
        <div class="hero">
        <div class="hero-form">
        <h2><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 1l2.6 7.4L22 11l-7.4 2.6L12 21l-2.6-7.4L2 11l7.4-2.6Z"/></svg>Welcome!</h2>
        <div class="title-line"></div>
        <p>Answer four maths questions and see how high you can climb on the leaderboard.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert">${error}</div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/game">
            <input type="hidden" name="action" value="start">
            <label for="playerName"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="8" r="4.5"/><path d="M3.5 21c0-4.7 3.8-7.5 8.5-7.5s8.5 2.8 8.5 7.5Z"/></svg>Player name</label>
            <input type="text" id="playerName" name="playerName" maxlength="100"
                   placeholder="Enter your name" required autofocus>
            <button type="submit" class="btn"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 3.5v17L21 12Z"/></svg>Start Game</button>
        </form>
        </div>
        <div class="hero-art"><svg viewBox="0 0 160 200" fill="none" aria-hidden="true">
    <ellipse cx="80" cy="150" rx="75" ry="26" stroke="#19b8ff" stroke-width="3" opacity=".6" transform="rotate(-14 80 150)"/>
    <g transform="rotate(14 80 90)"><rect x="32" y="20" width="96" height="136" rx="14" fill="#0a3a9a" stroke="#19b8ff" stroke-width="4"/>
    <rect x="44" y="34" width="72" height="28" rx="6" fill="#0b57d8" stroke="#6cc8ff" stroke-width="2"/>
    <g fill="#19b8ff"><rect x="44" y="74" width="20" height="16" rx="4"/><rect x="70" y="74" width="20" height="16" rx="4"/><rect x="96" y="74" width="20" height="16" rx="4"/><rect x="44" y="98" width="20" height="16" rx="4"/><rect x="70" y="98" width="20" height="16" rx="4"/><rect x="96" y="98" width="20" height="16" rx="4"/><rect x="44" y="122" width="20" height="16" rx="4"/><rect x="70" y="122" width="20" height="16" rx="4"/><rect x="96" y="122" width="20" height="16" rx="4"/></g></g>
    <path d="M128 24l3 8 8 3-8 3-3 8-3-8-8-3 8-3Z" fill="#fff" opacity=".9"/>
</svg></div>
        </div>
    </main>

    <section class="card">
        <h3><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 6h10a5 5 0 0 1 4.9 4l1 5.2a3 3 0 0 1-5 2.7L16 16H8l-2.9 1.9a3 3 0 0 1-5-2.7l1-5.2A5 5 0 0 1 7 6Zm.2 3v1.6H5.6v1.8h1.6V14H9v-1.6h1.6v-1.8H9V9Zm8.8.2a1.2 1.2 0 1 0 0 2.4 1.2 1.2 0 0 0 0-2.4Zm2.6 2.4a1.2 1.2 0 1 0 0 2.4 1.2 1.2 0 0 0 0-2.4Z"/></svg>How to <em>play</em></h3>
        <table class="grid">
            <tr><th>Question</th><th>Topic</th><th>Marks</th></tr>
            <tr><td>Q1</td><td>Prime number (enter 1 = prime, 0 = not prime)</td><td>2</td></tr>
            <tr><td>Q2</td><td>Modulus (remainder of a whole-number division)</td><td>2</td></tr>
            <tr><td>Q3</td><td>Trigonometry: sin, cos or tan of an angle in degrees</td><td>3</td></tr>
            <tr><td>Q4</td><td>Trigonometry: sin, cos or tan of an angle in degrees</td><td>3</td></tr>
            <tr><td colspan="2"><b>Total</b></td><td><b>10</b></td></tr>
        </table>
        <p class="note">Difficulty: <span class="badge">NORMAL</span>
            &nbsp;Decimal answers may be off by up to 0.01.</p>
    </section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
