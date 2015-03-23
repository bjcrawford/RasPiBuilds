<% 
    session.invalidate();
    try {
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        System.out.println("**** Exception was thrown in signout.jsp: " + e.getMessage());
    }
%>