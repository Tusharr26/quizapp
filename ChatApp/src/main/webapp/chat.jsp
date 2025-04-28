<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%
    String username = request.getParameter("username");
    if (username == null || username.trim().isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        #chatBox {
            width: 60%;
            height: 300px;
            border: 1px solid black;
            overflow-y: scroll;
            margin: auto;
            padding: 10px;
            background: #f9f9f9;
        }
        input, button {
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h2>Chat Room - Welcome, <%= username %>!</h2>
    <div id="chatBox"></div>
    
    <form id="chatForm">
        <input type="hidden" id="username" value="<%= username %>">
        <input type="text" id="message" placeholder="Type your message..." required>
        <button type="submit">Send</button>
    </form>

    <script>
        const chatBox = document.getElementById("chatBox");
        const chatForm = document.getElementById("chatForm");

        // Fetch messages from ChatServlet
        function fetchMessages() {
            fetch("ChatServlet")
                .then(response => response.text())
                .then(data => {
                    console.log("Fetched Messages:", data);  // Debugging
                    chatBox.innerHTML = data;
                    chatBox.scrollTop = chatBox.scrollHeight;
                })
                .catch(error => console.error("Error fetching messages:", error));
        }

        // Handle form submission
        chatForm.addEventListener("submit", function (event) {
            event.preventDefault();
            const username = document.getElementById("username").value;
            const message = document.getElementById("message").value;

            console.log("Sending Message:", username, message);  // Debugging

            if (username && message) {
                fetch("ChatServlet", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: `username=${encodeURIComponent(username)}&message=${encodeURIComponent(message)}`
                })
                .then(() => {
                    document.getElementById("message").value = ""; // Clear message input
                    fetchMessages(); // Fetch updated messages
                })
                .catch(error => console.error("Error sending message:", error));
            } else {
                console.log("Username or Message is empty");  // Debugging
            }
        });

        // Fetch messages initially and at regular intervals
        fetchMessages();
        setInterval(fetchMessages, 1000); // Fetch messages every 1 second
    </script>
</body>
</html>
