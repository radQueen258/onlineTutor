package com.example.onlinetutor.security.config;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private UserRepo userRepo;


    public SecurityConfig (PasswordEncoder passwordEncoder,
                           UserDetailsService userDetailsService) {
        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        return (request, response, authentication) -> {
            String email = authentication.getName();

            User user = userRepo.findByEmail(email)
                    .orElseThrow(()-> new RuntimeException("User not found"));

            request.getSession().setAttribute("userId", user.getId());

            if (user.getRole() == Role.TUTOR) {
                response.sendRedirect("/tutor/workplace");
                return;
            }

            if (user.getRole() == Role.ADMIN) {
                response.sendRedirect("/admin/dashboard");
                return;
            }

            if (user.getRole() == Role.STUDENT) {
                if (user.getAptitudeTestStatus() == AptitudeTestStatus.COMPLETED) {
                    response.sendRedirect("/dashboard");
                } else {
                    response.sendRedirect("/onboarding");
                }
                return;
            }


            response.sendRedirect("/login?error=unknown-role");

        };
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable());

        http.authorizeHttpRequests(auth -> auth
                .requestMatchers("/signUp").permitAll()
                .requestMatchers("/signIn").permitAll()
                .requestMatchers("/dashboard/**").hasAnyAuthority("STUDENT", "TEACHER", "ADMIN")
                .requestMatchers("/onboarding/**").permitAll()
                .requestMatchers("/setGoals/**").permitAll()
                .requestMatchers("/choose-test/**", "/videos/**"
                ,"/resources/**", "/article/**", "/exam-trends/**", "/study/**"
                , "/study-plan/**", "/submit/**", "/tutor/**","/admin/**", "/statistics").permitAll()
                .requestMatchers("/error").permitAll()
                .requestMatchers("/aptitude-test/**").permitAll()
                .anyRequest().permitAll()
        );

        http.formLogin(form -> form
                .loginPage("/signIn")
                .loginProcessingUrl("/signIn")
                .usernameParameter("email")
                .successHandler(customAuthenticationSuccessHandler())
                .failureUrl("/signIn?error")
                .permitAll()
        );

        return http.build();
    }


}
