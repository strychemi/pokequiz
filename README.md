Welcome to PokeQuiz!
====================

What is it?
-----------

It is a fully-featured Ruby on Rails app that tests your knowledge of Pokemon!
Built in 1.5 days as part of an in-house [Viking Code School](http://www.vikingcodeschool.com/) hackathon.

Team:
* Andrew Baik
* Jeffrey Gisin
* Kelsey James
* Joshua David Masland-Sarani
* Samantha O'Keef

The app implements the following basic features:

* Web scraping via rake task (to pull individual pokemon images)
* Using the Mechanize Gem to make API calls to the [Pokemon API](http://pokeapi.co/)
* User authentication/authorization built from scratch(using the BCrypt Gem)
* Active record and SQL queries into the database for dashboard statistics (keeps track of user performance on quizzes and app-wide user statistics)
* Using the Paperclip gem alongside with Amazon S3 buckets for image upload handling.
* Generates quiz questions dynamically
* Sends a real email upon sign-up
* Delayed Jobs
* Basic search for users by email
* Self-reflective associations (Users can follow each other)
* Polymorphic associations (activity feed)
* Nested forms for user profiles
* Use of presenters for lean code in views

Getting started
---------------
[Heroku-Deployed Link](http://poke-quiz.herokuapp.com/users/new)

To get started, sign-up.

One you are logged in, you will be directed to a leaderboard which shows a variety of statics around active users, their Pokemon knowledge and performance.

Click the "Quiz Me" button in the upper left of the navigation bar to test your Pokemon knowledge.

To follow fellow Pokefans, use the search feature in the middle of the navigation bar to find others by their email. Click on the the link to the user page, select "follow user" button. Pokefans you follow will have their activities displayed in a feed on your leaderboard page.

To edit your profile, click on the "signed-in as" link to go to your profile page. You are able to make any changes from there.

Enjoy!
