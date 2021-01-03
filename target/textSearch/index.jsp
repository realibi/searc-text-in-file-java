<%--
  Created by IntelliJ IDEA.
  User: realibi
  Date: 02-Jan-21
  Time: 4:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Text search</title>
    <script
            src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</head>
<body>

<h2>Files</h2>
<input type="text" id="searchTextInput">
<button onclick="searchText()">Search</button>

<div class="files"></div>

<script>
    $(document).ready(function(){
        loadFiles();
    });

    const clearFilesBlock = () => {
        $(".files").empty()
    }

    const loadFiles = () => {
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath() %>/api/files",
            success: function(result){
                console.log(result);
                for(let i = 0; i < result.length; i++) {
                    $(".files").append(
                        "<p>" + result[i] + "</p>"
                    );
                }
            }
        });
    }

    const searchText = () => {
        clearFilesBlock();

        const searchText = $("#searchTextInput").val();

        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath() %>/api/files/search/" + searchText,
            success: function(result){
                console.log(result);
                for(let i = 0; i < result.length; i++){
                    Object.keys(result[i]).forEach(function(key) {
                        const value = result[i][key];
                        $(".files").append(
                            "<p>" + key + ": " + value.toString() + "</p>"
                        );
                    });
                }
            }
        });
    }
</script>

</body>
</html>
