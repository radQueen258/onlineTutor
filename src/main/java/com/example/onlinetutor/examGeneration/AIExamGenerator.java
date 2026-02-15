package com.example.onlinetutor.examGeneration;

import java.io.*;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.*;
import java.util.*;
import org.json.JSONObject;
import org.json.JSONArray;

public class AIExamGenerator {

    static String API_KEY = "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";
    static String MODEL = "deepseek/deepseek-chat";

    public static void main(String[] args) throws Exception {

        String subjectFolder = "C:\\Users\\Radka\\IdeaProjects\\onlineTutor\\outputPdfs\\Bio10";
        List<String> perguntas = carregarPerguntas(subjectFolder);

        Collections.shuffle(perguntas);

        List<String> selecionadas = perguntas.subList(0, Math.min(5, perguntas.size()));

        String exameGerado = gerarExameAI(selecionadas);

        Files.writeString(Path.of("exame_demo_Bio10.txt"), exameGerado);

        System.out.println("Exame demo gerado com sucesso!");
    }

    private static List<String> carregarPerguntas(String subjectFolder) throws IOException {

        List<String> perguntas = new ArrayList<>();

        File subject = new File(subjectFolder);
        File[] examFolders = subject.listFiles(File::isDirectory);

        if (examFolders == null) return perguntas;

        for (File exam : examFolders) {
            File[] questionFiles = exam.listFiles((dir, name) -> name.endsWith("_questions.txt"));

            if (questionFiles != null) {
                for (File qFile : questionFiles) {
                    perguntas.addAll(Files.readAllLines(qFile.toPath()));
                }
            }
        }

        return perguntas;
    }

    private static String gerarExameAI(List<String> perguntasBase) throws Exception {

        StringBuilder contexto = new StringBuilder();

        for (String q : perguntasBase) {
            contexto.append(q).append("\n");
        }

        String prompt = """
        Você é um especialista em criar exames nacionais.
        Com base nas perguntas abaixo (em português), gere um NOVO exame demo.
        
        Regras:
        - As perguntas devem ser diferentes mas do mesmo nível de dificuldade.
        - Manter o mesmo estilo de exame nacional.
        - Gerar 5 perguntas.
        - Tudo deve estar em Português.
        
        Perguntas base:
        """ + contexto;

        JSONObject body = new JSONObject();
        body.put("model", MODEL);

        JSONArray messages = new JSONArray();
        messages.put(new JSONObject()
                .put("role", "user")
                .put("content", prompt));

        body.put("messages", messages);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://openrouter.ai/api/v1/chat/completions"))
                .header("Authorization", "Bearer " + API_KEY)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();

        HttpClient client = HttpClient.newHttpClient();
        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        JSONObject responseJson = new JSONObject(response.body());

        return responseJson
                .getJSONArray("choices")
                .getJSONObject(0)
                .getJSONObject("message")
                .getString("content");
    }
}

