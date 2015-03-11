<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   search.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="sql.DbConn" %>
<%@page language="java" import="view.SearchView" %>
<%
    DbConn dbc = new DbConn();
    String userSelectOrError = "";
    String projectSelectOrError = "";
    String resultsTableOrError = "";
    String keyword = "";
    int userId = -1;
    int projectId = -1;
    int minPrice = -1;
    String minPriceStr = "";
    int maxPrice = -1;
    String maxPriceStr = "";
    String priceErrorClass = "";
    
    if (dbc.getErr().length() == 0) { // If we have a database connection
        
        if (request.getParameter("inputKeyword") != null) { // If we have postback data
            
            keyword = request.getParameter("inputKeyword");
            userId = Integer.decode(request.getParameter("selectUser"));
            projectId = Integer.decode(request.getParameter("selectProject"));
            
            minPriceStr = request.getParameter("inputMinPrice");
            if (!minPriceStr.equals("")) {
                try {
                    minPrice = Integer.decode(minPriceStr);
                }
                catch (NumberFormatException e) {
                    minPrice = -1;
                    priceErrorClass = "has-error";
                }
            }
            
            maxPriceStr = request.getParameter("inputMaxPrice");
            if (!maxPriceStr.equals("")) {
                try {
                    maxPrice = Integer.decode(maxPriceStr);
                }
                catch (NumberFormatException e) {
                    maxPrice = -1;
                    priceErrorClass = "has-error";
                }
            }
        }
        
        userSelectOrError = SearchView.makeSelectFromUserNames("form-control", dbc, userId);
        projectSelectOrError = SearchView.makeSelectFromProjectNames("form-control", dbc, projectId);
        resultsTableOrError = SearchView.makeTableFromSearchCriteria(
                "build-table table table-striped table-bordered table-responsive", 
                dbc, keyword, userId, projectId, minPrice, maxPrice);
    }
    dbc.close();
%>

<jsp:include page="pre-content.jsp"></jsp:include>
            <div class="content">
                <div id="page" class="search" display="none"></div>
                <div class="content-text">
                    <h2>Search for builds</h2>
                    <p>
                        Use the form below to search through our database in order
                        to find a build using the specified criteria.
                    </p>
                    <form name="searchForm" method="get" action="">
                        <div class="form-group">
                            <label for="inputKeyword">Select a keyword:</label>
                            <input type="text" class="form-control" id="inputKeyword" 
                                   name="inputKeyword" placeholder="Enter a keyword" 
                                   value="<%=keyword%>">
                        </div>
                        <div class="form-group">
                            <label for="selectUser">Select a user:</label>
                            <%=userSelectOrError%>
                        </div>
                        <div class="form-group">
                            <label for="selectProject">Select a project:</label>
                            <%=projectSelectOrError%>
                        </div>
                        <div class="form-group <%=priceErrorClass%>">
                            <label class="control-label" for="">Select a build price range:</label>
                            <div class="form-inline">
                                <div class="input-group">
                                    <div class="input-group-addon">$</div>
                                    <input type="text" class="form-control" id="inputMinPrice" 
                                           name="inputMinPrice" placeholder="Enter minimum price"
                                           value="<%=minPriceStr%>">
                                    <div class="input-group-addon">.00</div>
                                </div>
                                <div class="input-group">
                                    <div class="input-group-addon">$</div>
                                    <input type="text" class="form-control" id="inputMaxPrice" 
                                           name="inputMaxPrice" placeholder="Enter maximum price"
                                           value="<%=maxPriceStr%>">
                                    <div class="input-group-addon">.00</div>
                                </div>
                            </div>
                        </div>
                        <input type="submit" class="btn btn-default" value="Search">
                    </form>
                    <h3>Results</h3>
                    <div class="table-responsive">
                        <%=resultsTableOrError%>
                    </div>
                </div>
<jsp:include page="post-content.jsp"></jsp:include>
            