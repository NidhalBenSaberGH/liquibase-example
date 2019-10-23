package com.example.project0;

import liquibase.integration.spring.SpringLiquibase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.ResourceLoader;
import javax.sql.DataSource;

@Configuration
@PropertySource("classpath:liquibase.properties")
public class LiquibaseConfig {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private ResourceLoader resourceLoader;

    @Value("${changeLogFile}")
    private String changelogFile;


    @Value("${url}")
    private String url;

    @Value("${username}")
    private String username;

    @Value("${password}")
    private String password;

    @Value("${driver}")
    private String driver;

    @Value("${outputChangeLogFile}")
    private String outputChangeLogFile;

    @Value("${liquibase.logging}")
    private String liquibaseLogging;

    @Value("${liquibase.verbose}")
    private boolean liquibaseVerbose;

    @Value("${liquibase.contexts}")
    private String contexts;

    @Value("${liquibase.schema}")
    private String schema;

    @Bean
    public SpringLiquibase liquibase() {
        final SpringLiquibase liquibase = new SpringLiquibase();
        liquibase.setChangeLog(changelogFile);
        liquibase.setContexts(contexts);
        liquibase.setDefaultSchema(schema);
        liquibase.setDataSource(dataSource);

        return liquibase;
    }

}
