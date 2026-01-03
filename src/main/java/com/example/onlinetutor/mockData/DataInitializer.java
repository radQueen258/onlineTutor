package com.example.onlinetutor.mockData;

import com.example.onlinetutor.enums.Gender;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.QuizQuestion;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private ArticleRepo articleRepo;
    @Autowired
    private StudyPlanRepo studyPlanRepo;
    @Autowired
    private QuizQuestionRepo quizQuestionRepo;


    @Override
    public void run(String... args) throws Exception {

        User user = userRepo.findByEmail("user11@example.com").orElse(null);

        Article mathBasics = new Article();
        Article geometryBasics = new Article();


        // --- 2. Create some articles ---
        if (articleRepo.count() != 0) {
            mathBasics = Article.builder()
                    .articleTitle("Introduction to Algebra")
                    .articleContent("""
                        Algebra is the branch of mathematics dealing with symbols and the rules for manipulating those symbols.
                        It helps to represent problems or situations in the form of mathematical expressions.
                    """)
                    .build();

            geometryBasics = Article.builder()
                    .articleTitle("Basic Geometry Concepts")
                    .articleContent("""
                        Geometry is the study of shapes, sizes, and properties of space.
                        You will learn about points, lines, angles, and basic shapes like triangles and circles.
                    """)
                    .build();

            articleRepo.saveAll(List.of(mathBasics, geometryBasics));

            // --- 3. Create study plans ---
            StudyPlan plan1 = StudyPlan.builder()
                    .article(mathBasics)
                    .user(user)
                    .progress(0)
                    .completed(false)
                    .build();

            StudyPlan plan2 = StudyPlan.builder()
                    .article(geometryBasics)
                    .user(user)
                    .progress(0)
                    .completed(false)
                    .build();

            studyPlanRepo.save(plan1);
            studyPlanRepo.save(plan2);

        }

        if (quizQuestionRepo.count() == 0) {
            // --- 4. Add sample quiz questions ---

            // Algebra quiz
            QuizQuestion q1 = QuizQuestion.builder()
                    .article(mathBasics)
                    .question("What does algebra primarily deal with?")
                    .wrongAnswer1("Numbers only")
                    .wrongAnswer2("Shapes and sizes")
                    .wrongAnswer3("Symbols and rules")
                    .correctAnswer("C")
                    .build();

            QuizQuestion q2 = QuizQuestion.builder()
                    .article(mathBasics)
                    .question("What is the main purpose of algebra?")
                    .wrongAnswer1("To cook")
                    .wrongAnswer2("To represent problems using symbols")
                    .wrongAnswer3("To measure distances")
                    .correctAnswer("B")
                    .build();

            QuizQuestion q3 = QuizQuestion.builder()
                    .article(mathBasics)
                    .question("Which of these is NOT part of algebra?")
                    .wrongAnswer1("Solving equations")
                    .wrongAnswer2("Using letters as variables")
                    .wrongAnswer3("Measuring angles")
                    .correctAnswer("C")
                    .build();

            // Geometry quiz
            QuizQuestion g1 = QuizQuestion.builder()
                    .article(geometryBasics)
                    .question("What does geometry study?")
                    .wrongAnswer1("Colors")
                    .wrongAnswer2("Shapes and space")
                    .wrongAnswer3("Numbers only")
                    .correctAnswer("B")
                    .build();

            QuizQuestion g2 = QuizQuestion.builder()
                    .article(geometryBasics)
                    .question("Which of these is a geometric shape?")
                    .wrongAnswer1("Triangle")
                    .wrongAnswer2("Variable")
                    .wrongAnswer3("Equation")
                    .correctAnswer("A")
                    .build();

            QuizQuestion g3 = QuizQuestion.builder()
                    .article(geometryBasics)
                    .question("A circle has how many sides?")
                    .wrongAnswer1("0")
                    .wrongAnswer2("2")
                    .wrongAnswer3("4")
                    .correctAnswer("A")
                    .build();

            quizQuestionRepo.saveAll(List.of(q1, q2, q3, g1, g2, g3));
        }

        System.out.println("Demo Study Plan generated for user: " + user.getEmail());

    }
}
