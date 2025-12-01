server = function(input, output, session) {
  
  workout_data <- reactive({
    con <- get_connection()
    df <- dbGetQuery(con, "SELECT * FROM workout_log;")
    dbDisconnect(con)
    df
  })
  
  output$exercise_plot <- renderPlot({
    df <- workout_data()
    
    ggplot(df, aes(x = workout_type)) +
      geom_bar(fill = "darkcyan") +
      labs(
        title = "Workout Count by Exercise",
        x = "Exercise Type",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  output$cal_plot <- renderPlot({
    df <- workout_data()
    
    ggplot(df, aes(x = workout_date, y = calories)) +
      geom_line(color = "orange") +
      geom_point(color = "red") +
      labs(
        title = "Calories Burned Over Time", 
        x = "Date", 
        y = "Calories"
      ) +
      theme_minimal(base_size = 14)
  })
  
  df <- kaggle_df
  
  output$exercise_women_25_35 <- renderPlot({
    
    df_filtered <- df[df$Gender == "Female" & df$Age >= 25 & df$Age <= 35, ]
    
    ggplot(df_filtered, aes(x = Workout_Type)) +
      geom_bar(fill = "palevioletred") +
      labs(
        title = "Exercise Frequency — Women aged 25-35",
        x = "Workout Type",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  output$exercise_men_25_35 <- renderPlot({
    
    df_filtered <- df[df$Gender == "Male" & df$Age >= 25 & df$Age <= 35, ]
    
    ggplot(df_filtered, aes(x = Workout_Type)) +
      geom_bar(fill = "turquoise3") +
      labs(
        title = "Exercise Frequency — Men aged 25-35",
        x = "Workout Type",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  output$bmi_plot <- renderPlot({
    ggplot(df, aes(x = BMI)) +
      geom_histogram(bins = 30, fill = "steelblue") +
      labs(
        title = "Distribution of BMI",
        x = "BMI",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  output$duration_plot <- renderPlot({
    ggplot(df, aes(
      x = factor(Experience_Level),
      y = Session_Duration..hours.
    )) +
      geom_boxplot(fill = "coral1") +
      labs(
        title = "Session Duration by Experience Level",
        x = "Experience Level",
        y = "Hours"
      ) +
      theme_minimal(base_size = 14)
  })

}
