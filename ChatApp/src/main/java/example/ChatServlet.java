package example;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // List to store chat messages in memory
    private static List<String> messages = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String message = request.getParameter("message");

        // Debugging: Log the received parameters
        System.out.println("Received POST Request - Username: " + username + ", Message: " + message); 

        // If username and message are valid, add the message to the list
        if (username != null && message != null && !message.trim().isEmpty()) {
            synchronized (messages) {
                messages.add("<b>" + username + ":</b> " + message);
                if (messages.size() > 100) { // Keep the list small (optional)
                    messages.remove(0); // Remove the oldest message if the list exceeds 100 messages
                }
            }
            System.out.println("Message Stored: " + messages); // Log stored messages for debugging
            response.setStatus(HttpServletResponse.SC_OK); // Respond with success
        } else {
            System.out.println("Empty or null message received"); // Log if no valid message was received
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Return a bad request status if data is invalid
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Set response content type to HTML
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Synchronize the message list to ensure thread safety
        synchronized (messages) {
            // Output all stored messages
            for (String msg : messages) {
                out.println("<p>" + msg + "</p>");
            }
        }
        
        // Log messages being sent to the client (for debugging)
        System.out.println("Messages Sent: " + messages);
    }
}
