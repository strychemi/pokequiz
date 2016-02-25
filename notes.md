Front page - sign up - new_user_path
  using modals for the form
  Signin/up/out in the navbar
  leaderboard on the main page (anonymous dashboard)

Dashboard - users_path
  customized based on current_user

  activities log

  leaderboard - top 10 table
    user name
    number answered
    number right
    number wrong
    right/total ratio

  user stats
    limited profile info
    number answered
    number of questions right
    number wrong
    top category
    weak category

  question stats
    total questions answered
    hardest questions
    easiest questions
    hardest categories
    easiest categories

User/Profile Info - user_path --> create_user_path, create profile based on nested form
  list of all info
  edit button
  delete account button

User/Profile Edit - edit_user_path --> update_user_path, update profile based on nested form
  same as profile but changeable

Question Ask page - new_result_path --> create_question_response
  Category
  question
  form to respond (create question response)

Question Answer page - result_path
  Same format as ask page
  Answer now highlighted
  message based on correct/incorrect
