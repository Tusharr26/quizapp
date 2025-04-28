<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        input, button {
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h2>Welcome to Java Chat</h2>
    <form action="chat.jsp" method="get">
        <label>Enter your name:</label>
        <input type="text" name="username" required />
        <button type="submit">Join Chat</button>
    </form>
</body>
</html>
