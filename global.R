library(shiny)
library(shinydashboard)
library(DBI)
library(RMariaDB)
library(ggplot2)
library(dplyr)

db_user <- Sys.getenv("DB_USER")
db_pass <- Sys.getenv("DB_PASS")
db_name <- Sys.getenv("DB_NAME")
db_host <- Sys.getenv("DB_HOST")
db_port <- as.numeric(Sys.getenv("DB_PORT"))

get_connection <- function() {
  dbConnect(
    MariaDB(),
    user = db_user,
    password = db_pass,
    dbname = db_name,
    host = db_host,
    port = db_port
  )
}

kaggle_df <- read.csv("gym_members_exercise_tracking.csv")