<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Waiting Room</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #f8f9fa;}
        .container { display: inline-block; padding: 40px; background: white; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);}
        h1 { color: #0f2b4c; }
        p { font-size: 16px; }
        .spinner {
            border: 8px solid #f3f3f3;
            border-top: 8px solid #0f2b4c;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin { 100% { transform: rotate(360deg); } }
    </style>
    <script>
        const userId = ${userId};
        // Poll every 3 seconds
        setInterval(async () => {
            const res = await fetch(`/signup/status/${userId}`);
            const data = await res.json();
            if (data.verified) {
                window.location.href = "/onboarding";
            }
        }, 3000);
    </script>
</head>
<body>
<div class="container">
    <h1>Thank you for registering!</h1>
    <p>Please wait while we verify your account...</p>
    <div class="spinner"></div>
</div>
</body>
</html>
