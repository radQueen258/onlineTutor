<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor Workplace</title>
</head>
<body>

<!-- Sidebar -->
<div style="width:220px;float:left;background:#0f2b4c;color:white;height:100vh;">
    <h3 style="padding:10px;">Website Name</h3>
    <ul style="list-style:none;padding:0;">
<#--        <li><a href="/tutor/article/new" style="color:white;text-decoration:none;">Create New Article</a></li>-->
        <li><a href="/tutor/analytics" style="color:white;text-decoration:none;">View Analytics</a></li>
    </ul>

    <form action="/logout" method="post">
        <button type="submit" style="
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;">
            Logout
        </button>
    </form>
</div>

<div style="margin-left:240px;padding:20px;">

    <h2>Welcome, ${tutorName}!</h2>

    <h2>Resources</h2>
    <a href="/tutor/resources/new" style="color:black;text-decoration:none;">Create Resource</a>

    <#if resources?? && (resources?size > 0)>
        <table border="1" cellpadding="5" style="width:100%; border-collapse: collapse;">
            <tr>
                <th>Resource Name</th>
                <th>Number of Articles</th>
                <th>Actions</th>
                <th>Deleted</th>
            </tr>

            <#list resources as resource>
                <tr>
                    <td>${resource.topicName!'-'}</td>
                    <td>
                        <#if resource.articles?? && (resource.articles?size > 0)>
                        ${resource.articles?size}
                        <#else>
                        0
                        </#if>
                    </td>
                    <td>
                        <a href="/tutor/resources/${resource.id}/articles"
                           style="color: #007bff; text-decoration: none;">View Articles</a>
                    </td>

                    <td>
                        <form action="/tutor/resources/${resource.id}/delete" method="post" style="display:inline;">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this resource?');">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </#list>
        </table>
    <#else>
        <p>No resources found yet. <a href="/tutor/resources/new">Create one now</a>.</p>
    </#if>


</div>
</body>
</html>
