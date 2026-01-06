server = function(input, output, session) {
  
  workout_data = reactive({
    con = get_connection()
    df = dbGetQuery(con, "SELECT * FROM workout_log;")
    dbDisconnect(con)
    df
  })
  
  # Clean data by removing missing or invalid values
  clean_workout_data = reactive({
    df = workout_data()
    
    df = df[!is.na(df$workout_date) &
              !is.na(df$calories) &
              df$calories >= 0, ]
    
    df
  })
  
  kaggle_data = kaggle_df
  
  # KPIs
  output$total_workouts = renderValueBox({
    valueBox(
      value = nrow(clean_workout_data()),
      subtitle = "Total Workouts",
      icon = icon("dumbbell"),
      color = "aqua"
    )
  })

  output$avg_calories = renderValueBox({
    valueBox(
      value = round(mean(clean_workout_data()$calories), 1),
      subtitle = "Avg Calories / Workout",
      icon = icon("fire"),
      color = "navy"
    )
  })

  output$workouts_per_week = renderValueBox({
    df = clean_workout_data()
    weeks = length(unique(format(as.Date(df$workout_date), "%Y-%U")))

    valueBox(
      value = round(nrow(df) / weeks, 1),
      subtitle = "Workouts per Week",
      icon = icon("calendar"),
      color = "green"
    )
  })
  
  # Workout Count Per Exercise
  output$exercise_plot = renderPlot({
    df = clean_workout_data()
    
    ggplot(df, aes(x = workout_type)) +
      geom_bar(fill = "darkcyan") +
      labs(
        title = "Workout Count by Exercise",
        x = "Exercise Type",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  # Calories Burned Over Time
  output$cal_plot = renderPlot({
    df = clean_workout_data()
    df = df[order(df$workout_date), ]
    
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
  
  # BMI Distribution
  output$bmi_plot = renderPlot({
    ggplot(kaggle_data, aes(x = BMI)) +
      geom_histogram(bins = 30, fill = "steelblue") +
      labs(
        title = "Distribution of BMI",
        x = "BMI",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  # Session Duration by Experience Level
  output$duration_plot = renderPlot({
    ggplot(
      kaggle_data,
      aes(
        x = factor(Experience_Level),
        y = Session_Duration..hours.
      )
    ) +
      geom_boxplot(fill = "coral1") +
      labs(
        title = "Session Duration by Experience Level",
        x = "Experience Level",
        y = "Hours"
      ) +
      theme_minimal(base_size = 14)
  })
  
  # Exercise Frequency — Women aged 25-35
  output$exercise_women_25_35 = renderPlot({
    kaggle_data_filtered = kaggle_data[
      kaggle_data$Gender == "Female" &
        kaggle_data$Age >= 25 &
        kaggle_data$Age <= 35,
    ]
    
    ggplot(kaggle_data_filtered, aes(x = Workout_Type)) +
      geom_bar(fill = "palevioletred") +
      labs(
        title = "Exercise Frequency — Women aged 25–35",
        x = "Workout Type",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
  # Exercise Frequency — Men aged 25-35
  output$exercise_men_25_35 = renderPlot({
    kaggle_data_filtered = kaggle_data[
      kaggle_data$Gender == "Male" &
        kaggle_data$Age >= 25 &
        kaggle_data$Age <= 35,
    ]
    
    ggplot(kaggle_data_filtered, aes(x = Workout_Type)) +
      geom_bar(fill = "turquoise3") +
      labs(
        title = "Exercise Frequency — Men aged 25–35",
        x = "Workout Type",
        y = "Count"
      ) +
      theme_minimal(base_size = 14)
  })
  
}

