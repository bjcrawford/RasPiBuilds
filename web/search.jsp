<!--
 Author: Brett Crawford <brett.crawford@temple.edu>
 File:   search.jsp
 Date:   Jan 28, 2015
 Desc:
-->

<%@page language="java" import="SQL.DbConn" %>
<%@page language="java" import="view.SearchView" %>
<%
    DbConn dbc = new DbConn();
    String userSelectOrError = dbc.getErr();
    String projectSelectOrError = "";
    String resultsTableOrError = "";
    String keyword = "";
    int userId = -1;
    int projectId = -1;
    int minPrice = -1;
    String minPriceValue = "";
    int maxPrice = -1;
    String maxPriceValue = "";
    String priceErrorClass = "";
    if (userSelectOrError.length() == 0) {
        
        if (request.getParameter("inputKeyword") != null) {
            keyword = request.getParameter("inputKeyword");
            userId = Integer.decode(request.getParameter("selectUser"));
            projectId = Integer.decode(request.getParameter("selectProject"));
            
            minPriceValue = request.getParameter("inputMinPrice");
            if (!minPriceValue.equals("")) {
                try {
                    minPrice = Integer.decode(minPriceValue);
                }
                catch (NumberFormatException e) {
                    minPrice = -1;
                    priceErrorClass = "has-error";
                }
            }
            
            maxPriceValue = request.getParameter("inputMaxPrice");
            if (!maxPriceValue.equals("")) {
                try {
                    maxPrice = Integer.decode(maxPriceValue);
                }
                catch (NumberFormatException e) {
                    maxPrice = -1;
                    priceErrorClass = "has-error";
                }
            }
        }
        
        userSelectOrError = SearchView.makeSelectFromUserNames("form-control", dbc, userId);
        projectSelectOrError = SearchView.makeSelectFromProjectNames("form-control", dbc, projectId);
        String tableClasses = "build-table table table-striped table-bordered table-responsive";
        resultsTableOrError = SearchView.makeTableFromSearchCriteria(tableClasses, 
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
                                           value="<%=minPriceValue%>">
                                    <div class="input-group-addon">.00</div>
                                </div>
                                <div class="input-group">
                                    <div class="input-group-addon">$</div>
                                    <input type="text" class="form-control" id="inputMaxPrice" 
                                           name="inputMaxPrice" placeholder="Enter maximum price"
                                           value="<%=maxPriceValue%>">
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
            