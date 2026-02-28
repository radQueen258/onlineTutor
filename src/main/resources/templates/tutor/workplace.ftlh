<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Workplace - Name of the WebApp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        /* Sidebar */
        aside.sidebar {
            width: 280px;
            background-color: #113255;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 100;
        }

        .sidebar-brand { padding: 0 30px; font-size: 18px; font-weight: 700; margin-bottom: 60px; }

        .nav-menu { list-style: none; flex-grow: 1; }
        .nav-item {
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            gap: 8px;
        }

        .nav-item a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-item:hover {
            background-color: #8b6b45;
            border-radius: 10px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 14px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }


        /* Main Content */
        main.content {
            flex-grow: 1;
            margin-left: 280px;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        .card {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 40px 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        header.page-header {
            margin-bottom: 30px;
        }

        header.page-header h2 {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 10px;
            color: #000;
        }

        .create-resource-btn {
            display: inline-block;
            margin-bottom: 20px;
            background-color: #fbc02d;
            color: #000;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 700;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .create-resource-btn:hover { background-color: #e0a95f; }

        /* Table inside card */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            font-size: 16px;
            border-bottom: 1px solid #eee;
        }

        th {
            font-weight: 700;
            color: #333;
            background-color: transparent;
        }

        td a { color: #007bff; text-decoration: none; }
        td a:hover { text-decoration: underline; }

        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
        }

        @media (max-width: 1024px) {
            main.content { margin-left: 0; padding: 20px; }
            aside.sidebar { display: none; }
        }

        /* Pagination */
        .pagination {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .page-btn {
            padding: 8px 14px;
            background-color: #e9eef5;
            color: #113255;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
            border: none;
        }

        .page-btn:hover {
            background-color: #113255;
            color: white;
        }

        .page-btn.active {
            background-color: #113255;
            color: white;
        }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">Website Name</div>
    <ul class="nav-menu">
        <li class="nav-item active">
            <a href="/tutor/workplace">
                <i class="fa-solid fa-briefcase"></i>
                Workplace
            </a>
        </li>

        <li class="nav-item">
            <a href="/tutor/analytics">
                <i class="fa-solid fa-chart-line"></i>
                View Analytics
            </a>
        </li>

        <li class="nav-item">
            <a href="/chat/teacher">
                <i class="fa-solid fa-comments"></i>
                Help a Student
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/tutor/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main class="content">
    <header class="page-header">
        <h2>Welcome, ${tutorName}!</h2>
        <h2>Resources</h2>
        <a href="/tutor/resources/new" class="create-resource-btn">Create Resource</a>
    </header>

    <br>
    <div class="card">

        <#if resources?? && (resources?size > 0)>
            <table id="resourceTable">
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
                            <#else>0</#if>
                        </td>
                        <td>
                            <a href="/tutor/resources/${resource.id?c}/articles">View Articles</a>
                        </td>
                        <td>
                            <form action="/tutor/resources/${resource.id?c}/delete" method="post" style="display:inline;">
                                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this resource?');">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </#list>
            </table>
            <div class="pagination" id="pagination"></div>
        <#else>
            <p>No resources found yet. <a href="/tutor/resources/new">Create one now</a>.</p>
        </#if>
    </div>
</main>


<script>
    document.addEventListener("DOMContentLoaded", function () {

        const rowsPerPage = 5; // change this if you want
        const table = document.getElementById("resourceTable");
        const rows = table.querySelectorAll("tbody tr, tr:not(:first-child)");
        const pagination = document.getElementById("pagination");

        let currentPage = 1;
        const totalRows = rows.length;
        const totalPages = Math.ceil(totalRows / rowsPerPage);

        function displayPage(page) {
            currentPage = page;

            rows.forEach((row, index) => {
                row.style.display =
                    index >= (page - 1) * rowsPerPage &&
                    index < page * rowsPerPage
                        ? ""
                        : "none";
            });

            updatePaginationButtons();
        }

        function updatePaginationButtons() {
            const buttons = document.querySelectorAll(".page-btn");
            buttons.forEach(btn => btn.classList.remove("active"));
            buttons[currentPage - 1].classList.add("active");
        }

        function createPagination() {
            for (let i = 1; i <= totalPages; i++) {
                const button = document.createElement("button");
                button.innerText = i;
                button.classList.add("page-btn");
                button.addEventListener("click", () => displayPage(i));
                pagination.appendChild(button);
            }
        }

        if (totalRows > rowsPerPage) {
            createPagination();
            displayPage(1);
        }
    });
</script>

</body>
</html>
