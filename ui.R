ui = dashboardPage(
  dashboardHeader(title = "Fitness Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      
      menuItem("My Dataset", icon = icon("user"),
        menuSubItem("My Workouts", tabName = "workout_chart", icon = icon("dumbbell")),
        menuSubItem("Cals Burned Over Time", tabName = "calorie_chart", icon = icon("fire"))),
      
      menuItem("Gym Dataset", icon = icon("users"),
               menuSubItem("BMI Distribution", tabName = "bmi_chart", icon = icon("weight-scale")),
               menuSubItem("Session Duration by Experience", tabName = "duration_chart", icon = icon("clock")),
               menuSubItem("Exercise Frequency — Women", tabName = "women_chart", icon = icon("female")),
               menuSubItem("Exercise Frequency — Men", tabName = "men_chart", icon = icon("male"))
      )
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "home",
        div(
          style = "text-align:center;",
          img(src = "fitness_banner.jpg", height = "400px")
        ),
        h2("Welcome to Your Fitness Dashboard!"),
        p("Track your workouts, calories, and more in one place.")
      ),
      tabItem(
        tabName = "workout_chart",
        h3("Workout Count Per Exercise"),
        plotOutput("exercise_plot")
      ),
      tabItem(
        tabName = "calorie_chart",
        h3("Calories Burned Over Time"),
        plotOutput("cal_plot")
      ),
      tabItem(
        tabName = "bmi_chart",
        h3("BMI Distribution"),
        plotOutput("bmi_plot")
      ),
      tabItem(
        tabName = "duration_chart",
        h3("Session Duration by Experience Level"),
        plotOutput("duration_plot")
      ),
      tabItem(
        tabName = "women_chart",
        h3("Exercise Frequency — Women aged 25-35"),
        plotOutput("exercise_women_25_35")
      ),
      tabItem(
        tabName = "men_chart",
        h3("Exercise Frequency — Men aged 25-35"),
        plotOutput("exercise_men_25_35")
      )
    )
  )
)

