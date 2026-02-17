//package com.example.onlinetutor.mockData;
//
//import com.example.onlinetutor.enums.Subject;
//import com.example.onlinetutor.services.ExamQuestionServiceImpl;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.stereotype.Component;
//
//@Component
//public class ExamDataBase implements CommandLineRunner {
//
//    @Autowired
//    private ExamQuestionServiceImpl questionImportService;
//
//    @Override
//    public void run(String... args) throws Exception {
//        System.out.println("Starting question import...");
//
//        // Replace these paths with the actual folders on your computer
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Bio10", Subject.BIOLOGY);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Chem10", Subject.CHEMISTRY);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Phy10", Subject.PHYSICS);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Port10", Subject.PORTUGUESE);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Ing10", Subject.ENGLISH);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Math10", Subject.MATH);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Hist10", Subject.HISTORY);
//        questionImportService.importQuestionsFromFolder("C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Geo10", Subject.GEOGRAPHY);
//
//
//        System.out.println("Question import finished.");
//    }
//}
