<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
         import="java.util.List, java.text.SimpleDateFormat, model.GameScore, util.Html" %>
<%
    @SuppressWarnings("unchecked")
    List<GameScore> scores = (List<GameScore>) request.getAttribute("scores");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, HH:mm:ss");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

    <main class="card">
        <h2><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 2h10v2h4v3a5 5 0 0 1-4.3 4.9A5.5 5.5 0 0 1 13 15.5V18h3v3H8v-3h3v-2.5a5.5 5.5 0 0 1-3.7-3.6A5 5 0 0 1 3 7V4h4Zm-2 4v1a3 3 0 0 0 2 2.8V6Zm14 0h-2v3.8A3 3 0 0 0 19 7Z"/></svg>Top 10 Leaderboard</h2>
        <div class="title-line"></div>

        <% if (request.getAttribute("dbError") != null) { %>
            <div class="alert">${dbError}</div>
        <% } else if (scores == null || scores.isEmpty()) { %>
            <p>No scores yet. Be the first to play!</p>
        <% } else { %>
            <div class="scroll">
            <table class="grid">
                <tr><th>Rank</th><th>Player</th><th>Score</th><th>Difficulty</th><th>Date / Time</th></tr>
                <% int rank = 1; for (GameScore gs : scores) { %>
                <tr>
                    <td><%= rank++ %></td>
                    <td><%= Html.escape(gs.getPlayerName()) %></td>
                    <td><b><%= gs.getScore() %></b> / 10</td>
                    <td><%= Html.escape(gs.getDifficulty()) %></td>
                    <td><%= gs.getPlayedAt() == null ? "" : dateFormat.format(gs.getPlayedAt()) %></td>
                </tr>
                <% } %>
            </table>
            </div>
        <% } %>

        <div class="actions">
            <a class="btn" href="${pageContext.request.contextPath}/index.jsp"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 3.5v17L21 12Z"/></svg>Play Game</a>
        </div>
    </main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
