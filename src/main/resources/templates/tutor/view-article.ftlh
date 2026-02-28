<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.articleTitle}</title>
    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f5f7fb;
            color: #333;
        }


        /* Main */
        main {
            flex-grow: 1;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .back-btn {
            font-size: 22px;
            color: #333;
            text-decoration: none;
        }

        .article-header {
            margin-bottom: 40px;
        }

        .article-title {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 20px;
        }

        .article-subtitle {
            font-size: 18px;
            font-weight: 700;
            color: #000;
        }

        .article-body {
            max-width: 800px;
            line-height: 1.5;
            font-size: 16px;
        }

        .article-body p {
            margin-bottom: 25px;
        }

        .article-layout {
            display: flex;
            gap: 50px;
            align-items: flex-start;
        }

        .article-text {
            flex: 2;
            line-height: 1.7;
            font-size: 16px;
        }

        .article-image {
            flex: 1;
            position: sticky;
            top: 120px;
        }

        .article-image img {
            width: 100%;
            max-width: 350px;
            height: auto;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        /* Watch Video Button */
        .watch-video-btn {
            position: absolute;
            right: 40px;
            top: 350px;
            background-color: #f4c542;
            color: #000;
            padding: 20px 25px;
            border-radius: 20px;
            font-weight: 700;
            width: 220px;
            text-align: center;
            text-decoration: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        @media (max-width: 1024px) {
            aside {
                display: none;
            }
            main {
                padding: 20px;
            }
            .watch-video-btn {
                position: static;
                margin-top: 30px;
                width: 100%;
            }
        }

        @media (max-width: 1024px) {
            .article-layout {
                flex-direction: column;
            }

            .article-image {
                position: static;
            }

            .article-image img {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>

    <main>
        <div class="header-actions">
            <a href="/tutor/resources/${resourceId?c}/articles" class="back-btn">
                <i class="fa-solid fa-arrow-left"></i>
            </a>
        </div>

        <div class="article-header">
            <h1 class="article-title">${article.articleTitle}</h1>
            <p class="article-subtitle">
                ${article.tutorName.firstName} – ${article.subject}
            </p>
        </div>

        <div class="article-layout">

            <div class="article-text">
                ${article.articleContent?no_esc}
            </div>

            <#if article.imageUrl?? && article.imageUrl?has_content>
                <div class="article-image">
                    <img src="${article.imageUrl}" alt="Article Illustration">
                </div>
            </#if>

        </div>

<#--        <div class="article-body">-->
<#--            <p>${article.articleContent?no_esc}</p>-->

<#--            <#if article.imageUrl??>-->
<#--                <div class="illustration-container">-->
<#--                    <img src="${article.imageUrl}" alt="Article Illustration">-->
<#--                </div>-->
<#--            </#if>-->
<#--        </div>-->

    </main>

</div>
</body>
</html>
