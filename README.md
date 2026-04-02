# Online Tutor for Mozambican National Exams using AI Technologies

This project is a full-stack educational platform designed to support students preparing for Mozambican national examinations, combining a Spring Boot backend with a web-based frontend and advanced LLM (Large Language Model) integration.


# Features

* AI-powered tutoring assistance
* Automatic demo exam generation (LLM-based)
* Automated grading of demo exams answers (LLM-based)
* Detailed feedback generation for student responses (LLM-based)
* Translation of educational articles (LLM-based)
* Real-time chat between students and teachers
* Image and Document sharing within chat
* AI-powered tutoring assistance
* Role-based system (Student / Teacher / Admin)


# AI Capabilities (Core Functionality)

The platform integrates an LLM to implement a complete intelligent learning cycle:

### Exam Generation

* Generates exam-style questions based on:

    * Subject
    * Difficulty
    * Curriculum constraints

### Feedback Generation

* Identifies mistakes
* Provides improvement suggestions

### Curriculum Alignment

* All generated content follows:

    * Mozambican syllabus
    * National exam format
    * Appropriate academic level

### Article Translation

* Translates educational content to your desired language
* Improves comprehension of complex materials


# Setup

## Prerequisites

* Java 17+
* Maven or Gradle
* PostgreSQL
* Visual Studio Code or IntelliJ IDEA

---

# Backend Setup

```bash
cd project-root
```

### Install dependencies

```bash
mvn clean install
```

### Configure database

Edit:

```
src/main/resources/application.properties
```

Example:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/your_db
spring.datasource.username=root
spring.datasource.password=your_password
```

### Run the server

```bash
mvn spring-boot:run
```


# Project Structure

```
/
├── src/
│   ├── main/
│   │   ├── java/              # Backend logic (controllers, services, models)
│   │   ├── resources/         # Configuration files
│   │   └── static/            # Frontend assets
│
├── pom.xml                    # Maven configuration
└── README.md
```

# Tech Stack

### Backend

* Java
* Spring Boot
* Spring MVC
* Spring Data JPA
* REST API

### Frontend

* HTML
* CSS
* JavaScript

### AI Integration

* LLM API (for:

    * exam generation
    * grading
    * feedback
    * translation
      )

### Database

* PostgreSQL


## System Focus: Mozambican Education

This platform is specifically designed to:

* Support students preparing for Mozambican national exams
* Provide curriculum-aligned practice material
* Simulate real exam conditions using AI
* Improve accessibility to educational resources


## Development

The application runs on:

* Backend: [http://localhost:3000](http://localhost:3000)


## License

This project is developed for academic purposes as part of a dissertation. All rights reserved.