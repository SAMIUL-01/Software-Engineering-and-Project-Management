<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
         import="java.util.List, model.QuestionResult, util.Html" %>
<%
    // Opened directly without finishing a game? Go back to the welcome page.
    @SuppressWarnings("unchecked")
    List<QuestionResult> results = (List<QuestionResult>) request.getAttribute("results");
    if (results == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    int score = (Integer) request.getAttribute("score");
    int maxScore = (Integer) request.getAttribute("maxScore");
    boolean saved = Boolean.TRUE.equals(request.getAttribute("saved"));
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

    <main class="card center">
        <h2><svg viewBox="0 0 24 24" aria-hidden="true" style="fill:none;stroke:#19b8ff;stroke-width:1.8;stroke-linecap:round;stroke-linejoin:round"><circle cx="12" cy="12" r="10"/><path d="m7.5 12.5 3 3 6-7"/></svg>Result</h2>
        <div class="title-line"></div>
        <p class="player">Player: <b><%= Html.escape((String) request.getAttribute("playerName")) %></b></p>
        <div class="score"><%= score %> <span>/ <%= maxScore %></span></div>
        <p class="diff" style="justify-content:center">Difficulty: <span class="badge">${difficulty}</span></p>
        <div class="verdict">
            <svg viewBox="0 0 120 100" fill="none" aria-hidden="true">
    <path d="M12 70C0 55 2 30 14 18M20 78C6 66 4 44 10 30M108 70c12-15 10-40-2-52M100 78c14-12 16-34 10-48" stroke="#19b8ff" stroke-width="3" stroke-linecap="round"/>
    <path fill="#19b8ff" d="M38 14h44v6h14v12c0 9-7 16-16 17-3 6-9 10-14 11v10h12v8H42v-8h12V60c-5-1-11-5-14-11-9-1-16-8-16-17V20h14Zm-8 12h-6v6c0 4 3 7 7 8Zm60 0h-8v14c4-1 8-4 8-8Z"/>
</svg>
            <div>
            <% if (score == maxScore) { %>
                <p class="good">Perfect score! Well done!</p>
            <% } else if (score >= 6) { %>
                <p class="good">Great job!</p>
            <% } else { %>
                <p>Keep practising &ndash; you can do better next time!</p>
            <% } %>
            <% if (saved) { %>
                <span class="note">Your score was saved to the leaderboard database.</span>
            <% } %>
            </div>
        </div>
        <% if (!saved) { %>
            <div class="alert">Your score could not be saved to the database.
                Check that MySQL is running and the settings in ScoreDAO.java are correct.</div>
        <% } %>
    </main>

    <section class="card">
        <h3><svg viewBox="0 0 24 24" aria-hidden="true"><rect x="2" y="12" width="5" height="10" rx="1"/><rect x="9.5" y="3" width="5" height="19" rx="1"/><rect x="17" y="8" width="5" height="14" rx="1"/></svg>Your answers</h3>
        <div class="scroll">
        <table class="grid">
            <tr><th>Question</th><th>Your answer</th><th>Correct answer</th><th>Marks</th></tr>
            <% for (QuestionResult r : results) { %>
            <tr class="<%= r.isCorrect() ? "ok" : "bad" %>">
                <td><%= Html.escape(r.getQuestion()) %></td>
                <td><%= Html.escape(r.getYourAnswer()) %></td>
                <td><%= Html.escape(r.getCorrectAnswer()) %></td>
                <td><%= r.getMarks() %> / <%= r.getMaxMarks() %></td>
            </tr>
            <% } %>
        </table>
        </div>
        <div class="actions">
            <a class="btn" href="${pageContext.request.contextPath}/index.jsp"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 3.5v17L21 12Z"/></svg>Play Again</a>
            <a class="btn alt" href="${pageContext.request.contextPath}/leaderboard">View Leaderboard</a>
        </div>
    </section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
